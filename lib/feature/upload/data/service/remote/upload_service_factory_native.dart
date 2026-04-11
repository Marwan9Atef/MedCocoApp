import '../../../../auth/data/service/local/auth_local_medical_service.dart';
import '../../../../../core/network/api_client.dart';
import 'upload_api_medical_service.dart';
import 'upload_remote_medical_service.dart';

UploadRemoteMedicalService createUploadService({
  required AuthLocalMedicalService authLocalService,
  required ApiClient apiClient,
}) =>
    UploadApiMedicalService(authLocalService);
