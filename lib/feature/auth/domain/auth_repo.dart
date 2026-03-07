
import 'package:dartz/dartz.dart';
import 'package:valo/core/failure/failure.dart';
import 'package:valo/feature/auth/data/models/login_request_model.dart';
import 'package:valo/feature/auth/data/models/login_response_model.dart';
import 'package:valo/feature/auth/data/models/register_request_model.dart';
import 'package:valo/feature/auth/data/models/register_resposne_model.dart';

abstract class AuthRepo {
  Future<Either<Failure, LoginResponseModel>> login(LoginRequestModel loginRequestModel);
  Future<Either<Failure, RegisterResposneModel>> register(RegisterRequestModel registerRequestModel);
}
