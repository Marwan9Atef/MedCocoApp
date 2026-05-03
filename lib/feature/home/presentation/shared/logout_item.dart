import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medcoco/core/di/service_locator.dart';
import 'package:medcoco/core/generated/assets.dart';
import 'package:medcoco/core/theme/app_color.dart';
import 'package:medcoco/core/theme/app_style.dart';
import 'package:medcoco/feature/auth/presentation/cubit/auth/auth_cubit.dart';
import 'package:medcoco/feature/history/presentation/cubit/history_cubit.dart';

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
        serviceLocator<AuthCubit>().logout();
        serviceLocator<HistoryCubit>().clearHistory();
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
