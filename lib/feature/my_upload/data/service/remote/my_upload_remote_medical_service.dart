import 'package:medcoco/feature/my_upload/data/models/my_images_response_model.dart';

abstract class MyUploadRemoteMedicalService {
  Future<MyImagesResponseModel> getMyImages();
  Future<String> removeMyUploadImage();
}
