import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart' show SvgPicture;
import 'package:medcoco/core/widget/simple_loading_indicator.dart';

import '../generated/assets.dart';

class RemoveContainer extends StatelessWidget {
  const RemoveContainer({
    super.key,
    required this.onTap,
    this.isLoading = false,
  });
  final VoidCallback  onTap;
  final bool isLoading;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 36,
      height: 36,
      decoration: ShapeDecoration(
        color: const Color(0x7F18181B),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1.18,
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
          child: isLoading
              ? const SimpleLoadingIndicator()
              : SvgPicture.asset(AppAssets.imagesRemoveIcon, fit: BoxFit.scaleDown),
        ),
      ),
    );
  }
}