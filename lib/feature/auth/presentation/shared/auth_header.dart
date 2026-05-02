import 'package:flutter_svg/flutter_svg.dart';
import 'package:medcoco/core/generated/assets.dart';
import 'package:flutter/cupertino.dart';
import 'package:medcoco/core/theme/app_color.dart';
import 'package:medcoco/core/theme/app_style.dart';
class AuthHeader extends StatelessWidget {
  const AuthHeader({super.key,required this.title,required this.subtitle});
  final String title;
  final String subtitle;

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SvgPicture.asset(AppAssets.logo),
        const SizedBox(height: 13),
        Text(title,style: AppStyles.styleRegular30(context),),
        const SizedBox(height: 13),
        Text(subtitle,style: AppStyles.styleRegular16(context).copyWith(color: AppColor.gray),),
        const SizedBox(height: 32),

      ],
    );
  }
}
