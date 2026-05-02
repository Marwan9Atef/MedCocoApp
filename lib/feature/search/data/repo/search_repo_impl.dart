import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:medcoco/core/error/app_exception.dart';
import 'package:medcoco/core/failure/failure.dart';
import 'package:medcoco/feature/search/data/models/search_request_model.dart';
import 'package:medcoco/feature/search/data/models/search_response_model.dart';
import 'package:medcoco/feature/search/data/service/remote/search_remote_medical_service.dart';
import 'package:medcoco/feature/search/domain/repo/search_repo.dart';

@LazySingleton(as: SearchRepo)
class SearchRepoImpl implements SearchRepo {
  final SearchRemoteMedicalService _remoteService;

  SearchRepoImpl(this._remoteService);

  @override
  Future<Either<Failure, SearchResponseModel>> search(
    SearchRequestModel request,
  ) async {
    try {
      final response = await _remoteService.search(request);
      return Right(response);
    } on AppException catch (exception) {
      return Left(Failure(exception.message));
    }
  }
}
