import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:valo/core/constant/api_constant.dart';
import 'package:valo/feature/auth/data/models/refresh_token_response_model.dart';
import 'package:valo/feature/auth/data/service/local/auth_local_medical_service.dart';
import 'package:valo/feature/auth/presentation/cubit/auth/auth_cubit.dart';


@lazySingleton
class AuthTokenRefresher {
  AuthTokenRefresher(this._local, this._authCubit) {
    _refreshDio = Dio(
      BaseOptions(
        baseUrl: ApiConstant.baseUrl,
        connectTimeout: const Duration(seconds: 30),
        receiveTimeout: const Duration(seconds: 30),
        sendTimeout: const Duration(seconds: 30),
        receiveDataWhenStatusError: true,
        headers: {
          'Content-Type': 'application/json',
          'Accept': 'application/json',
          'ngrok-skip-browser-warning': 'true',
        },
      ),
    );
    if (kDebugMode) {
      _refreshDio.interceptors.add(
        LogInterceptor(
          request: true,
          requestBody: true,
          responseBody: true,
          responseHeader: false,
          requestHeader: true,
          error: true,
        ),
      );
    }
  }

  final AuthLocalMedicalService _local;
  final AuthCubit _authCubit;
  late final Dio _refreshDio;

  Future<String?>? _inFlight;

  Future<String?> refreshAccessTokenSingleFlight() {
    _inFlight ??= _performRefresh().whenComplete(() {
      _inFlight = null;
    });
    return _inFlight!;
  }

  Future<String?> _performRefresh() async {
    final refresh = await _local.getRefreshToken();
    if (refresh == null || refresh.isEmpty) {
      return null;
    }
    try {
      final response = await _refreshDio.get<Map<String, dynamic>>(
        ApiConstant.refreshTokenEndpoint,
        options: Options(headers: {'Authorization': 'Bearer $refresh'}),
      );
      final data = response.data;
      if (data == null) {
        return null;
      }
      final model = RefreshTokenResponseModel.fromJson(data);
      final access = model.accessToken;
      if (access == null || access.isEmpty) {
        return null;
      }

      await _local.setToken(access, refresh);
      return access;
    } catch (_) {
      return null;
    }
  }

  Future<void> invalidateSession() async {
    await _authCubit.logout();
  }
}
