import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class mTextTheme {
  mTextTheme._();

  static final TextTheme lightTextTheme  = TextTheme(
    headline1: GoogleFonts.montserrat(fontSize: 28.0),
    headline2: GoogleFonts.montserrat(fontSize: 24.0),
    headline3: GoogleFonts.montserrat(fontSize: 18.0),
    headline4: GoogleFonts.montserrat(fontSize: 15.0),
    headline6: GoogleFonts.montserrat(fontSize: 16.0),
    bodyText1: GoogleFonts.montserrat(fontSize: 15.0, fontWeight: FontWeight.bold,),
    bodyText2: GoogleFonts.montserrat(fontSize: 13.0),
  );


  static final TextTheme darkTextTheme  = TextTheme(
    headline1: GoogleFonts.montserrat(fontSize: 28.0),
    headline2: GoogleFonts.montserrat(fontSize: 24.0),
    headline6: GoogleFonts.montserrat(fontSize: 16.0),
  );
}