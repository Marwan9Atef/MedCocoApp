import 'package:medcoco/feature/search/data/models/search_response_model.dart';

abstract class SearchLocalMedicalService {
  Future<void> saveSearchResponse({
    required SearchResponseModel searchResponse,
  });

  SearchResponseModel? getSearchResponse();

  Future<SearchResponseModel?> removeSearchResult(String imageId);

  Future<void> clearSearchResponse();
}
