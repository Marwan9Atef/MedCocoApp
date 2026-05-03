import 'package:flutter/material.dart';
import 'package:medcoco/core/theme/app_color.dart';

class SimpleLoadingIndicator extends StatelessWidget {
  const SimpleLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return const Center(
      child: SizedBox(
        width: 24,
        height: 24,
        child: CircularProgressIndicator(color: AppColor.white, strokeWidth: 2),
      ),
    );
  }
}
