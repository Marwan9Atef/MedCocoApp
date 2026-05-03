import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:medcoco/feature/my_upload/domain/my_upload_repo.dart';
import 'package:medcoco/feature/my_upload/presentation/cubit/my_upload_states.dart';

@injectable
class MyUploadCubit extends Cubit<MyUploadStates> {
  final MyUploadRepo _myUploadRepo;

  MyUploadCubit(this._myUploadRepo) : super(MyUploadInitial());

  Future<void> getMyImages() async {
    emit(MyUploadLoading());
    final result = await _myUploadRepo.getMyImages();
    result.fold(
      (failure) => emit(MyUploadFailure(error: failure.message)),
      (result) => emit(MyUploadSuccess(result: result)),
    );
  }

  Future<void> removeMyUploadImage() async {
    emit(MyUploadLoading());
    final result = await _myUploadRepo.removeMyUploadImage();
    await result.fold((failure) {
      emit(MyUploadFailure(error: failure.message));
      return Future<void>.value();
    }, (message) => getMyImages());
  }
}
