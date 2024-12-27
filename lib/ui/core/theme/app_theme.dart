import 'package:flutter/material.dart';
import 'package:planner_app/ui/core/theme/app_colors.dart';

class AppTheme {
  static final secondaryButtonStyle = ElevatedButton.styleFrom(
    backgroundColor: AppColors.zinc[800],
    foregroundColor: AppColors.zinc[200],
    disabledBackgroundColor: AppColors.zinc[800]!.withValues(alpha: 0.8),
    disabledForegroundColor: AppColors.zinc[200]!.withValues(alpha: 0.8),
    minimumSize: const Size(0, 48),
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
    iconColor: AppColors.zinc[200],
    disabledIconColor: AppColors.zinc[200]!.withValues(alpha: 0.8),
    textStyle: const TextStyle(
      fontFamily: 'Inter',
      fontSize: 16,
      fontWeight: FontWeight.w500,
    ),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );

  static InputDecoration filledInputDecoration(IconData icon, String hint) {
    return InputDecoration(
      filled: true,
      contentPadding: const EdgeInsets.symmetric(vertical: 20),
      prefixIcon: Padding(
        padding: const EdgeInsets.only(left: 16, right: 8),
        child: Icon(
          icon,
          color: AppColors.zinc,
        ),
      ),
      hintText: hint,
      fillColor: AppColors.zinc[950],
      enabledBorder: OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          color: AppColors.zinc[800]!,
        ),
      ),
    );
  }

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
    iconColor: AppColors.textButtonColor,
    disabledIconColor: AppColors.textButtonColor.withValues(alpha: 0.6),
    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
    shape: RoundedRectangleBorder(
      borderRadius: BorderRadius.circular(8),
    ),
  );

  static final appTheme = ThemeData(
    useMaterial3: true,
    brightness: Brightness.dark,
    colorSchemeSeed: AppColors.buttonColor,
    scaffoldBackgroundColor: AppColors.zinc[950],
    cardTheme: CardTheme(color: AppColors.zinc[900]),
    iconTheme: const IconThemeData(
      color: AppColors.zinc,
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
        color: AppColors.zinc,
      ),
      labelStyle: TextStyle(
        fontFamily: 'Inter',
        fontSize: 18,
        fontWeight: FontWeight.w400,
        color: AppColors.zinc,
      ),
    ),
    textTheme: TextTheme(
      bodySmall: const TextStyle(
        fontFamily: 'Inter',
        fontSize: 14,
        color: AppColors.zinc,
      ),
      bodyMedium: TextStyle(
        fontFamily: 'Inter',
        fontSize: 16,
        color: AppColors.zinc[300],
      ),
      bodyLarge: TextStyle(
        fontFamily: 'Inter',
        fontSize: 18,
        color: AppColors.zinc[200],
      ),
      displayLarge: const TextStyle(
        fontFamily: 'Inter',
        fontSize: 18,
        color: AppColors.zinc,
      ),
      titleSmall: const TextStyle(
        fontFamily: 'Inter',
        fontSize: 18,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      titleMedium: TextStyle(
        fontFamily: 'Inter',
        fontSize: 20,
        fontWeight: FontWeight.w600,
        color: AppColors.zinc[50],
      ),
      titleLarge: const TextStyle(
        fontFamily: 'Inter',
        fontSize: 24,
        fontWeight: FontWeight.w600,
        color: Colors.white,
      ),
      labelSmall: const TextStyle(
        fontFamily: 'Inter',
        fontSize: 12,
        color: AppColors.zinc,
      ),
      labelMedium: TextStyle(
        fontFamily: 'Inter',
        fontSize: 16,
        color: AppColors.zinc[100],
      ),
    ),
  )..colorScheme.copyWith(onError: AppColors.onError);
}
