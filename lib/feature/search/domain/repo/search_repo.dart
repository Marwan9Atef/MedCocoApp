import 'package:dartz/dartz.dart';
import 'package:medcoco/core/failure/failure.dart';
import 'package:medcoco/feature/search/data/models/search_request_model.dart';
import 'package:medcoco/feature/search/data/models/search_response_model.dart';

abstract class SearchRepo {
  Future<Either<Failure, SearchResponseModel>> search(
    SearchRequestModel request,
  );
}
