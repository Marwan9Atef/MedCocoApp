import '../../models/upload_response_model.dart';

abstract class UploadRemoteMedicalService {
  Future<UploadResponseModel> enqueueUpload(List<String> filePaths);

  Stream<double> get progressStream;

  Future<void> cancelUpload();

  Future<bool> hasActiveUpload();
}
