import 'package:flutter/cupertino.dart';
import 'package:medcoco/core/theme/app_color.dart';
import 'package:medcoco/core/utils/context_util.dart';

class CustomContainer extends StatelessWidget {
  const CustomContainer({super.key,required this.child});
  final Widget child;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.all(context.screenWidth<800? 25: 48),
      decoration: ShapeDecoration(
        color: const Color(0xFF18181B),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 0.80,
            color:AppColor.black,
          ),
          borderRadius: BorderRadius.circular(16),
        ),
      ),
      child: child,

    );
  }
}
