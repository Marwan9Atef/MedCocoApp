import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:valo/core/theme/app_color.dart';
import 'package:valo/core/theme/app_style.dart';
import 'package:valo/feature/upload/presentation/cubit/upload_process_cubit.dart';
import 'package:valo/feature/upload/presentation/cubit/upload_process_states.dart';

import 'add_more_strip.dart';
import 'compact_image_grid.dart';
import 'custom_container.dart';
import 'images_header_row.dart';
import 'upload_images_button.dart';

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
              _buildUploadSection(context, uploadState),
            ],
          );
        },
      ),
    );
  }

  Widget _buildUploadSection(
    BuildContext context,
    UploadProcessState state,
  ) {
    return switch (state) {
      UploadProcessIdle() => UploadImagesButton(
          onTap: () =>
              context.read<UploadProcessCubit>().upload(images),
        ),
      UploadProcessInProgress(:final progress) =>
        _UploadProgressIndicator(progress: progress),
      UploadProcessSuccess() => _UploadStatusBanner(
          icon: Icons.check_circle_outline,
          color: const Color(0xFF22C55E),
          message: 'Upload completed successfully!',
          action: UploadImagesButton(
            onTap: () =>
                context.read<UploadProcessCubit>().upload(images),
          ),
        ),
      UploadProcessFailure(:final error) => _UploadStatusBanner(
          icon: Icons.error_outline,
          color: AppColor.red,
          message: error,
          action: UploadImagesButton(
            onTap: () =>
                context.read<UploadProcessCubit>().upload(images),
          ),
        ),
    };
  }
}

class _UploadProgressIndicator extends StatelessWidget {
  const _UploadProgressIndicator({required this.progress});

  final double progress;

  @override
  Widget build(BuildContext context) {
    final isIndeterminate = progress < 0;
    final percentage = isIndeterminate ? 0 : (progress * 100).toInt();

    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              'Uploading...',
              style: AppStyles.styleRegular14(context),
            ),
            if (!isIndeterminate)
              Text(
                '$percentage%',
                style: AppStyles.styleRegular14(context),
              ),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: isIndeterminate
              ? const LinearProgressIndicator(
                  minHeight: 8,
                  color: AppColor.primaryColor,
                  backgroundColor: Color(0xFF27272A),
                )
              : LinearProgressIndicator(
                  value: progress,
                  minHeight: 8,
                  color: AppColor.primaryColor,
                  backgroundColor: const Color(0xFF27272A),
                ),
        ),
      ],
    );
  }
}

class _UploadStatusBanner extends StatelessWidget {
  const _UploadStatusBanner({
    required this.icon,
    required this.color,
    required this.message,
    this.action,
  });

  final IconData icon;
  final Color color;
  final String message;
  final Widget? action;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          width: double.infinity,
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withValues(alpha: 0.1),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: color.withValues(alpha: 0.3)),
          ),
          child: Row(
            children: [
              Icon(icon, color: color, size: 20),
              const SizedBox(width: 8),
              Expanded(
                child: Text(
                  message,
                  style: AppStyles.styleRegular14(context).copyWith(color: color),
                ),
              ),
            ],
          ),
        ),
        if (action != null) ...[
          const SizedBox(height: 16),
          action!,
        ],
      ],
    );
  }
}
