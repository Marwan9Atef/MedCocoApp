import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:valo/core/routes/route_center.dart';
import 'package:valo/core/theme/app_color.dart';
import 'package:valo/core/theme/app_style.dart';
import 'package:valo/core/utils/sizebox_util.dart';
import '../../../../../core/dummy/model/ray_model.dart';
import '../../../../../core/generated/assets.dart';
import '../../../../../core/widget/remove_container.dart';

class DesktopHistoryItem extends StatelessWidget {
  const DesktopHistoryItem({super.key,required this.rayModel});
  final RayModel rayModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 16),
      padding: const EdgeInsets.only(right: 16),
      decoration: BoxDecoration(
        color:const Color(0xff18181B),
        borderRadius: BorderRadius.circular(14),
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          ClipRRect(
              borderRadius: BorderRadiusGeometry.only(
                 topLeft: Radius.circular(14),
                 bottomLeft: Radius.circular(14),
              ),
              clipBehavior: Clip.antiAlias,
              child: Image.asset(rayModel.imagePath,fit: BoxFit.fill,width: 200,height: 200,)),
          16.width,
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(rayModel.title,style: AppStyles.styleRegular20(context),),
                10.hight,
       Text(rayModel.description,style: AppStyles.styleRegular16(context).copyWith(color: AppColor.gray),),
                15.hight,
                Row(
                  children: [
                    InkWell(
                        onTap: (){
context.push(
  RouteCenter.fullScreenImage,
  extra: rayModel.imagePath,
);
                        },
                        mouseCursor: SystemMouseCursors.click,
                        child: SvgPicture.asset(AppAssets.detailsContainer,fit: BoxFit.scaleDown,height:36,width: 36,)),
                    12.width,
                    RemoveContainer(
                      onTap: (){
                      },
                    ),



                  ],
                )

              ],
            ),
          ),




        ],
      ),
    );
  }
}


