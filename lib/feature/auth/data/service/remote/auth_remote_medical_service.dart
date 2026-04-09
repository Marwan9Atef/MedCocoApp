import 'package:valo/feature/auth/data/models/confirm_reset_password_request_model.dart';
import 'package:valo/feature/auth/data/models/login_request_model.dart';
import 'package:valo/feature/auth/data/models/login_response_model.dart';
import 'package:valo/feature/auth/data/models/register_request_model.dart';
import 'package:valo/feature/auth/data/models/register_resposne_model.dart';

abstract class AuthRemoteMedicalService {
  Future<LoginResponseModel> login(LoginRequestModel loginRequestModel);
  Future<RegisterResposneModel> register(RegisterRequestModel registerRequestModel);
  Future<String> forget(String email);
  Future<String> confirmResetPassword(ConfirmResetPasswordRequest request);
}
