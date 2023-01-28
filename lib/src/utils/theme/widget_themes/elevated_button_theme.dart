import 'package:flutter/material.dart';

import '../../../constants/colors.dart';
import '../../../constants/sizes.dart';

class MButtonTheme {
  MButtonTheme._();

  static final lightElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      shape: RoundedRectangleBorder(),
      foregroundColor: Colors.white,
      backgroundColor: mSecondaryColor,
      side: BorderSide(
        color: mSecondaryColor,
      ),
      padding: EdgeInsets.symmetric(vertical: mButtonHeight),
    ),
  );
  static final darkElevatedButtonTheme = ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      elevation: 0,
      shape: RoundedRectangleBorder(),
      foregroundColor: mSecondaryColor,
      backgroundColor: Colors.white,
      side: BorderSide(
        color: mSecondaryColor,
      ),
      padding: EdgeInsets.symmetric(vertical: mButtonHeight),
    ),
  );

  static final lightOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(),
      foregroundColor: mSecondaryColor,
      side: BorderSide(
        color: mSecondaryColor,
      ),
      padding: EdgeInsets.symmetric(vertical: mButtonHeight),
    ),
  );
  static final darkOutlinedButtonTheme = OutlinedButtonThemeData(
    style: OutlinedButton.styleFrom(
      shape: RoundedRectangleBorder(),
      foregroundColor: Colors.white,
      side: BorderSide(
        color: Colors.white,
      ),
      padding: EdgeInsets.symmetric(vertical: mButtonHeight),
    ),
  );
}
