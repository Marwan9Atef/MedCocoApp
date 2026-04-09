import 'package:flutter/material.dart';

import '../theme/app_color.dart';



abstract class AppSnackBars {
  static void showSuccessSnackBar({
    required BuildContext context,
    required String message,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: AppColor.white),
        ),
        backgroundColor: AppColor.primaryColor,
      ),
    );
  }

  static void showErrorSnackBar({
    required BuildContext context,
    required String message,
  }) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          message,
          style: TextStyle(color: AppColor.white),
        ),
        backgroundColor: AppColor.red,
      ),
    );
  }
}