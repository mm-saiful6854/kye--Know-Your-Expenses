import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:kye/src/constants/colors.dart';
import 'package:kye/src/utils/theme/widget_themes/elevated_button_theme.dart';
import 'package:kye/src/utils/theme/widget_themes/text_form_field_theme.dart';
import 'package:kye/src/utils/theme/widget_themes/text_theme.dart';

class MAppTheme {
  MAppTheme._();

  static final ThemeData lightTheme = ThemeData(
    brightness: Brightness.light,
    primarySwatch: Colors.brown,
    backgroundColor: mPrimaryColor,
    primaryColor: Colors.brown,
    textTheme: mTextTheme.lightTextTheme,
    elevatedButtonTheme: MButtonTheme.lightElevatedButtonTheme,
    outlinedButtonTheme: MButtonTheme.lightOutlinedButtonTheme,
    inputDecorationTheme: mTextFormFieldTheme.lightInputDecorationTheme,
  );

  static final ThemeData darkTheme = ThemeData(
      brightness: Brightness.dark,
      textTheme: mTextTheme.darkTextTheme,
      elevatedButtonTheme: MButtonTheme.darkElevatedButtonTheme,
      outlinedButtonTheme: MButtonTheme.darkOutlinedButtonTheme,
      primarySwatch: Colors.brown,
      inputDecorationTheme: mTextFormFieldTheme.darkInputDecorationTheme);
}
