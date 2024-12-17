import 'package:flutter/material.dart';
import 'package:planner_app/ui/core/theme/app_colors.dart';

class AppTheme {
  static final secondaryButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: AppColors.zinc800,
    foregroundColor: AppColors.textColor,
    disabledBackgroundColor: AppColors.zinc800.withValues(alpha: 0.8),
    disabledForegroundColor: AppColors.textColor.withValues(alpha: 0.8),
    minimumSize: const Size(0, 48),
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
    textStyle: const TextStyle(
      fontFamily: 'Inter',
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );

  static final primaryButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: AppColors.buttonColor,
    foregroundColor: AppColors.textButtonColor,
    disabledBackgroundColor: AppColors.buttonColor.withValues(alpha: 0.6),
    disabledForegroundColor: AppColors.textButtonColor.withValues(alpha: 0.6),
    minimumSize: const Size(0, 48),
    textStyle: const TextStyle(
      fontFamily: 'Inter',
      fontSize: 16,
      fontWeight: FontWeight.w600,
    ),
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );

  static final appTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorSchemeSeed: AppColors.buttonColor,
    scaffoldBackgroundColor: AppColors.zinc950,
    cardTheme: const CardTheme(color: AppColors.cardColor),
    iconTheme: const IconThemeData(
      color: AppColors.secondaryColor,
      size: 20,
    ),
    datePickerTheme: const DatePickerThemeData(
      todayForegroundColor:
          WidgetStatePropertyAll<Color>(AppColors.buttonColor),
      todayBackgroundColor:
          WidgetStatePropertyAll<Color>(AppColors.buttonColor),
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: primaryButtonStyle,
    ),
    textSelectionTheme: TextSelectionThemeData(
      cursorColor: AppColors.buttonColor,
      selectionColor: AppColors.buttonColor.withValues(alpha: 0.15),
    ),
    inputDecorationTheme: const InputDecorationTheme(
      border: InputBorder.none,
      hintStyle: TextStyle(
        fontFamily: 'Inter',
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: AppColors.secondaryColor,
      ),
      labelStyle: TextStyle(
        fontFamily: 'Inter',
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: AppColors.secondaryColor,
      ),
    ),
    textTheme: const TextTheme(
      bodySmall: TextStyle(
        fontFamily: 'Inter',
        fontSize: 14,
        color: AppColors.secondaryColor,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Inter',
        fontSize: 16,
        color: AppColors.textSecondColor,
      ),
      bodyLarge: TextStyle(
        fontFamily: 'Inter',
        fontSize: 18,
        color: AppColors.textColor,
      ),
      displayLarge: TextStyle(
        fontFamily: 'Inter',
        fontSize: 18,
        color: AppColors.secondaryColor,
      ),
      titleSmall: TextStyle(
        fontFamily: 'Inter',
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      titleMedium: TextStyle(
        fontFamily: 'Inter',
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: AppColors.secondaryColor,
      ),
      titleLarge: TextStyle(
        fontFamily: 'Inter',
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      labelSmall: TextStyle(
        fontFamily: 'Inter',
        fontSize: 12,
        color: AppColors.secondaryColor,
      ),
      labelMedium: TextStyle(
        fontFamily: 'Inter',
        fontSize: 16,
        fontWeight: FontWeight.w500,
        color: Colors.white,
      ),
    ),
  )..colorScheme.copyWith(onError: AppColors.onError);
}
