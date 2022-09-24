import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const ColorScheme myColorScheme = ColorScheme(
  brightness: Brightness.light,
  primary: Color(0XFF243240),
  onPrimary: Colors.white,
  secondary: Color(0xff322440),
  onSecondary: Colors.white,
  error: Color(0xffd21400),
  onError: Colors.white,
  background: Colors.white,
  onBackground: Color(0XFF243240),
  surface: Color(0xffbacbff),
  onSurface: Colors.black12,
);

final TextTheme myTextTheme = TextTheme(
  headline1: GoogleFonts.poppins(
      fontSize: 93, fontWeight: FontWeight.w300, letterSpacing: -1.5),
  headline2: GoogleFonts.poppins(
      fontSize: 58, fontWeight: FontWeight.w300, letterSpacing: -0.5),
  headline3: GoogleFonts.poppins(fontSize: 46, fontWeight: FontWeight.w400),
  headline4: GoogleFonts.poppins(
      fontSize: 33, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  headline5: GoogleFonts.poppins(fontSize: 23, fontWeight: FontWeight.w400),
  headline6: GoogleFonts.poppins(
      fontSize: 19, fontWeight: FontWeight.w500, letterSpacing: 0.15),
  subtitle1: GoogleFonts.poppins(
      fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: 0.15),
  subtitle2: GoogleFonts.poppins(
      fontSize: 13, fontWeight: FontWeight.w500, letterSpacing: 0.1),
  bodyText1: GoogleFonts.poppins(
      fontSize: 15, fontWeight: FontWeight.w400, letterSpacing: 0.5),
  bodyText2: GoogleFonts.poppins(
      fontSize: 13, fontWeight: FontWeight.w400, letterSpacing: 0.25),
  button: GoogleFonts.poppins(
      fontSize: 13, fontWeight: FontWeight.w500, letterSpacing: 1.25),
  caption: GoogleFonts.poppins(
      fontSize: 12, fontWeight: FontWeight.w400, letterSpacing: 0.4),
  overline: GoogleFonts.poppins(
      fontSize: 10, fontWeight: FontWeight.w400, letterSpacing: 1.5),
);

ThemeData myThemeData = ThemeData(
    colorScheme: myColorScheme,
    textTheme: myTextTheme,
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: Colors.white,
      selectionColor: Colors.white.withOpacity(0.5),
      selectionHandleColor: Colors.grey,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: myColorScheme.primary,
      selectedItemColor: myColorScheme.onPrimary,
      unselectedItemColor: myColorScheme.onPrimary.withOpacity(0.35),
    ),
);
