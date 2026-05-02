import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../feature/auth/data/service/local/auth_local_medical_service.dart';
import '../../feature/upload/data/service/remote/upload_remote_medical_service.dart';
import '../../feature/upload/data/service/remote/upload_service_factory.dart';
import '../network/api_client.dart';
import '../network/auth_token_refresher.dart';

@module
abstract class RegisterModule {
  @preResolve
  Future<SharedPreferences> get prefs => SharedPreferences.getInstance();

  @lazySingleton
  FlutterSecureStorage get secureStorage => const FlutterSecureStorage();

  @lazySingleton
  UploadRemoteMedicalService uploadRemoteService(
    AuthLocalMedicalService authLocalService,
    ApiClient apiClient,
    AuthTokenRefresher authTokenRefresher,
  ) =>
      createUploadService(
        authLocalService: authLocalService,
        apiClient: apiClient,
        authTokenRefresher: authTokenRefresher,
      );
}
