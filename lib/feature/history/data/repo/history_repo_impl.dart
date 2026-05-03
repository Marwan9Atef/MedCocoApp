import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:medcoco/core/error/app_exception.dart';
import 'package:medcoco/core/failure/failure.dart';
import 'package:medcoco/feature/history/domain/repo/history_repo.dart';
import 'package:medcoco/feature/search/data/models/search_response_model.dart';
import 'package:medcoco/feature/search/data/service/local/search_local_medical_service.dart';

@LazySingleton(as: HistoryRepo)
class HistoryRepoImpl implements HistoryRepo {
  final SearchLocalMedicalService _localService;

  HistoryRepoImpl(this._localService);

  @override
  Future<Either<Failure, Unit>> clearSearchHistory() async {
    try {
      await _localService.clearSearchResponse();
      return const Right(unit);
    } on AppException catch (exception) {
      return Left(Failure(exception.message));
    }
  }

  @override
  Future<Either<Failure, SearchResponseModel?>> getSearchHistory() async {
    try {
      final response = _localService.getSearchResponse();
      return Right(response);
    } on AppException catch (exception) {
      return Left(Failure(exception.message));
    }
  }

  @override
  Future<Either<Failure, SearchResponseModel?>> removeSearchHistoryResult(
    String imageId,
  ) async {
    try {
      final response = await _localService.removeSearchResult(imageId);
      return Right(response);
    } on AppException catch (exception) {
      return Left(Failure(exception.message));
    }
  }
}
