import 'package:injectable/injectable.dart';
import 'package:valo/core/constant/api_constant.dart';
import 'package:valo/core/error/app_exception.dart';
import 'package:valo/core/network/api_client.dart';
import 'package:valo/feature/auth/data/models/login_request_model.dart';
import 'package:valo/feature/auth/data/models/login_response_model.dart';
import 'package:valo/feature/auth/data/service/remote/auth_remote_medical_service.dart';

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
}