import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:medcoco/core/theme/app_color.dart';
import 'package:medcoco/feature/upload/presentation/cubit/upload_images_cubit.dart';

import '../../../../core/theme/app_style.dart';

class ImagesHeaderRow extends StatelessWidget {
  const ImagesHeaderRow({super.key, required this.count});

  final int count;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          "Selected Images ($count)",
          style: AppStyles.styleRegular16(context),
        ),
        Material(
          color: Colors.transparent,
          borderRadius: BorderRadius.circular(6),
          child: InkWell(
            mouseCursor: SystemMouseCursors.click,
            onTap: () => context.read<UploadImagesCubit>().clear(),
            borderRadius: BorderRadius.circular(6),
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 4),
              child: Text(
                "Clear All",
                style: AppStyles.styleRegular14(context).copyWith(color: AppColor.red),
              ),
            ),
          ),
        ),
      ],
    );
  }
}
