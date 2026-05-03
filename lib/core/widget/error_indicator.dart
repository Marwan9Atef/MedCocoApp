import 'package:flutter/material.dart';
import 'package:medcoco/core/theme/app_color.dart';
import 'package:medcoco/core/theme/app_style.dart';
import 'package:medcoco/core/utils/context_util.dart';
import 'package:medcoco/core/widget/custom_button.dart';

class ErrorIndicator extends StatelessWidget {
  const ErrorIndicator({super.key, required this.onPressed});
  final VoidCallback onPressed;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Icon(
            Icons.wifi_off,
            size: context.screenHeight * 0.2,
            color: AppColor.gray,
          ),
          const SizedBox(height: 14),
          Text(
            "No Internet Connection",
            style: AppStyles.styleRegular16(context),
          ),
          const SizedBox(height: 14),
          Text(
            "Please check your internet connection and try again",
            textAlign: TextAlign.center,
            style: AppStyles.styleRegular16(
              context,
            ).copyWith(color: AppColor.gray),
          ),
          const SizedBox(height: 32),
          CustomButton(text: "Try Again", onPressed: onPressed),
        ],
      ),
    );
  }
}
