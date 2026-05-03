import 'package:injectable/injectable.dart';
import 'package:medcoco/core/constant/api_constant.dart';
import 'package:medcoco/core/error/app_exception.dart';
import 'package:medcoco/core/network/api_client.dart';
import 'package:medcoco/feature/my_upload/data/models/my_images_response_model.dart';
import 'package:medcoco/feature/my_upload/data/models/remove_one_image_response_model.dart';
import 'package:medcoco/feature/my_upload/data/service/remote/my_upload_remote_medical_service.dart';

@LazySingleton(as: MyUploadRemoteMedicalService)
class MyUploadApiMedicalService implements MyUploadRemoteMedicalService {
  final ApiClient apiClient;

  MyUploadApiMedicalService({required this.apiClient});

  @override
  Future<MyImagesResponseModel> getMyImages() async {
    try {
      final response = await apiClient.get(ApiConstant.getMyImagesEndpoint);
      return MyImagesResponseModel.fromJson(response.data);
    } catch (exception) {
      final message = extractDioErrorMessage(exception);
      throw RemoteException(
        message ?? 'An error occurred while loading your images',
      );
    }
  }

  @override
  Future<String> removeMyUploadImage() async {
    try {
      final response = await apiClient.delete(
        ApiConstant.removeMyUploadImageEndpoint,
      );
      return response.data['message'] as String;
    } catch (exception) {
      final message = extractDioErrorMessage(exception);
      throw RemoteException(
        message ?? 'An error occurred while removing your images',
      );
    }
  }

  @override
  Future<RemoveOneImageResponseModel> remmoveOneImageFromMyUpload(
    String imageId,
  ) async {
    try {
      final response = await apiClient.delete(
        "${ApiConstant.remmoveOneImageFromMyUpload}/$imageId",
      );
      return RemoveOneImageResponseModel.fromJson(response.data);
    } catch (exception) {
      final message = extractDioErrorMessage(exception);
      throw RemoteException(
        message ?? 'An error occurred while removing this image',
      );
    }
  }
}
