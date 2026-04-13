import '../../../../auth/data/service/local/auth_local_medical_service.dart';
import '../../../../../core/network/api_client.dart';
import '../../../../../core/network/auth_token_refresher.dart';
import 'upload_api_medical_service.dart';
import 'upload_remote_medical_service.dart';

UploadRemoteMedicalService createUploadService({
  required AuthLocalMedicalService authLocalService,
  required ApiClient apiClient,
  required AuthTokenRefresher authTokenRefresher,
}) =>
    UploadApiMedicalService(authLocalService, authTokenRefresher);
