import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:valo/feature/upload/presentation/cubit/upload_images_cubit.dart';

import 'compact_thumbnail.dart';

class CompactImageGrid extends StatelessWidget {
  const CompactImageGrid({super.key, required this.images});

  final List<XFile> images;

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: images.length,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 4,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemBuilder: (context, index) {
        return CompactThumbnail(
          image: images[index],
          onRemove: () => context.read<UploadImagesCubit>().removeImage(index),
        );
      },
    );
  }
}
