import 'package:desktop_drop/desktop_drop.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:valo/feature/upload/presentation/cubit/upload_images_cubit.dart';
import 'package:valo/feature/upload/presentation/cubit/upload_process_cubit.dart';

import 'upload_empty_state.dart';
import 'upload_has_images_state.dart';

class UploadItem extends StatelessWidget {
  const UploadItem({super.key});

  Future<void> _pickImages(BuildContext context) async {
    final ImagePicker picker = ImagePicker();
    try {
      final List<XFile> images = await picker.pickMultiImage();
      if (context.mounted) {
        context.read<UploadImagesCubit>().addImages(images);
      }
    } on PlatformException catch (e) {
      if (e.code != 'already_active') rethrow;
    }
  }

  @override
  Widget build(BuildContext context) {
    return DropTarget(
      onDragDone: (DropDoneDetails details) {
        context.read<UploadImagesCubit>().addImages(details.files);
      },
      child: BlocListener<UploadImagesCubit, List<XFile>>(
        listener: (context, images) {
          context.read<UploadProcessCubit>().reset();
        },
        child: BlocBuilder<UploadImagesCubit, List<XFile>>(
          builder: (context, images) {
            if (images.isEmpty) return UploadEmptyState(onPickImages: () => _pickImages(context));
            return UploadHasImagesState(
              images: images,
              onPickImages: () => _pickImages(context),
            );
          },
        ),
      ),
    );
  }
}
