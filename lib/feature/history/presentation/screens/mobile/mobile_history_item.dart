import 'package:flutter/material.dart';
import 'package:valo/feature/history/presentation/widgets/history_mobile_image.dart';
import '../../../../../core/dummy/model/ray_model.dart';
import '../../../../../core/theme/app_color.dart';
import '../../../../../core/theme/app_style.dart';


class MobileHistoryItem extends StatelessWidget {
  const MobileHistoryItem({super.key,required this.rayModel});
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
       HistoryMobileImage(imagePath: rayModel.imagePath,),
          const SizedBox(height: 10),

    Text(rayModel.title,style: AppStyles.styleRegular20(context),),
          const SizedBox(height: 6),
          Text(rayModel.description,style: AppStyles.styleRegular16(context).copyWith(color: AppColor.gray),),





        ],

      ),
    );
  }
}
