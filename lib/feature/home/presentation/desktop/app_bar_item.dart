import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:medcoco/core/theme/app_color.dart';
import 'package:medcoco/core/theme/app_style.dart';

import '../../data/item_model.dart';

class AppBarItem extends StatelessWidget {
  const AppBarItem({super.key,this.isActive=false,required this.item});
  final bool isActive;
  final ItemModel item;

  @override
  Widget build(BuildContext context) {
    return AnimatedContainer(
      duration: const Duration(milliseconds: 300),
      curve: Curves.bounceInOut,
      padding: const EdgeInsets.symmetric(horizontal: 24,vertical: 12),
      decoration:isActive? ShapeDecoration(
        gradient: LinearGradient(
          begin: Alignment(0.00, 0.50),
          end: Alignment(1.00, 0.50),
          colors: [const Color(0xFF155CFB), AppColor.lightBlue],
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(14),
        ),
        shadows: [
          BoxShadow(
            color: Color(0x4C155CFB),
            blurRadius: 6,
            offset: Offset(0, 4),
            spreadRadius: -4,
          ),
          BoxShadow(
            color: Color(0x4C155CFB),
            blurRadius: 15,
            offset: Offset(0, 10),
            spreadRadius: -3,
          )
        ],
      ):null,
      child: Row(
        children: [
          SvgPicture.asset(item.iconPath,height: 20,width: 20,fit: BoxFit.scaleDown,colorFilter: ColorFilter.mode(isActive? AppColor.white:AppColor.gray, BlendMode.srcIn),),
          const SizedBox(width: 8),
          Text(item.title,style:AppStyles.styleRegular16(context).copyWith(color: isActive? AppColor.white:AppColor.gray)),



        ],
      ),

    );
  }
}

