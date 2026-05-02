import 'package:medcoco/feature/my_upload/data/models/my_images_response_model.dart';

abstract class MyUploadStates {}

class MyUploadInitial extends MyUploadStates {}

class MyUploadLoading extends MyUploadStates {}

class MyUploadSuccess extends MyUploadStates {
  final MyImagesResponseModel result;

  MyUploadSuccess({required this.result});
}

class MyUploadRemoveSuccess extends MyUploadStates {
  final String message;

  MyUploadRemoveSuccess({required this.message});
}

class MyUploadFailure extends MyUploadStates {
  final String error;

  MyUploadFailure({required this.error});
}
