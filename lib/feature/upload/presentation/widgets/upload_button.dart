import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medcoco/core/generated/assets.dart';
import 'package:medcoco/core/theme/app_color.dart';
import 'package:medcoco/core/theme/app_style.dart';

class UploadButton extends StatelessWidget {
  const UploadButton({super.key,required this.onTap});
final VoidCallback onTap;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 36,
      width: 150,
      decoration: ShapeDecoration(
        color: AppColor.primaryColor,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onTap,
          mouseCursor: SystemMouseCursors.click,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: EdgeInsets.symmetric(horizontal: 12, vertical: 7),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(AppAssets.imagesImageIcon, height: 15, width: 15, fit: BoxFit.scaleDown),
                const SizedBox(width: 16),
                FittedBox(fit: BoxFit.scaleDown, child: Text("Select File", style: AppStyles.styleRegular14(context).copyWith(color: AppColor.white))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
