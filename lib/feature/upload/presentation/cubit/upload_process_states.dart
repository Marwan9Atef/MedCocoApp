import '../../data/models/upload_response_model.dart';

sealed class UploadProcessState {
  const UploadProcessState();
}

final class UploadProcessIdle extends UploadProcessState {
  const UploadProcessIdle();
}

final class UploadProcessInProgress extends UploadProcessState {
  final double progress;
  const UploadProcessInProgress({required this.progress});
}

final class UploadProcessSuccess extends UploadProcessState {
  final List<UploadResponseModel> results;
  const UploadProcessSuccess({required this.results});
}

final class UploadProcessFailure extends UploadProcessState {
  final String error;
  const UploadProcessFailure({required this.error});
}
