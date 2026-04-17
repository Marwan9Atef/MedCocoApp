import 'package:flutter/material.dart';
import 'package:valo/core/theme/app_color.dart';
import 'package:valo/core/theme/app_style.dart';

class UploadProgressIndicator extends StatelessWidget {
  const UploadProgressIndicator({super.key, required this.progress});

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
