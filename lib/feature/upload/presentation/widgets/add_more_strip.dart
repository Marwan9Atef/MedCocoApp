import 'package:flutter/material.dart';
import 'package:valo/core/theme/app_color.dart';

import '../../../../core/theme/app_style.dart';

class AddMoreStrip extends StatelessWidget {
  const AddMoreStrip({super.key, required this.onTap});

  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      child: InkWell(
        mouseCursor: SystemMouseCursors.click,
        onTap: onTap,
        borderRadius: BorderRadius.circular(10),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 14),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            border: Border.all(color: const Color(0xFF3E3E46), width: 1),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.add_photo_alternate_outlined, color: AppColor.gray, size: 20),
              const SizedBox(width: 8),
              Text(
                "Add More Images",
                style: AppStyles.styleRegular14(context).copyWith(color: AppColor.gray),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
