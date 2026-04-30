import 'package:desktop_drop/desktop_drop.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:valo/feature/upload/presentation/cubit/upload_images_cubit.dart';
import 'package:valo/feature/upload/presentation/cubit/upload_process_cubit.dart';

import 'upload_empty_state.dart';
import 'upload_has_images_state.dart';

/// Extensions shown in the system file picker (medical images + DICOM).
const _kUploadPickerExtensions = [
  'jpg',
  'jpeg',
  'png',
  'gif',
  'webp',
  'bmp',
  'dcm',
  'dicom',
];

List<XFile> _platformFilesToXFiles(FilePickerResult result) {
  final out = <XFile>[];
  for (final p in result.files) {
    final path = p.path;
    if (path != null && path.isNotEmpty) {
      out.add(XFile(path));
      continue;
    }
    final bytes = p.bytes;
    if (bytes != null && p.name.isNotEmpty) {
      out.add(XFile.fromData(bytes, name: p.name, mimeType: _mimeTypeForPickerName(p.name)));
    }
  }
  return out;
}

String? _mimeTypeForPickerName(String name) {
  final lower = name.toLowerCase();
  if (lower.endsWith('.dcm') || lower.endsWith('.dicom')) return 'application/dicom';
  if (lower.endsWith('.jpg') || lower.endsWith('.jpeg')) return 'image/jpeg';
  if (lower.endsWith('.png')) return 'image/png';
  if (lower.endsWith('.gif')) return 'image/gif';
  if (lower.endsWith('.webp')) return 'image/webp';
  if (lower.endsWith('.bmp')) return 'image/bmp';
  return null;
}

class UploadItem extends StatelessWidget {
  const UploadItem({super.key});

  Future<void> _pickImages(BuildContext context) async {
    try {
      final result = await FilePicker.pickFiles(
        type: FileType.custom,
        allowedExtensions: _kUploadPickerExtensions,
        allowMultiple: true,
        withData: kIsWeb,
      );
      if (result == null || !context.mounted) return;
      final images = _platformFilesToXFiles(result);
      if (images.isNotEmpty) {
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
