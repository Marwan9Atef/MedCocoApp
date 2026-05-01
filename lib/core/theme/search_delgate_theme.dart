import 'package:flutter/material.dart';
import 'package:medcoco/core/resources/font/font_family_manger.dart';
import 'package:medcoco/core/resources/font/font_weight_manger.dart';
import 'package:medcoco/core/theme/app_color.dart';



class SearchDelegateTheme {
  static ThemeData searchTheme=ThemeData(
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: AppColor.black,

    ),
    appBarTheme: AppBarTheme(



      backgroundColor: AppColor.anotherBlack,

    ),
    scaffoldBackgroundColor: AppColor.anotherBlack,

    inputDecorationTheme: InputDecorationTheme(
      fillColor: const Color(0xff18181B),
      filled: true,

      contentPadding: EdgeInsets.symmetric(horizontal: 12, vertical: 10),
      hintStyle: TextStyle(color: AppColor.white),
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.transparent, width: 1),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(12),
        borderSide: BorderSide(color: Colors.transparent, width: 1),
      ),
    ),
    textTheme: TextTheme(
      titleLarge: TextStyle(color: AppColor.white, fontSize: 14, fontWeight: FontWeightManager.regular,fontFamily:FontFamilyManger.fontFamilyOne ),

    ),







  );



}