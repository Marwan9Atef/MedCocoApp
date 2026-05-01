import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medcoco/feature/upload/presentation/cubit/upload_images_cubit.dart';

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
        )
            .animate(delay: (index * 30).ms)
            .fadeIn(
              duration: 180.ms,
              curve: Curves.easeOutCubic,
            )
            .slideY(
              begin: 0.06,
              end: 0,
              duration: 180.ms,
              curve: Curves.easeOutCubic,
            );
      },
    );
  }
}
