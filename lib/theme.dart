// flutter
import 'package:flutter/material.dart';
// external packages
import 'package:google_fonts/google_fonts.dart';

/// App theme.
final ThemeData appTheme = ThemeData(
  useMaterial3: true,
  appBarTheme: const AppBarTheme(
    centerTitle: true,
    color: Color.fromRGBO(57, 75, 112, 1.0),
    titleTextStyle: TextStyle(
      color: Colors.white,
      fontSize: 30,
    ),
  ),
  // Define the default brightness and colors.
  colorScheme: ColorScheme.fromSeed(
    seedColor: const Color.fromRGBO(57, 75, 112, 1.0),
    // UG colors
    primary: const Color.fromRGBO(57, 75, 112, 1.0),
    secondary: const Color.fromRGBO(146, 156, 98, 1.0),
    tertiary: const Color.fromRGBO(247, 210, 114, 1.0),
  ),
  // Define the default `TextTheme`. Use this to specify the default
  // text styling for headlines, titles, bodies of text, and more.
  textTheme: TextTheme(
    displayLarge: const TextStyle(
      fontSize: 72,
      fontWeight: FontWeight.bold,
    ),
    titleLarge: GoogleFonts.raleway(
      fontSize: 30,
      fontStyle: FontStyle.normal,
    ),
    bodyMedium: GoogleFonts.roboto(),
    displaySmall: GoogleFonts.roboto(),
  ),
);

MaterialColor getMaterialColor(Color color) {
  final int red = color.red;
  final int green = color.green;
  final int blue = color.blue;

  final Map<int, Color> shades = {
    50: Color.fromRGBO(red, green, blue, .1),
    100: Color.fromRGBO(red, green, blue, .2),
    200: Color.fromRGBO(red, green, blue, .3),
    300: Color.fromRGBO(red, green, blue, .4),
    400: Color.fromRGBO(red, green, blue, .5),
    500: Color.fromRGBO(red, green, blue, .6),
    600: Color.fromRGBO(red, green, blue, .7),
    700: Color.fromRGBO(red, green, blue, .8),
    800: Color.fromRGBO(red, green, blue, .9),
    900: Color.fromRGBO(red, green, blue, 1),
  };

  return MaterialColor(color.value, shades);
}
