import 'package:flutter/material.dart';

import 'package:medcoco/core/theme/app_style.dart';
import 'package:medcoco/feature/my_upload/data/models/my_images_response_model.dart';
import 'package:medcoco/feature/my_upload/presentation/screens/mobile/my_upload_mobile_image.dart';

class MyUploadMobileItem extends StatelessWidget {
  const MyUploadMobileItem({super.key,required this.image});
  final MyImageModel image;
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
       MyUploadMobileImage(imagePath: image.fileUrl,),
          const SizedBox(height: 10),

    Text(image.filename,style: AppStyles.styleRegular20(context),),






        ],

      ),
    );
  }
}