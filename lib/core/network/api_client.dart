import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:injectable/injectable.dart';
import 'package:medcoco/core/constant/api_constant.dart';
import 'package:medcoco/core/network/auth_token_refresher.dart';
import 'package:medcoco/feature/auth/data/service/local/auth_local_medical_service.dart';

const _kAuthRetry = 'authRetry';
const _kSkipAuth = 'skipAuth';

@lazySingleton
class ApiClient {
  ApiClient(this._authLocal, this._tokenRefresher) {
    final baseOptions = BaseOptions(
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
    );

    _dio = Dio(baseOptions);

    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          if (options.extra[_kSkipAuth] == true) {
            options.headers.remove('Authorization');
            handler.next(options);
            return;
          }
          final pathOnly = _normalizePath(options.path);
          if (_isRefreshTokenPath(pathOnly)) {
            options.headers.remove('Authorization');
            handler.next(options);
            return;
          }
          final token = await _authLocal.getAccessToken();
          if (token != null && token.isNotEmpty) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          handler.next(options);
        },
        onError: (err, handler) async {
          final code = err.response?.statusCode;
          if (code != 401 && code != 403) {
            handler.next(err);
            return;
          }
          final opts = err.requestOptions;
          if (opts.extra[_kAuthRetry] == true) {
            handler.next(err);
            return;
          }
          final pathOnly = _normalizePath(opts.path);
          if (_shouldSkipRefreshForPath(pathOnly)) {
            handler.next(err);
            return;
          }
          final refresh = await _authLocal.getRefreshToken();
          if (refresh == null || refresh.isEmpty) {
            await _tokenRefresher.invalidateSession();
            handler.next(err);
            return;
          }
          try {
            final access = await _tokenRefresher.refreshAccessTokenSingleFlight();
            if (access == null || access.isEmpty) {
              await _tokenRefresher.invalidateSession();
              handler.next(err);
              return;
            }
            final headers = Map<String, dynamic>.from(opts.headers);
            headers['Authorization'] = 'Bearer $access';
            final retry = await _dio.fetch(
              opts.copyWith(
                headers: headers,
                extra: {...opts.extra, _kAuthRetry: true},
              ),
            );
            handler.resolve(retry);
          } catch (_) {
            await _tokenRefresher.invalidateSession();
            handler.next(err);
          }
        },
      ),
    );

    if (kDebugMode) {
      _dio.interceptors.add(
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

  final AuthLocalMedicalService _authLocal;
  final AuthTokenRefresher _tokenRefresher;
  late final Dio _dio;

  Future<Response> get(
    String path, {
    Map<String, dynamic>? queryParameters,
  }) =>
      _dio.get(path, queryParameters: queryParameters);

  Future<Response> post(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
    ProgressCallback? onSendProgress,
    CancelToken? cancelToken,
  }) =>
      _dio.post(
        path,
        data: data,
        queryParameters: queryParameters,
        onSendProgress: onSendProgress,
        cancelToken: cancelToken,
      );

  Future<Response> put(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) =>
      _dio.put(path, data: data, queryParameters: queryParameters);

  Future<Response> patch(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) =>
      _dio.patch(path, data: data, queryParameters: queryParameters);

  Future<Response> delete(
    String path, {
    dynamic data,
    Map<String, dynamic>? queryParameters,
  }) =>
      _dio.delete(path, data: data, queryParameters: queryParameters);
}

String _normalizePath(String path) {
  final withoutQuery = path.split('?').first;
  if (withoutQuery.startsWith('/')) {
    return withoutQuery;
  }
  return '/$withoutQuery';
}

bool _isRefreshTokenPath(String pathOnly) {
  final refresh = ApiConstant.refreshTokenEndpoint;
  if (refresh.isEmpty) {
    return false;
  }
  return pathOnly == refresh || pathOnly == _normalizePath(refresh);
}

bool _shouldSkipRefreshForPath(String pathOnly) {
  return _pathsWithoutRefreshOn401.any(
    (p) => p.isNotEmpty && (pathOnly == p || pathOnly == _normalizePath(p)),
  );
}

Iterable<String> get _pathsWithoutRefreshOn401 sync* {
  yield ApiConstant.loginEndpoint;
  yield ApiConstant.registerEndpoint;
  yield ApiConstant.passwordResetEndpoint;
  yield ApiConstant.confirmResetPasswordEndpoint;
  yield ApiConstant.refreshTokenEndpoint;
}
