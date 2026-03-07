import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:valo/core/routes/route_center.dart';
import 'package:valo/core/theme/app_color.dart';
import 'package:valo/core/theme/app_style.dart';

class ForgetButton extends StatelessWidget {
  const ForgetButton({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        context.push(RouteCenter.forget);
      },
      child: Align(
        alignment: Alignment.centerRight,
        child: Text(
          "Forgot password?",
          style: AppStyles.styleRegular14(
            context,
          ).copyWith(color: AppColor.blue),
        ),
      ),
    );
  }
}
