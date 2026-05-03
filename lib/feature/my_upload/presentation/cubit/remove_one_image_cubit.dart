import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:medcoco/feature/my_upload/domain/my_upload_repo.dart';
import 'package:medcoco/feature/my_upload/presentation/cubit/remove_one_image_states.dart';

@injectable
class RemoveOneImageCubit extends Cubit<RemoveOneImageStates> {
  final MyUploadRepo _myUploadRepo;

  RemoveOneImageCubit(this._myUploadRepo) : super(RemoveOneImageInitial());

  Future<void> remmoveOneImageFromMyUpload(String imageId) async {
    emit(RemoveOneImageLoading(imageId: imageId));
    final result = await _myUploadRepo.remmoveOneImageFromMyUpload(imageId);
    result.fold(
      (failure) => emit(RemoveOneImageFailure(error: failure.message)),
      (success) => emit(RemoveOneImageSuccess(result: success)),
    );
  }
}
