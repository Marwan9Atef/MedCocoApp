
import 'package:dartz/dartz.dart';
import 'package:medcoco/core/failure/failure.dart';
import 'package:medcoco/feature/auth/data/models/confirm_reset_password_request_model.dart';
import 'package:medcoco/feature/auth/data/models/login_request_model.dart';
import 'package:medcoco/feature/auth/data/models/login_response_model.dart';
import 'package:medcoco/feature/auth/data/models/register_request_model.dart';
import 'package:medcoco/feature/auth/data/models/register_resposne_model.dart';

abstract class AuthRepo {
  Future<Either<Failure, LoginResponseModel>> login(LoginRequestModel loginRequestModel);
  Future<Either<Failure, RegisterResposneModel>> register(RegisterRequestModel registerRequestModel);
  Future<Either<Failure, String>> forget(String email);
  Future<Either<Failure, String>> confirmResetPassword(ConfirmResetPasswordRequest request);
}
