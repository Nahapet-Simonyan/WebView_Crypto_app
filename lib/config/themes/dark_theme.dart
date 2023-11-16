import 'package:flutter/material.dart';
import 'package:bin7r4decl/core/constants/colors.dart';

final ThemeData darkTheme = ThemeData(
  scaffoldBackgroundColor: AppColors.black,
  cardColor: AppColors.gray1,
  textTheme: const TextTheme(
    /// headline
    headlineLarge: TextStyle(
        fontSize: 28, fontWeight: FontWeight.w700, color: AppColors.white),
    headlineMedium: TextStyle(
        fontSize: 24, fontWeight: FontWeight.w700, color: AppColors.white),
    headlineSmall: TextStyle(
        fontSize: 20, fontWeight: FontWeight.w700, color: AppColors.white),

    /// title
    titleLarge: TextStyle(
        fontSize: 18, fontWeight: FontWeight.w500, color: AppColors.white),
    titleMedium: TextStyle(
        fontSize: 16, fontWeight: FontWeight.w500, color: AppColors.white),
    titleSmall: TextStyle(
        fontSize: 15, fontWeight: FontWeight.w500, color: AppColors.white),

    /// label
    labelLarge: TextStyle(
        fontSize: 16, fontWeight: FontWeight.w400, color: AppColors.white),
    labelMedium: TextStyle(
        fontSize: 14, fontWeight: FontWeight.w500, color: AppColors.white),
    labelSmall: TextStyle(
        fontSize: 12, fontWeight: FontWeight.w500, color: AppColors.white),

    /// body
    bodyLarge: TextStyle(
        fontSize: 14, fontWeight: FontWeight.w400, color: AppColors.white),
    bodyMedium: TextStyle(
        fontSize: 13, fontWeight: FontWeight.w400, color: AppColors.white),
    bodySmall: TextStyle(
        fontSize: 12, fontWeight: FontWeight.w400, color: AppColors.white),
  ),
);
