import 'package:flutter/material.dart';

// #1571B4
// #B6191B
// #252B2F
final theme = ThemeData.from(
  useMaterial3: false,
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: const MaterialColor(
      0xff105292,
      <int, Color>{
        50: Color(0xffe1f4fd),
        100: Color(0xffb3e3fa),
        200: Color(0xff82d0f6),
        300: Color(0xff52bef1),
        400: Color(0xff33b1ee),
        500: Color(0xff1da3eb),
        600: Color(0xff1b95dc),
        700: Color(0xff1783c8),
        800: Color(0xff1572b4),
        900: Color(0xff105292),
      },
    ),
    accentColor: const Color(0xff1572b4),
    cardColor: Colors.white,
    backgroundColor: Colors.grey[50],
    errorColor: Colors.red,
  ),
).copyWith(
  scaffoldBackgroundColor: Colors.grey[200],
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xff105292),
  ),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Colors.white,
    foregroundColor: Color(0xff105292),
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: const Color(0xff1571B4),
    selectionColor: const Color(0xff1571B4).withOpacity(0.7),
  ),
);

final themeDark = ThemeData.from(
  useMaterial3: false,
  colorScheme: ColorScheme.fromSwatch(
    primarySwatch: const MaterialColor(
      0xff263238,
      <int, Color>{
        50: Color(0xffeceff1),
        100: Color(0xffcfd8dc),
        200: Color(0xffb0bec5),
        300: Color(0xff90a4ae),
        400: Color(0xff78909c),
        500: Color(0xff607d8b),
        600: Color(0xff546e7a),
        700: Color(0xff455a64),
        800: Color(0xff37474f),
        900: Color(0xff263238),
      },
    ),
    accentColor: const Color(0xff1572b4),
    cardColor: const Color(0xff182025),
    brightness: Brightness.dark,
  ),
).copyWith(
  scaffoldBackgroundColor: Colors.grey[800],
  dialogBackgroundColor: const Color(0xff141515),
  floatingActionButtonTheme: const FloatingActionButtonThemeData(
    backgroundColor: Color(0xff263238),
    foregroundColor: Colors.white,
  ),
  drawerTheme: const DrawerThemeData(
    backgroundColor: Color(0xff141515),
  ),
  appBarTheme: const AppBarTheme(
    backgroundColor: Color(0xff161919),
  ),
  progressIndicatorTheme: const ProgressIndicatorThemeData(
    color: Color(0xff1571B4),
  ),
  textSelectionTheme: TextSelectionThemeData(
    cursorColor: const Color(0xff1571B4),
    selectionColor: const Color(0xff1571B4).withOpacity(0.7),
  ),
);
