import 'package:medcoco/feature/search/data/models/search_request_model.dart';
import 'package:medcoco/feature/search/data/models/search_response_model.dart';

abstract class SearchRemoteMedicalService {
  Future<SearchResponseModel> search(SearchRequestModel request);
}
