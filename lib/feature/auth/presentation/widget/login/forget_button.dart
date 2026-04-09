import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:valo/core/routes/route_center.dart';
import 'package:valo/core/theme/app_color.dart';
import 'package:valo/core/theme/app_style.dart';

class ForgetButton extends StatelessWidget {
  const ForgetButton({super.key});

  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.click,
      child: InkWell(
        mouseCursor: SystemMouseCursors.click,
        onTap: () {
          context.push(RouteCenter.forget);
        },
        borderRadius: BorderRadius.circular(4),
        hoverColor: AppColor.blue.withValues(alpha: 0.1),
        focusColor: AppColor.blue.withValues(alpha: 0.1),
        splashColor: AppColor.blue.withValues(alpha: 0.2),
        child: Align(
          alignment: Alignment.centerRight,
          child: Text(
            "Forgot password?",
            style: AppStyles.styleRegular14(
              context,
            ).copyWith(color: AppColor.blue),
          ),
        ),
      ),
    );
  }
}
