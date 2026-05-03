import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medcoco/core/theme/app_color.dart';
import 'package:medcoco/core/theme/app_style.dart';
import 'package:medcoco/core/utils/context_util.dart';
import 'package:medcoco/core/widget/desktop_clear.dart';
import 'package:medcoco/core/widget/remove_container.dart';
import 'package:medcoco/feature/my_upload/presentation/cubit/my_upload_cubit.dart';
import 'package:medcoco/core/widget/desktop_refresh_indicator.dart';

class MyUploadHeader extends StatelessWidget {
  const MyUploadHeader({super.key, required this.numberOfImages});
  final int numberOfImages;

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text("My Uploads", style: AppStyles.styleRegular36(context)),
            const SizedBox(height: 8),
            Text(
              "$numberOfImages image uploaded",
              style: AppStyles.styleRegular16(
                context,
              ).copyWith(color: AppColor.gray),
            ),
            const SizedBox(height: 8),
          ],
        ),
        Spacer(),
        context.screenWidth < 800
            ? RemoveContainer(
                onTap: () {
                  context.read<MyUploadCubit>().removeMyUploadImage();
                },
              )
            : Row(
                children: [
                  DesktopRefreshIndicator(
                    onTap: () {
                      context.read<MyUploadCubit>().getMyImages();
                    },
                  ),
                  const SizedBox(width: 16),
                  DesktopClear(
                    onTap: () {
                      context.read<MyUploadCubit>().removeMyUploadImage();
                    },
                  ),
                ],
              ),
      ],
    );
  }
}
