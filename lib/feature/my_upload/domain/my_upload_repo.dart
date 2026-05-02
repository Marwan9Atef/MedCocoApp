import 'package:dartz/dartz.dart';
import 'package:medcoco/core/failure/failure.dart';
import 'package:medcoco/feature/my_upload/data/models/my_images_response_model.dart';

abstract class MyUploadRepo {
  Future<Either<Failure, MyImagesResponseModel>> getMyImages();
}
