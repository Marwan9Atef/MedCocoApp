import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:valo/core/error/app_exception.dart';
import 'package:valo/core/failure/failure.dart';
import 'package:valo/feature/auth/data/models/login_request_model.dart';
import 'package:valo/feature/auth/data/models/login_response_model.dart';
import 'package:valo/feature/auth/data/models/register_request_model.dart';
import 'package:valo/feature/auth/data/models/register_resposne_model.dart';
import 'package:valo/feature/auth/data/service/local/auth_local_medical_service.dart';
import 'package:valo/feature/auth/data/service/remote/auth_remote_medical_service.dart';
import 'package:valo/feature/auth/domain/auth_repo.dart';

@LazySingleton(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final AuthRemoteMedicalService _remoteService;
  final AuthLocalMedicalService _localService;
  AuthRepoImpl(this._remoteService, this._localService);

  @override
  Future<Either<Failure, LoginResponseModel>> login(LoginRequestModel loginRequestModel) async {
    try {
      final response = await _remoteService.login(loginRequestModel);
      await _localService.setToken(response.accessToken, response.refreshToken);
      await _localService.setUserId(response.user?.uid);
      return Right(response);
    } on AppException catch (exception) {
      return Left(Failure(exception.message));
    }
  }

  @override
  Future<Either<Failure, RegisterResposneModel>> register(RegisterRequestModel registerRequestModel) async {
    try {
      final response = await _remoteService.register(registerRequestModel);
      await _localService.setToken(response.accessToken, response.refreshToken);
      await _localService.setUserId(response.user?.uid);
      return Right(response);
    } on AppException catch (exception) {
      return Left(Failure(exception.message));
    }
  }
}