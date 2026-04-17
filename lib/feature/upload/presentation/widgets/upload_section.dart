import 'package:flutter/material.dart';
import 'package:valo/core/theme/app_color.dart';
import 'package:valo/feature/upload/presentation/cubit/upload_process_states.dart';

import 'upload_images_button.dart';
import 'upload_progress_indicator.dart';
import 'upload_status_banner.dart';

class UploadSection extends StatelessWidget {
  const UploadSection({
    super.key,
    required this.state,
    required this.onUpload,
  });

  final UploadProcessState state;
  final VoidCallback onUpload;

  @override
  Widget build(BuildContext context) {
    return switch (state) {
      UploadProcessIdle() => UploadImagesButton(onTap: onUpload),
      UploadProcessInProgress(:final progress) =>
        UploadProgressIndicator(progress: progress),
      UploadProcessSuccess() => UploadStatusBanner(
          icon: Icons.check_circle_outline,
          color: const Color(0xFF22C55E),
          message: 'Upload completed successfully!',
          action: UploadImagesButton(onTap: onUpload),
        ),
      UploadProcessFailure(:final error) => UploadStatusBanner(
          icon: Icons.error_outline,
          color: AppColor.red,
          message: error,
          action: UploadImagesButton(onTap: onUpload),
        ),
    };
  }
}
