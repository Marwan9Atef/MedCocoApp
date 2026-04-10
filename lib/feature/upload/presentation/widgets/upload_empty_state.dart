import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:valo/core/generated/assets.dart';
import 'package:valo/core/utils/context_util.dart';
import 'package:valo/feature/upload/presentation/widgets/upload_button.dart';

import '../../../../core/theme/app_style.dart';
import 'custom_container.dart';

class UploadEmptyState extends StatelessWidget {
  const UploadEmptyState({super.key, required this.onPickImages});

  final VoidCallback onPickImages;

  @override
  Widget build(BuildContext context) {
    final isMobile = context.screenWidth < 800;

    return CustomContainer(
      child: Container(
        padding: EdgeInsets.all(isMobile ? 33 : 48),
        decoration: ShapeDecoration(
          shape: RoundedRectangleBorder(
            side: const BorderSide(width: 1.18, color: Color(0xFF3E3E46)),
            borderRadius: BorderRadius.circular(14),
          ),
        ),
        child: Column(
          children: [
            SvgPicture.asset(AppAssets.imagesUploadContainer, fit: BoxFit.scaleDown, width: 64, height: 64),
            const SizedBox(height: 16),
            Text("Drag and drop your medical image here", style: AppStyles.styleRegular18(context), textAlign: TextAlign.center),
            const SizedBox(height: 8),
            Text("or click to browse files", style: AppStyles.styleRegular18(context)),
            const SizedBox(height: 15),
            UploadButton(onTap: onPickImages),
          ],
        ),
      ),
    );
  }
}
