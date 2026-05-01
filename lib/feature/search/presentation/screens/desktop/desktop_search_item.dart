import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:go_router/go_router.dart';
import 'package:medcoco/core/theme/app_color.dart';
import 'package:medcoco/core/theme/app_style.dart';
import '../../../../../core/dummy/model/ray_model.dart';
import '../../../../../core/generated/assets.dart';
import '../../../../../core/routes/route_center.dart';

class DesktopSearchItem extends StatelessWidget {
  const DesktopSearchItem({super.key,required this.rayModel});
  final RayModel rayModel;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16,vertical: 12),
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
        topLeft:   Radius.circular(14),
        bottomLeft: Radius.circular(14),
            ),
              clipBehavior: Clip.antiAlias,
              child: Image.asset(rayModel.imagePath,fit: BoxFit.fill,height: 200,width: 200,)),
          const SizedBox(width: 16),
           Expanded(
             child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                 Text(rayModel.title,style: AppStyles.styleRegular20(context),),
                const SizedBox(height: 10),
                Text(rayModel.description,style: AppStyles.styleRegular16(context).copyWith(color: AppColor.gray),),
                const SizedBox(height: 15),
                IntrinsicWidth(
                  child: Container(
                    decoration: ShapeDecoration(
                      color: AppColor.primaryColor,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                    ),
                    child: Material(
                      type: MaterialType.transparency,
                      child: InkWell(
                        onTap: (){
                          context.push(RouteCenter.fullScreenImage,extra: rayModel.imagePath);
                        },
                        mouseCursor: SystemMouseCursors.click,
                        borderRadius: BorderRadius.circular(10),
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                          child: Row(
                            children: [
                              SvgPicture.asset(AppAssets.imagesDetailsSvg, fit: BoxFit.scaleDown, height: 16, width: 16),
                              const SizedBox(width: 8),
                              Text("View Details", style: AppStyles.styleRegular14(context).copyWith(color: AppColor.white)),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                )




              ],
                       ),
           ),




        ],
      ),
    );
  }
}
