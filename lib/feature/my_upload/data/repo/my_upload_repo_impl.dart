import 'package:dartz/dartz.dart';
import 'package:injectable/injectable.dart';
import 'package:medcoco/core/error/app_exception.dart';
import 'package:medcoco/core/failure/failure.dart';
import 'package:medcoco/feature/my_upload/data/models/my_images_response_model.dart';
import 'package:medcoco/feature/my_upload/data/models/remove_one_image_response_model.dart';
import 'package:medcoco/feature/my_upload/data/service/remote/my_upload_remote_medical_service.dart';
import 'package:medcoco/feature/my_upload/domain/my_upload_repo.dart';

@LazySingleton(as: MyUploadRepo)
class MyUploadRepoImpl implements MyUploadRepo {
  final MyUploadRemoteMedicalService _remoteService;

  MyUploadRepoImpl(this._remoteService);

  @override
  Future<Either<Failure, MyImagesResponseModel>> getMyImages() async {
    try {
      final response = await _remoteService.getMyImages();
      return Right(response);
    } on AppException catch (exception) {
      return Left(Failure(exception.message));
    }
  }

  @override
  Future<Either<Failure, String>> removeMyUploadImage() async {
    try {
      final message = await _remoteService.removeMyUploadImage();
      return Right(message);
    } on AppException catch (exception) {
      return Left(Failure(exception.message));
    }
  }

  @override
  Future<Either<Failure, RemoveOneImageResponseModel>>
      remmoveOneImageFromMyUpload(String imageId) async {
    try {
      final response = await _remoteService.remmoveOneImageFromMyUpload(
        imageId,
      );
      return Right(response);
    } on AppException catch (exception) {
      return Left(Failure(exception.message));
    }
  }
}
