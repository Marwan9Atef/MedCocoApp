import 'package:dio/dio.dart';

class AppException implements Exception {
  final String message;
  const AppException(this.message);
}

class RemoteException extends AppException {
  const RemoteException(super.message);
}

class LocalException extends AppException {
  const LocalException(super.message);
}

class NetworkException extends AppException {
  const NetworkException([super.message = 'No internet connection']);
}

class SessionExpiredException extends AppException {
  const SessionExpiredException([
    super.message = 'Session expired, please login again',
  ]);
}

String? extractDioErrorMessage(Object exception) {
  if (exception is! DioException) return null;

  if (exception.type == DioExceptionType.connectionTimeout ||
      exception.type == DioExceptionType.sendTimeout ||
      exception.type == DioExceptionType.receiveTimeout ||
      exception.type == DioExceptionType.connectionError) {
    return 'No internet connection, please check your network';
  }

  if (exception.response == null) {
    return 'An error occurred while connecting to the server';
  }

  final data = exception.response!.data;

  if (data is Map<String, dynamic>) {
    return data['detail']?.toString()?? data['message']?.toString();
  }

  if (data is String && data.isNotEmpty) {
    if (data.contains('<html') || data.contains('<!DOCTYPE')) {
      return null;
    }
    return data;
  }

  return null;
}
