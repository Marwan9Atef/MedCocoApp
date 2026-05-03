import 'package:dartz/dartz.dart';
import 'package:medcoco/core/failure/failure.dart';
import 'package:medcoco/feature/search/data/models/search_response_model.dart';

abstract class HistoryRepo {
  Future<Either<Failure, SearchResponseModel?>> getSearchHistory();

  Future<Either<Failure, SearchResponseModel?>> removeSearchHistoryResult(
    String imageId,
  );

  Future<Either<Failure, Unit>> clearSearchHistory();
}
