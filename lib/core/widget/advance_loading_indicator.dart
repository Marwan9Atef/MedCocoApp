import 'package:flutter/material.dart';
import 'package:lottie/lottie.dart';
import '../theme/app_color.dart';

class AdvanceLoadingIndicator extends StatelessWidget {
  const AdvanceLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: ColorFiltered(
        colorFilter: ColorFilter.mode(AppColor.white, BlendMode.srcIn),
        child: Lottie.asset(
          'assets/animation/Doctor.json',
          width: 150,
          height: 150,
        ),
      ),
    );
  }
}
