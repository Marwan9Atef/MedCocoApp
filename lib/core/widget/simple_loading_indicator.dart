import 'package:flutter/material.dart';
import 'package:medcoco/core/theme/app_color.dart';

class SimpleLoadingIndicator extends StatelessWidget {
  const SimpleLoadingIndicator({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(child: Center(child: CircularProgressIndicator(color: AppColor.white,)));
  }
}