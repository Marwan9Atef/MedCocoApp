import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:valo/core/generated/assets.dart';
import 'package:valo/core/routes/route_center.dart';
import 'package:valo/core/theme/app_color.dart';
import 'package:valo/core/theme/app_style.dart';

class LogoutItem extends StatelessWidget {
  const LogoutItem({super.key,});



  @override
  Widget build(BuildContext context) {
    return Material(
      color: Colors.transparent,
      borderRadius: BorderRadius.circular(14),
      child: InkWell(
      mouseCursor: SystemMouseCursors.click,
      onTap: () {
      context.go(RouteCenter.login);
      },
      borderRadius: BorderRadius.circular(14),
      hoverColor: AppColor.red.withValues(alpha: 0.1),
      splashColor: AppColor.red.withValues(alpha: 0.2),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
        child: Row(
          children: [
            SvgPicture.asset(
              AppAssets.imagesLogoutIcon,
              height: 20,
              width: 20,
              fit: BoxFit.scaleDown,
              colorFilter: const ColorFilter.mode(AppColor.red, BlendMode.srcIn),
            ),
            const SizedBox(width: 8),
            Text(
              "Logout",
              style: AppStyles.styleRegular16(context).copyWith(color: AppColor.red),
            ),
          ],
        ),
      ),
            ));
  }
}
