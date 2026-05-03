import 'package:flutter/material.dart';
import 'package:medcoco/core/theme/app_color.dart';
import 'package:medcoco/core/theme/app_style.dart';
import 'package:medcoco/core/utils/context_util.dart';

class EmptyResultIndicator extends StatelessWidget {
  const EmptyResultIndicator({super.key, required this.subMessage});

  
  final String subMessage;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Icon(
            Icons.image_not_supported,
            size: context.screenHeight * 0.2,
            color: AppColor.gray,
          ),
          const SizedBox(height: 14),
          Text(
            "No Result",
            style: AppStyles.styleRegular16(context),
            textAlign: TextAlign.center,
          ),
          const SizedBox(height: 14),
          Text(
            subMessage,
            textAlign: TextAlign.center,
            style: AppStyles.styleRegular16(
              context,
            ).copyWith(color: AppColor.gray),
          ),
        ],
      ),
    );
  }
}
