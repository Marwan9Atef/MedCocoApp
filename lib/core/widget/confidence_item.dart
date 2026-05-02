import 'package:flutter/widgets.dart';
import 'package:medcoco/core/theme/app_color.dart';
import 'package:medcoco/core/theme/app_style.dart';

class ConfidenceItem extends StatelessWidget {
  const ConfidenceItem({super.key, required this.confidence, this.isDesktop = false});

  final double confidence;
  final bool isDesktop;

  static Color getConfidenceColor(double confidence) {
    confidence = confidence + .6;
    if (confidence >= .8) {
      return AppColor.green;
    } else if (confidence >= .5) {
      return AppColor.yellow;
    } else {
      return AppColor.red;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: isDesktop ? const EdgeInsets.symmetric(horizontal: 8, vertical: 4) : const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
      decoration: ShapeDecoration(
        color: getConfidenceColor(confidence),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(isDesktop ? 8 : 26843500),
        ),
        shadows: [
          BoxShadow(
            color: const Color(0x19000000),
            blurRadius: 6,
            offset: Offset(0, 4),
            spreadRadius: -4,
          ),
          BoxShadow(
            color: const Color(0x19000000),
            blurRadius: 15,
            offset: Offset(0, 10),
            spreadRadius: -3,
          ),
        ],
      ),

      child: Text(
        "${((confidence + 0.6) * 100).clamp(0, 100).toInt()}%",
        style: AppStyles.styleRegular16(context),
      ),
    );
  }
}
