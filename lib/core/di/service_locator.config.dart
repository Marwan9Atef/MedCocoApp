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
import 'package:shared_preferences/shared_preferences.dart' as _i460;
import 'package:valo/core/di/register_module.dart' as _i571;
import 'package:valo/core/network/api_client.dart' as _i777;
import 'package:valo/feature/auth/data/repo/auth_repo_impl.dart' as _i997;
import 'package:valo/feature/auth/data/service/local/auth_local_medical_service.dart'
    as _i852;
import 'package:valo/feature/auth/data/service/local/auth_local_secure_storage_service.dart'
    as _i360;
import 'package:valo/feature/auth/data/service/remote/auth_api_medical_service.dart'
    as _i723;
import 'package:valo/feature/auth/data/service/remote/auth_remote_medical_service.dart'
    as _i64;
import 'package:valo/feature/auth/domain/auth_repo.dart' as _i125;
import 'package:valo/feature/auth/presentation/cubit/confirm_reset/confirm_reset_cubit.dart'
    as _i617;
import 'package:valo/feature/auth/presentation/cubit/forget/forget_cubit.dart'
    as _i678;
import 'package:valo/feature/auth/presentation/cubit/login/login_cubit.dart'
    as _i728;
import 'package:valo/feature/auth/presentation/cubit/register/register_cubit.dart'
    as _i250;

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
    gh.lazySingleton<_i777.ApiClient>(() => _i777.ApiClient());
    gh.lazySingleton<_i852.AuthLocalMedicalService>(
      () =>
          _i360.AuthLocalSecureStorageService(gh<_i558.FlutterSecureStorage>()),
    );
    gh.lazySingleton<_i64.AuthRemoteMedicalService>(
      () => _i723.AuthApiMedicalService(apiClient: gh<_i777.ApiClient>()),
    );
    gh.lazySingleton<_i125.AuthRepo>(
      () => _i997.AuthRepoImpl(
        gh<_i64.AuthRemoteMedicalService>(),
        gh<_i852.AuthLocalMedicalService>(),
      ),
    );
    gh.factory<_i617.ConfirmResetCubit>(
      () => _i617.ConfirmResetCubit(gh<_i125.AuthRepo>()),
    );
    gh.factory<_i678.ForgetCubit>(
      () => _i678.ForgetCubit(gh<_i125.AuthRepo>()),
    );
    gh.factory<_i728.LoginCubit>(() => _i728.LoginCubit(gh<_i125.AuthRepo>()));
    gh.factory<_i250.RegisterCubit>(
      () => _i250.RegisterCubit(gh<_i125.AuthRepo>()),
    );
    return this;
  }
}

class _$RegisterModule extends _i571.RegisterModule {}
