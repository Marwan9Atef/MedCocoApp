import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:injectable/injectable.dart';

import '../../domain/upload_repo.dart';
import 'upload_process_states.dart';

@injectable
class UploadProcessCubit extends Cubit<UploadProcessState> {
  final UploadRepo _uploadRepo;
  StreamSubscription<double>? _progressSub;

  UploadProcessCubit(this._uploadRepo) : super(const UploadProcessIdle());

  Future<void> init() async {
    final isActive = await _uploadRepo.hasActiveUpload();
    if (!isActive) return;

    emit(const UploadProcessInProgress(progress: -1));
    _listenToProgress();
  }

  Future<void> upload(List<XFile> files) async {
    emit(const UploadProcessInProgress(progress: 0));
    _listenToProgress();

    final filePaths = files.map((f) => f.path).toList();
    final result = await _uploadRepo.uploadImages(filePaths);

    result.fold(
      (failure) => emit(UploadProcessFailure(error: failure.message)),
      (result) => emit(UploadProcessSuccess(result: result)),
    );
  }

  void _listenToProgress() {
    _progressSub?.cancel();
    _progressSub = _uploadRepo.progressStream.listen((progress) {
      if (!isClosed) {
        emit(UploadProcessInProgress(progress: progress));
      }
    });
  }

  void reset() => emit(const UploadProcessIdle());

  Future<void> cancelUpload() async {
    await _uploadRepo.cancelUpload();
    emit(const UploadProcessIdle());
  }

  @override
  Future<void> close() {
    _progressSub?.cancel();
    return super.close();
  }
}
