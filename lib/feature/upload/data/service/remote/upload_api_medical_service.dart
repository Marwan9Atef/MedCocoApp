import 'dart:async';
import 'dart:convert';

import 'package:background_downloader/background_downloader.dart';

import '../../../../../core/constant/api_constant.dart';
import '../../../../../core/network/auth_token_refresher.dart';
import '../../../../auth/data/service/local/auth_local_medical_service.dart';
import '../../models/upload_response_model.dart';
import 'upload_remote_medical_service.dart';

class UploadApiMedicalService implements UploadRemoteMedicalService {
  UploadApiMedicalService(this._authLocalService, this._tokenRefresher) {
    FileDownloader().updates.listen(_handleUpdate);
  }

  final AuthLocalMedicalService _authLocalService;
  final AuthTokenRefresher _tokenRefresher;

  static const _uploadGroup = 'medical_image_upload';

  final _progressController = StreamController<double>.broadcast();
  Completer<List<UploadResponseModel>>? _activeCompleter;
  String? _activeTaskId;
  List<String>? _pendingRetryPaths;
  bool _authRetryUsed = false;

  void _handleUpdate(TaskUpdate update) {
    if (update is TaskProgressUpdate) {
      _progressController.add(update.progress);
    } else if (update is TaskStatusUpdate &&
        update.task.taskId == _activeTaskId &&
        update.status.isFinalState) {
      if (update.status == TaskStatus.complete) {
        final body = update.responseBody ?? '[]';
        final list = (jsonDecode(body) as List<dynamic>)
            .map((e) =>
                UploadResponseModel.fromJson(e as Map<String, dynamic>))
            .toList();
        _activeCompleter?.complete(list);
        _clearActiveUpload();
      } else {
        if (update.responseStatusCode == 401 &&
            !_authRetryUsed &&
            _pendingRetryPaths != null) {
          _authRetryUsed = true;
          unawaited(_retryUploadAfterUnauthorized());
          return;
        }
        _activeCompleter?.completeError(
          Exception(update.responseBody ?? 'Upload failed'),
        );
        _clearActiveUpload();
      }
    }
  }

  Future<void> _retryUploadAfterUnauthorized() async {
    final paths = _pendingRetryPaths;
    if (paths == null) {
      return;
    }
    final access = await _tokenRefresher.refreshAccessTokenSingleFlight();
    if (access == null || access.isEmpty) {
      await _tokenRefresher.invalidateSession();
      _activeCompleter?.completeError(Exception('Session expired'));
      _clearActiveUpload();
      return;
    }
    try {
      await _enqueueTask(paths);
    } catch (e, st) {
      _activeCompleter?.completeError(e, st);
      _clearActiveUpload();
    }
  }

  Future<void> _enqueueTask(List<String> filePaths) async {
    final token = await _authLocalService.getAccessToken();
    final url = '${ApiConstant.baseUrl}${ApiConstant.uploadImageEndpoint}';
    final files = filePaths.map((path) => ('files', path)).toList();

    final task = MultiUploadTask(
      url: url,
      files: files,
      headers: {
        if (token != null) 'Authorization': 'Bearer $token',
        'ngrok-skip-browser-warning': 'true',
      },
      group: _uploadGroup,
      updates: Updates.statusAndProgress,
      retries: 2,
    );

    _activeTaskId = task.taskId;
    await FileDownloader().enqueue(task);
  }

  void _clearActiveUpload() {
    _activeCompleter = null;
    _activeTaskId = null;
    _pendingRetryPaths = null;
    _authRetryUsed = false;
  }

  @override
  Future<List<UploadResponseModel>> enqueueUpload(
    List<String> filePaths,
  ) async {
    _pendingRetryPaths = filePaths;
    _authRetryUsed = false;

    _activeCompleter = Completer<List<UploadResponseModel>>();
    await _enqueueTask(filePaths);

    return _activeCompleter!.future;
  }

  @override
  Stream<double> get progressStream => _progressController.stream;

  @override
  Future<void> cancelUpload() async {
    await FileDownloader().cancelTasksWithIds(
      (await FileDownloader().allTaskIds()).toList(),
    );
  }

  @override
  Future<bool> hasActiveUpload() async {
    final records = await FileDownloader().database.allRecordsWithStatus(
      TaskStatus.running,
    );
    return records.any((r) => r.group == _uploadGroup);
  }
}
