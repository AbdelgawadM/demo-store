import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:our_store/core/app_colors.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    primaryColor: AppColors.kPrimaryColor,
    scaffoldBackgroundColor: AppColors.kScaffoldColor,
    textTheme: GoogleFonts.urbanistTextTheme(const TextTheme(
      displayMedium: TextStyle()
    )),
    colorScheme: ColorScheme.fromSeed(
      seedColor: AppColors.kPrimaryColor,
      brightness: Brightness.light,
    ),
    appBarTheme: const AppBarTheme(
      centerTitle: true,
      backgroundColor: AppColors.kPrimaryColor,
      foregroundColor: AppColors.kWhiteColor,
    ),
    useMaterial3: true,
  );

  static final darkTheme = ThemeData(
    brightness: Brightness.dark,
    primaryColor: AppColors.kPrimaryColor,
    scaffoldBackgroundColor: Colors.black,
    colorScheme: const ColorScheme.dark(
      primary: AppColors.kPrimaryColor,
      secondary: Colors.amber,
    ),
    textTheme: const TextTheme(
      bodyLarge: TextStyle(color: Colors.white),
      bodyMedium: TextStyle(color: Colors.white70),
    ),
    appBarTheme: const AppBarTheme(
      backgroundColor: AppColors.kPrimaryColor,
      foregroundColor: Colors.white,
    ),
    useMaterial3: true,
  );
}
