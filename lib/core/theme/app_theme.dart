import 'package:flutter/material.dart';
import 'package:medcoco/core/resources/font/font_family_manger.dart';
import '../resources/font/font_weight_manger.dart';
import 'app_color.dart';

class AppTheme {
  static ThemeData darkTheme = ThemeData(
    scaffoldBackgroundColor: AppColor.anotherBlack,
    appBarTheme: AppBarTheme(
      backgroundColor: const Color(0x7F3E3E46),
      foregroundColor: AppColor.white,



    ),
      navigationBarTheme:NavigationBarThemeData(
        backgroundColor: AppColor.anotherBlack,
        indicatorColor: AppColor.primaryColor,
     indicatorShape:RoundedRectangleBorder(
       borderRadius: BorderRadius.circular(20),


     ),
        labelTextStyle: WidgetStateTextStyle.resolveWith((states) {
          if (states.contains(WidgetState.selected)) {
            return TextStyle(
              color: AppColor.primaryColor,
              fontSize: 12,
              fontWeight: FontWeightManager.regular,
              fontFamily: FontFamilyManger.fontFamilyOne,
            );
          }
          return TextStyle(
            color: AppColor.gray,
            fontSize: 12,
            fontWeight: FontWeightManager.regular,
            fontFamily: FontFamilyManger.fontFamilyOne,
          );
        }),


      )









  );
  static ThemeData lightTheme = ThemeData(

  );



}