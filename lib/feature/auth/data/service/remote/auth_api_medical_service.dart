import 'package:injectable/injectable.dart';
import 'package:medcoco/core/constant/api_constant.dart';
import 'package:medcoco/core/error/app_exception.dart';
import 'package:medcoco/core/network/api_client.dart';
import 'package:medcoco/feature/auth/data/models/confirm_reset_password_request_model.dart';
import 'package:medcoco/feature/auth/data/models/login_request_model.dart';
import 'package:medcoco/feature/auth/data/models/login_response_model.dart';
import 'package:medcoco/feature/auth/data/models/register_request_model.dart';
import 'package:medcoco/feature/auth/data/models/register_resposne_model.dart';
import 'package:medcoco/feature/auth/data/service/remote/auth_remote_medical_service.dart';

@LazySingleton(as: AuthRemoteMedicalService)
class AuthApiMedicalService implements AuthRemoteMedicalService {
  final ApiClient apiClient;
  AuthApiMedicalService({required this.apiClient});

  @override
  Future<LoginResponseModel> login(LoginRequestModel loginRequestModel) async {
    try {
      final response = await apiClient.post(
        ApiConstant.loginEndpoint,
        data: loginRequestModel.toJson(),
      );
      return LoginResponseModel.fromJson(response.data);
    } catch (exception) {
      final message = extractDioErrorMessage(exception);
      throw RemoteException(message ?? 'An error occurred during login');
    }
  }

  @override
  Future<RegisterResposneModel> register(
    RegisterRequestModel registerRequestModel,
  ) async {
    try {
      final response = await apiClient.post(
        ApiConstant.registerEndpoint,
        data: registerRequestModel.toJson(),
      );
      return RegisterResposneModel.fromJson(response.data);
    } catch (exception) {
      final message = extractDioErrorMessage(exception);
      throw RemoteException(message ?? 'An error occurred during registration');
    }
  }

  @override
  Future<String> forget(String email) async {
    try {
      final response = await apiClient.post(
        ApiConstant.passwordResetEndpoint,
        data: {'email': email},
      );
      return response.data['message'] as String;
    } catch (exception) {
      final message = extractDioErrorMessage(exception);
      throw RemoteException(
        message ?? 'An error occurred during password reset request',
      );
    }
  }

  @override
  Future<String> confirmResetPassword(
    ConfirmResetPasswordRequest request,
  ) async {
    try {
      final response = await apiClient.post(
        ApiConstant.confirmResetPasswordEndpoint,
        data: request.toJson(),
      );
      return response.data['message'] as String;
    } catch (exception) {
      final message = extractDioErrorMessage(exception);
      throw RemoteException(
        message ?? 'An error occurred during password reset confirmation',
      );
    }
  }
}
