import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:valo/core/generated/assets.dart';
import 'package:valo/core/theme/app_color.dart';
import 'package:valo/core/theme/app_style.dart';
import 'package:valo/core/utils/sizebox_util.dart';

class BeforeSearchItem extends StatelessWidget {
  const BeforeSearchItem({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(
 horizontal: 16,
        vertical: 12,
      ),
      clipBehavior: Clip.antiAlias,
      decoration: ShapeDecoration(
        color: const Color(0xFF18181B),
        shape: RoundedRectangleBorder(
          side: BorderSide(
            width: 1.18,
            color: AppColor.black,
          ),
          borderRadius: BorderRadius.circular(14),
        ),
      ),
      child: Row(
        children: [
          SvgPicture.asset(AppAssets.imagesSearchIcon,height: 20,width: 20,fit: BoxFit.scaleDown,),
          12.width,
          Text("search by keywords...",style:AppStyles.styleRegular16(context),)

        ],
      ),

    );
  }
}
