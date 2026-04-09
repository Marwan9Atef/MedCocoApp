import 'package:flutter/material.dart';
import 'package:valo/core/utils/context_util.dart';

class AuthContainer extends StatelessWidget {
  const AuthContainer({super.key,required this.child, this.width = 0.65});
  final Widget child;
  final double? width;

  @override
  Widget build(BuildContext context) {
    final bool isMobile = context.screenWidth < 800 ;

    return Container(
      width: isMobile ? double.infinity : context.screenWidth * (width ?? 0.65),
      padding: const EdgeInsets.all(23),
      decoration: ShapeDecoration(
        color: const Color(0xFF18181B),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1.18,
            color: const Color(0xFF26262A),
          ),
          borderRadius: BorderRadius.circular(14),
        ),
      ),
child: child,

    );
  }
}
