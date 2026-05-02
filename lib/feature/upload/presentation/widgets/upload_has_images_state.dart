import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:medcoco/feature/my_upload/presentation/cubit/my_upload_cubit.dart';
import 'package:medcoco/feature/upload/presentation/cubit/upload_process_cubit.dart';
import 'package:medcoco/feature/upload/presentation/cubit/upload_process_states.dart';

import 'add_more_strip.dart';
import 'compact_image_grid.dart';
import 'custom_container.dart';
import 'images_header_row.dart';
import 'upload_section.dart';

class UploadHasImagesState extends StatelessWidget {
  const UploadHasImagesState({
    super.key,
    required this.images,
    required this.onPickImages,
  });

  final List<XFile> images;
  final VoidCallback onPickImages;

  @override
  Widget build(BuildContext context) {
    return CustomContainer(
      child: BlocBuilder<UploadProcessCubit, UploadProcessState>(
        builder: (context, uploadState) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              ImagesHeaderRow(count: images.length),
              const SizedBox(height: 16),
              CompactImageGrid(images: images),
              const SizedBox(height: 16),
              if (uploadState is! UploadProcessInProgress)
                AddMoreStrip(onTap: onPickImages),
              if (uploadState is! UploadProcessInProgress)
                const SizedBox(height: 20),
              UploadSection(
                state: uploadState,
                onUpload: () async {
                  await context.read<UploadProcessCubit>().upload(images);
                  if (context.mounted) {
                    context.read<MyUploadCubit>().getMyImages();

                  }
                      
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
