import 'package:flutter/material.dart';
import 'package:medcoco/core/theme/app_color.dart';
import 'package:medcoco/core/theme/app_style.dart';

import '../../feature/history/presentation/widgets/clear_icon.dart';


class DesktopClear extends StatelessWidget {
  const DesktopClear({super.key, required this.onTap});
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: ShapeDecoration(
        color: const Color(0x7F18181B),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 0.80,
            color: const Color(0xFF3E3E46),
          ),
          borderRadius: BorderRadius.circular(8),
        ),
      ),
      child: Material(
        type: MaterialType.transparency,
        child: InkWell(
          onTap: onTap,
          mouseCursor: SystemMouseCursors.click,
          borderRadius: BorderRadius.circular(8),
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
            child: Row(
              children: [
                const ClearIcon(),
                const SizedBox(width: 16),
                FittedBox(fit: BoxFit.scaleDown, child: Text("Clear", style: AppStyles.styleRegular14(context).copyWith(color: AppColor.red))),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

