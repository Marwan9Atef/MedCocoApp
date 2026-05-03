import 'package:medcoco/feature/my_upload/data/models/remove_one_image_response_model.dart';

abstract class RemoveOneImageStates {}

class RemoveOneImageInitial extends RemoveOneImageStates {}

class RemoveOneImageLoading extends RemoveOneImageStates {
  final String imageId;

  RemoveOneImageLoading({required this.imageId});
}

class RemoveOneImageSuccess extends RemoveOneImageStates {
  final RemoveOneImageResponseModel result;

  RemoveOneImageSuccess({required this.result});
}

class RemoveOneImageFailure extends RemoveOneImageStates {
  final String error;

  RemoveOneImageFailure({required this.error});
}
