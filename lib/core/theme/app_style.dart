import 'package:flutter/material.dart';
import 'package:medcoco/core/theme/size_config.dart';
import '../resources/font/font_family_manger.dart';
import 'app_color.dart';

abstract class AppStyles {
  static TextStyle styleRegular36(context) {
    return TextStyle(
      color: AppColor.white,
      fontSize: getResponsiveFontSize(context, fontSize: 36),
      fontFamily: FontFamilyManger.fontFamilyOne,
      fontWeight: FontWeight.w400,
    );
  }
  static TextStyle styleRegular30(context) {
    return TextStyle(
      color: AppColor.white,
      fontSize: getResponsiveFontSize(context, fontSize: 30),
      fontFamily: FontFamilyManger.fontFamilyOne,
      fontWeight: FontWeight.w400,
    );
  }
  static TextStyle styleRegular20(context) {
    return TextStyle(
      color: AppColor.white,
      fontSize: getResponsiveFontSize(context, fontSize: 20),
      fontFamily: FontFamilyManger.fontFamilyOne,
      fontWeight: FontWeight.w400,
    );
  }
  static TextStyle styleRegular18(context) {
    return TextStyle(
      color: AppColor.white,
      fontSize: getResponsiveFontSize(context, fontSize: 18),
      fontFamily: FontFamilyManger.fontFamilyOne,
      fontWeight: FontWeight.w400,
    );
  }
  static TextStyle styleRegular16(context) {
    return TextStyle(
      color: AppColor.white,
      fontSize: getResponsiveFontSize(context, fontSize: 16),
      fontFamily: FontFamilyManger.fontFamilyOne,
      fontWeight: FontWeight.w400,
    );
  }
  static TextStyle styleRegular14(context) {
    return TextStyle(
      color: AppColor.gray,
      fontSize: getResponsiveFontSize(context, fontSize: 14),
      fontFamily: FontFamilyManger.fontFamilyOne,
      fontWeight: FontWeight.w400,
    );
  }
  static TextStyle styleRegular12(context) {
    return TextStyle(
      color: AppColor.gray,
      fontSize: getResponsiveFontSize(context, fontSize: 12),
      fontFamily: FontFamilyManger.fontFamilyOne,
      fontWeight: FontWeight.w400,
    );
  }

  static TextStyle styleBold16(BuildContext context) {
    return TextStyle(
      color: AppColor.primaryColor,
      fontSize: getResponsiveFontSize(context, fontSize: 16),
      fontFamily: FontFamilyManger.fontFamilyOne,
      fontWeight: FontWeight.w700,
    );
  }

  static TextStyle styleMedium16(BuildContext context) {
    return TextStyle(
      color: AppColor.lightBlue,
      fontSize: getResponsiveFontSize(context, fontSize: 16),
      fontFamily: FontFamilyManger.fontFamilyOne,
      fontWeight: FontWeight.w500,
    );
  }



  static TextStyle styleSemiBold16(BuildContext context) {
    return TextStyle(
      color: AppColor.lightBlue,
      fontSize: getResponsiveFontSize(context, fontSize: 16),
      fontFamily: FontFamilyManger.fontFamilyOne,
      fontWeight: FontWeight.w600,
    );
  }

}

// sacleFactor
// responsive font size
// (min , max) fontsize
double getResponsiveFontSize(context, {required double fontSize}) {
  double scaleFactor = getScaleFactor(context);
  double responsiveFontSize = fontSize * scaleFactor;

  double lowerLimit = fontSize * .8;
  double upperLimit = fontSize * 1.2;

  return responsiveFontSize.clamp(lowerLimit, upperLimit);
}

double getScaleFactor(context) {
  // var dispatcher = PlatformDispatcher.instance;
  // var physicalWidth = dispatcher.views.first.physicalSize.width;
  // var devicePixelRatio = dispatcher.views.first.devicePixelRatio;
  // double width = physicalWidth / devicePixelRatio;

  double width = MediaQuery.sizeOf(context).width;
  if (width < SizeConfig.tablet) {
    return width / 550;
  } else {
    return width / 1350;
  }
}