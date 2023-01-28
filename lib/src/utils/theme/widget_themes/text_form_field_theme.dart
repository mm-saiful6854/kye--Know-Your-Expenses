import 'package:flutter/material.dart';

import '../../../constants/colors.dart';

class mTextFormFieldTheme{
  static InputDecorationTheme lightInputDecorationTheme =  const InputDecorationTheme(
    prefixIconColor: mPrimaryColor,
    border: OutlineInputBorder(),
    floatingLabelStyle: TextStyle(color: mPrimaryColor),
    labelStyle: TextStyle(color: mPrimaryColor),
    focusedBorder: OutlineInputBorder(
        borderSide:BorderSide(width: 2.0, color: mPrimaryColor)),
  );


  static InputDecorationTheme darkInputDecorationTheme =  const InputDecorationTheme(
    prefixIconColor: mDarkThemeColor,
    border: OutlineInputBorder(),
    floatingLabelStyle: TextStyle(color: mDarkThemeColor),
    labelStyle: TextStyle(color: mDarkThemeColor),
    focusedBorder: OutlineInputBorder(
        borderSide:BorderSide(width: 2.0, color: mDarkThemeColor)),
  );
}