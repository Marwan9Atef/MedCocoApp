import 'dart:async';
import 'dart:convert';

import 'package:background_downloader/background_downloader.dart';

import '../../../../../core/constant/api_constant.dart';
import '../../../../auth/data/service/local/auth_local_medical_service.dart';
import '../../models/upload_response_model.dart';
import 'upload_remote_medical_service.dart';

class UploadApiMedicalService implements UploadRemoteMedicalService {
  final AuthLocalMedicalService _authLocalService;

  static const _uploadGroup = 'medical_image_upload';

  final _progressController = StreamController<double>.broadcast();
  Completer<List<UploadResponseModel>>? _activeCompleter;
  String? _activeTaskId;

  UploadApiMedicalService(this._authLocalService) {
    FileDownloader().updates.listen(_handleUpdate);
  }

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
      } else {
        _activeCompleter?.completeError(
          Exception(update.responseBody ?? 'Upload failed'),
        );
      }
      _activeCompleter = null;
      _activeTaskId = null;
    }
  }

  @override
  Future<List<UploadResponseModel>> enqueueUpload(
    List<String> filePaths,
  ) async {
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

    _activeCompleter = Completer<List<UploadResponseModel>>();
    _activeTaskId = task.taskId;

    await FileDownloader().enqueue(task);

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
