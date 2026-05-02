// GENERATED CODE - DO NOT MODIFY BY HAND
// dart format width=80

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:flutter_secure_storage/flutter_secure_storage.dart' as _i558;
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;
import 'package:medcoco/core/di/register_module.dart' as _i561;
import 'package:medcoco/core/network/api_client.dart' as _i966;
import 'package:medcoco/core/network/auth_token_refresher.dart' as _i717;
import 'package:medcoco/feature/auth/data/repo/auth_repo_impl.dart' as _i855;
import 'package:medcoco/feature/auth/data/service/local/auth_local_medical_service.dart'
    as _i707;
import 'package:medcoco/feature/auth/data/service/local/auth_local_secure_storage_service.dart'
    as _i572;
import 'package:medcoco/feature/auth/data/service/remote/auth_api_medical_service.dart'
    as _i369;
import 'package:medcoco/feature/auth/data/service/remote/auth_remote_medical_service.dart'
    as _i408;
import 'package:medcoco/feature/auth/domain/auth_repo.dart' as _i23;
import 'package:medcoco/feature/auth/presentation/cubit/auth/auth_cubit.dart'
    as _i560;
import 'package:medcoco/feature/auth/presentation/cubit/confirm_reset/confirm_reset_cubit.dart'
    as _i349;
import 'package:medcoco/feature/auth/presentation/cubit/forget/forget_cubit.dart'
    as _i426;
import 'package:medcoco/feature/auth/presentation/cubit/login/login_cubit.dart'
    as _i587;
import 'package:medcoco/feature/auth/presentation/cubit/register/register_cubit.dart'
    as _i925;
import 'package:medcoco/feature/search/data/repo/search_repo_impl.dart'
    as _i901;
import 'package:medcoco/feature/search/data/service/remote/search_api_medical_service.dart'
    as _i902;
import 'package:medcoco/feature/search/data/service/remote/search_remote_medical_service.dart'
    as _i903;
import 'package:medcoco/feature/search/domain/repo/search_repo.dart' as _i904;
import 'package:medcoco/feature/search/presentation/cubit/search_cubit.dart'
    as _i905;
import 'package:medcoco/feature/upload/data/repo/upload_repo_impl.dart'
    as _i830;
import 'package:medcoco/feature/upload/data/service/remote/upload_remote_medical_service.dart'
    as _i129;
import 'package:medcoco/feature/upload/domain/upload_repo.dart' as _i517;
import 'package:medcoco/feature/upload/presentation/cubit/upload_process_cubit.dart'
    as _i524;
import 'package:shared_preferences/shared_preferences.dart' as _i460;

extension GetItInjectableX on _i174.GetIt {
  // initializes the registration of main-scope dependencies inside of GetIt
  Future<_i174.GetIt> init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) async {
    final gh = _i526.GetItHelper(this, environment, environmentFilter);
    final registerModule = _$RegisterModule();
    await gh.factoryAsync<_i460.SharedPreferences>(
      () => registerModule.prefs,
      preResolve: true,
    );
    gh.lazySingleton<_i558.FlutterSecureStorage>(
      () => registerModule.secureStorage,
    );
    gh.lazySingleton<_i707.AuthLocalMedicalService>(
      () =>
          _i572.AuthLocalSecureStorageService(gh<_i558.FlutterSecureStorage>()),
    );
    gh.lazySingleton<_i560.AuthCubit>(
      () => _i560.AuthCubit(gh<_i707.AuthLocalMedicalService>()),
    );
    gh.lazySingleton<_i717.AuthTokenRefresher>(
      () => _i717.AuthTokenRefresher(
        gh<_i707.AuthLocalMedicalService>(),
        gh<_i560.AuthCubit>(),
      ),
    );
    gh.lazySingleton<_i966.ApiClient>(
      () => _i966.ApiClient(
        gh<_i707.AuthLocalMedicalService>(),
        gh<_i717.AuthTokenRefresher>(),
      ),
    );
    gh.lazySingleton<_i129.UploadRemoteMedicalService>(
      () => registerModule.uploadRemoteService(
        gh<_i707.AuthLocalMedicalService>(),
        gh<_i966.ApiClient>(),
        gh<_i717.AuthTokenRefresher>(),
      ),
    );
    gh.lazySingleton<_i517.UploadRepo>(
      () => _i830.UploadRepoImpl(gh<_i129.UploadRemoteMedicalService>()),
    );
    gh.lazySingleton<_i903.SearchRemoteMedicalService>(
      () => _i902.SearchApiMedicalService(apiClient: gh<_i966.ApiClient>()),
    );
    gh.lazySingleton<_i904.SearchRepo>(
      () => _i901.SearchRepoImpl(gh<_i903.SearchRemoteMedicalService>()),
    );
    gh.lazySingleton<_i408.AuthRemoteMedicalService>(
      () => _i369.AuthApiMedicalService(apiClient: gh<_i966.ApiClient>()),
    );
    gh.lazySingleton<_i23.AuthRepo>(
      () => _i855.AuthRepoImpl(
        gh<_i408.AuthRemoteMedicalService>(),
        gh<_i707.AuthLocalMedicalService>(),
      ),
    );
    gh.factory<_i349.ConfirmResetCubit>(
      () => _i349.ConfirmResetCubit(gh<_i23.AuthRepo>()),
    );
    gh.factory<_i426.ForgetCubit>(() => _i426.ForgetCubit(gh<_i23.AuthRepo>()));
    gh.factory<_i587.LoginCubit>(() => _i587.LoginCubit(gh<_i23.AuthRepo>()));
    gh.factory<_i925.RegisterCubit>(
      () => _i925.RegisterCubit(gh<_i23.AuthRepo>()),
    );
    gh.factory<_i905.SearchCubit>(
      () => _i905.SearchCubit(gh<_i904.SearchRepo>()),
    );
    gh.factory<_i524.UploadProcessCubit>(
      () => _i524.UploadProcessCubit(gh<_i517.UploadRepo>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i561.RegisterModule {}
