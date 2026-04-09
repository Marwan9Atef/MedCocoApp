import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

class UploadImagesCubit extends Cubit<List<XFile>> {
  UploadImagesCubit() : super([]);

  void addImages(List<XFile> images) {
    if (images.isNotEmpty) emit([...state, ...images]);
  }

  void removeImage(int index) {
    final updated = [...state]..removeAt(index);
    emit(updated);
  }

  void clear() => emit([]);
}
