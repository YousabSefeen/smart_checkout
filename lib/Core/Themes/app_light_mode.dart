import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import '../App colors manager/app_colors_manager.dart';

class AppLightModel {
  static ThemeData get mode {
    return ThemeData(
      scrollbarTheme: ScrollbarThemeData(
        interactive: true,
        trackVisibility: const WidgetStatePropertyAll(true),
        thumbColor: WidgetStateProperty.all(const Color(0xff4F98CA)),
        trackColor: WidgetStateProperty.all(Colors.black12),
        trackBorderColor:
        WidgetStateProperty.all(Colors.white),
        radius: const Radius.circular(10),
        thickness: WidgetStateProperty.all(7),
      ),
      scaffoldBackgroundColor: AppColorsManagers.white,
      appBarTheme: AppBarTheme(
        backgroundColor: AppColorsManagers.white,
        titleTextStyle: TextStyle(
          fontSize: 25.sp,
          color: AppColorsManagers.black,
          fontWeight: FontWeight.w500,
        ),
        centerTitle: true,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ButtonStyle(
          textStyle: WidgetStatePropertyAll(
            TextStyle(
              color: AppColorsManagers.green,
              fontSize: 22.sp,
              fontWeight: FontWeight.w500,
            ),
          ),
          backgroundColor:
              const WidgetStatePropertyAll(AppColorsManagers.green),
          foregroundColor:
              const WidgetStatePropertyAll(AppColorsManagers.black),
          shape: WidgetStatePropertyAll(
            RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(15.r),
            ),
          ),
        ),
      ),
      textTheme: TextTheme(
        titleLarge: TextStyle(
          color: AppColorsManagers.black,
          fontSize: 24.sp,
          fontWeight: FontWeight.w600,
        ),
        titleMedium: TextStyle(
          color: AppColorsManagers.black,
          fontSize: 18.sp,
          fontWeight: FontWeight.w400,
        ),

      ),
    );
  }
}
