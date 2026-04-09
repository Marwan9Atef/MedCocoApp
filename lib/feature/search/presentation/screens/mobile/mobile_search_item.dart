import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:valo/core/utils/sizebox_util.dart';
import '../../../../../core/dummy/model/ray_model.dart';
import '../../../../../core/routes/route_center.dart';
import '../../../../../core/theme/app_color.dart';
import '../../../../../core/theme/app_style.dart';

class MobileSearchItem extends StatelessWidget {
   const MobileSearchItem({super.key,required this.rayModel});

  final RayModel rayModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 16),
      decoration:BoxDecoration(
        color:const Color(0xff18181B),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          InkWell(
            onTap: (){
              context.push(RouteCenter.fullScreenImage,extra: rayModel.imagePath);
            },
            mouseCursor: SystemMouseCursors.click,
            child: ClipRRect(
              borderRadius: BorderRadiusGeometry.all(
                 Radius.circular(14),
              ),
                clipBehavior: Clip.antiAlias,
                child: Image.asset(rayModel.imagePath,fit: BoxFit.cover,width: double.infinity,)),
          ),
          10.hight,
             Text(rayModel.title,style: AppStyles.styleRegular20(context),),
          6.hight,
          Text(rayModel.description,style: AppStyles.styleRegular16(context).copyWith(color: AppColor.gray),),





        ],

      ),
    );
  }
}
