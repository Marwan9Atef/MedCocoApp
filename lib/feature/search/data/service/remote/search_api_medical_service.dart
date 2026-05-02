import 'package:injectable/injectable.dart';
import 'package:medcoco/core/constant/api_constant.dart';
import 'package:medcoco/core/error/app_exception.dart';
import 'package:medcoco/core/network/api_client.dart';
import 'package:medcoco/feature/search/data/models/search_request_model.dart';
import 'package:medcoco/feature/search/data/models/search_response_model.dart';
import 'package:medcoco/feature/search/data/service/remote/search_remote_medical_service.dart';

@LazySingleton(as: SearchRemoteMedicalService)
class SearchApiMedicalService implements SearchRemoteMedicalService {
  final ApiClient apiClient;

  SearchApiMedicalService({required this.apiClient});

  @override
  Future<SearchResponseModel> search(SearchRequestModel request) async {
    try {
      final response = await apiClient.post(
        ApiConstant.searchEndpoint,
        data: request.toJson(),
      );
      return SearchResponseModel.fromJson(response.data);
    } catch (exception) {
      final message = extractDioErrorMessage(exception);
      throw RemoteException(message ?? 'An error occurred during search');
    }
  }
}
