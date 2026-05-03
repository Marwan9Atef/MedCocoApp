import 'package:medcoco/feature/my_upload/data/models/my_images_response_model.dart';
import 'package:medcoco/feature/my_upload/data/models/remove_one_image_response_model.dart';

abstract class MyUploadRemoteMedicalService {
  Future<MyImagesResponseModel> getMyImages();
  Future<String> removeMyUploadImage();
  Future<RemoveOneImageResponseModel> remmoveOneImageFromMyUpload(
    String imageId,
  );
}
