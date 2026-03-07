import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:valo/core/error/app_exception.dart';
import 'package:valo/core/failure/failure.dart';
import 'package:valo/feature/auth/data/models/login_request_model.dart';
import 'package:valo/feature/auth/data/models/login_response_model.dart';
import 'package:valo/feature/auth/data/service/remote/auth_remote_medical_service.dart';
import 'package:valo/feature/auth/domain/auth_repo.dart';

@LazySingleton(as: AuthRepo)
class AuthRepoImpl implements AuthRepo {
  final AuthRemoteMedicalService authRemoteMedicalService;
  AuthRepoImpl({required this.authRemoteMedicalService});
  @override
  Future<Either<Failure, LoginResponseModel>> login(LoginRequestModel loginRequestModel) async {
    try {
      final response = await authRemoteMedicalService.login(loginRequestModel);
      return Right(response);
    }on AppException catch (exception) {
      return Left(Failure(exception.message.toString()));
    }
  }
}