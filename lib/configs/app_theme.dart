import 'package:WeChat/configs/app_colors.dart';
import 'package:flutter/material.dart';

class AppTheme {
  static final lightTheme = ThemeData(
    brightness: Brightness.light,
    fontFamily: 'Inter',
    primaryColor: AppColors.primaryColor,
    scaffoldBackgroundColor: AppColors.lightBackground,
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: AppColors.primaryColor,
        textStyle: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30),
        )
      ),
    ),
  );
}
