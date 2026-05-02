import 'package:flutter/material.dart';
import 'package:medcoco/core/theme/app_color.dart';
import 'package:medcoco/core/theme/app_style.dart';

class MyUploadHeader extends StatelessWidget {
  const MyUploadHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("My Uploads",style: AppStyles.styleRegular36(context),),
        const SizedBox(
height: 8,

        ),
        Text("1 image uploaded",style: AppStyles.styleRegular16(context).copyWith(color: AppColor.gray),),
                const SizedBox(
height: 8,

        ),

    

      ],
    );
  }
}