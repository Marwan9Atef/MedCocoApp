import 'package:flutter/material.dart';
import 'package:medcoco/core/theme/app_color.dart';

import '../../../../core/theme/app_style.dart';

class UploadImagesButton extends StatelessWidget {
  const UploadImagesButton({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 44,
      child: Material(
        color: AppColor.primaryColor,
        borderRadius: BorderRadius.circular(10),
        child: InkWell(
          onTap: onTap,
          mouseCursor: SystemMouseCursors.click,
          borderRadius: BorderRadius.circular(10),
          child: Center(
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                const Icon(Icons.cloud_upload_outlined, color: AppColor.white, size: 20),
                const SizedBox(width: 8),
                Text(
                  "Upload Images",
                  style: AppStyles.styleRegular16(context).copyWith(color: AppColor.white),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
