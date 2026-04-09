import 'package:flutter/material.dart';

import '../../../../core/theme/app_color.dart';
import '../../../../core/theme/app_style.dart';


class NavTextButton extends StatelessWidget {
  const NavTextButton({super.key,required this.onTap,required this.prefText,required this.suffixText});
  final VoidCallback onTap;
  final String prefText;
  final String suffixText;
  @override
  Widget build(BuildContext context) {
    return Center(
      child: RichText(
        text: TextSpan(
          text: prefText,
          style: AppStyles.styleRegular14(context),
          children: [
            WidgetSpan(
              child: MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Material(
                  type: MaterialType.transparency,
                  child: InkWell(
                    onTap: onTap,
                    borderRadius: BorderRadius.circular(4),
                    hoverColor: AppColor.blue.withValues(alpha: 0.1),
                    focusColor: AppColor.blue.withValues(alpha: 0.1),
                    splashColor: AppColor.blue.withValues(alpha: 0.2),
                    child: Text(
                      suffixText,
                      style: AppStyles.styleRegular14(context).copyWith(color: AppColor.blue),
                    ),
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
