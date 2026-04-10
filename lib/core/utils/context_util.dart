import 'package:flutter/material.dart';

extension ContextUtil on BuildContext {
  ThemeData get theme => Theme.of(this);


  double get screenWidth => MediaQuery.sizeOf(this).width;
  double get screenHeight => MediaQuery.sizeOf(this).height;

  double get statusBarHeight => MediaQuery.paddingOf(this).top;
  double get bottomBarHeight => MediaQuery.paddingOf(this).bottom;
  double get keyboardHeight => MediaQuery.viewInsetsOf(this).bottom;
}