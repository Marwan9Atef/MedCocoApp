
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:medcoco/core/generated/assets.dart';

class ClearIcon extends StatelessWidget {
  const ClearIcon({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return SvgPicture.asset(AppAssets.imagesRemoveIcon,width: 16,height: 16,fit: BoxFit.scaleDown,);
  }
}