import 'package:flutter/material.dart';
import 'package:valo/core/theme/app_color.dart';
import 'package:valo/core/theme/app_style.dart';
import 'package:valo/core/utils/context_util.dart';
import 'package:valo/core/widget/simple_loading_indicator.dart';

class CustomButton extends StatelessWidget {
  const CustomButton({super.key,required this.text,required this.onPressed, this.isLoading=false});
  final String text;
  final void Function() onPressed;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: AbsorbPointer(
        absorbing: isLoading,
        child: AnimatedContainer(
          curve: Curves.easeInOutQuint,
          duration: Duration(milliseconds: 500),
          width: isLoading
              ? context.screenWidth * 0.4
              : context.screenWidth,
          height: 48,
          decoration: ShapeDecoration(
            gradient: LinearGradient(
              begin: Alignment(0.00, 0.50),
              end: Alignment(1.00, 0.50),
              colors: [AppColor.lightBlue, AppColor.pruple],
            ),
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
          ),
          child: Material(
            type: MaterialType.transparency,
            child: InkWell(
              onTap: onPressed,
              mouseCursor: SystemMouseCursors.click,
              borderRadius: BorderRadius.circular(8),
              child: isLoading
                  ? const SimpleLoadingIndicator()
                  : Center(child: Text(text, style: AppStyles.styleRegular14(context).copyWith(color: AppColor.white))),
            ),
          ),
        ),
      ),
    );
  }
}
