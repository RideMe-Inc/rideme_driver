import 'package:flutter/material.dart';
import 'package:rideme_driver/core/theme/app_colors.dart';

final appLightTheme = ThemeData(
  useMaterial3: true,
  fontFamily: 'Outfit',
  textTheme: _lightTextTheme,
  primaryColor: AppColors.rideMeBlack400,
  brightness: Brightness.light,
  appBarTheme: _appBarThemeLight,
  scaffoldBackgroundColor: AppColors.rideMeBackgroundLight,
  inputDecorationTheme: _inputDecorationThemeLight,
  bottomNavigationBarTheme: _bottomNavigationBarThemeLight,
);

final appDarkTheme = ThemeData(
  useMaterial3: true,
  fontFamily: 'Outfit',
  textTheme: _darkTextTheme,
  primaryColor: AppColors.rideMeGrey600,
  brightness: Brightness.dark,
  appBarTheme: _appBarThemeDark,
  scaffoldBackgroundColor: AppColors.rideMeBackgroundDark,
  inputDecorationTheme: _inputDecorationThemeDark,
  bottomNavigationBarTheme: _bottomNavigationBarThemeDark,
);

///INPUT DECORATION THEME
const _inputDecorationThemeLight = InputDecorationTheme(
  filled: true,
  fillColor: AppColors.rideMeGrey400,
  errorStyle: TextStyle(
    fontSize: 13,
    color: AppColors.rideMeError400,
    fontWeight: FontWeight.w400,
  ),
  hintStyle: TextStyle(
    fontSize: 13,
    color: AppColors.rideMeBlack200,
    fontWeight: FontWeight.w400,
  ),
);

const _inputDecorationThemeDark = InputDecorationTheme(
  filled: true,
  fillColor: AppColors.rideMeBottomNavigationBackgroundDark,
  errorStyle: TextStyle(
    fontSize: 13,
    color: AppColors.rideMeError400,
    fontWeight: FontWeight.w400,
  ),
  hintStyle: TextStyle(
    fontSize: 13,
    color: AppColors.rideMeGrey600,
    fontWeight: FontWeight.w400,
  ),
);

///APPBAR THEME
const _appBarThemeLight = AppBarTheme(
  elevation: 0,
  centerTitle: true,
  foregroundColor: AppColors.rideMeBlack400,
  backgroundColor: AppColors.rideMeBackgroundLight,
  surfaceTintColor: AppColors.rideMeBackgroundLight,
);

const _appBarThemeDark = AppBarTheme(
  elevation: 0,
  centerTitle: true,
  foregroundColor: AppColors.rideMeGrey600,
  backgroundColor: AppColors.rideMeBackgroundDark,
  surfaceTintColor: AppColors.rideMeBackgroundDark,
);

//BOTTOM NAVIGATION BAR THEME
const _bottomNavigationBarThemeLight = BottomNavigationBarThemeData(
  elevation: 3,
  selectedItemColor: AppColors.rideMeBlack500,
  unselectedItemColor: AppColors.rideMeGrey700,
  backgroundColor: AppColors.rideMeBackgroundLight,
  selectedLabelStyle: TextStyle(
    fontSize: 12,
    color: AppColors.rideMeBlack500,
    fontWeight: FontWeight.w600,
  ),
  unselectedLabelStyle: TextStyle(
    fontSize: 12,
    color: AppColors.rideMeGrey700,
    fontWeight: FontWeight.w400,
  ),
);

const _bottomNavigationBarThemeDark = BottomNavigationBarThemeData(
  elevation: 3,
  selectedItemColor: AppColors.rideMeGrey50,
  unselectedItemColor: AppColors.rideMeGrey700,
  backgroundColor: AppColors.rideMeBottomNavigationBackgroundDark,
  selectedLabelStyle: TextStyle(
    fontSize: 12,
    color: AppColors.rideMeGrey50,
    fontWeight: FontWeight.w600,
  ),
  unselectedLabelStyle: TextStyle(
    fontSize: 12,
    color: AppColors.rideMeGrey700,
    fontWeight: FontWeight.w400,
  ),
);

//LIGHT TEXT THEME
const _lightTextTheme = TextTheme(
  displaySmall: TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.rideMeBlack400,
  ),
  displayMedium: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.rideMeBlack400,
  ),
  displayLarge: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color: AppColors.rideMeBlack400,
  ),
  headlineSmall: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.rideMeBlack400,
  ),
  headlineMedium: TextStyle(
    fontSize: 31,
    fontWeight: FontWeight.w600,
    color: AppColors.rideMeBlack400,
  ),
  headlineLarge: TextStyle(
    fontSize: 38,
    fontWeight: FontWeight.w600,
    color: AppColors.rideMeBlack400,
  ),
);

//DARK TEXT THEME
const _darkTextTheme = TextTheme(
  displaySmall: TextStyle(
    fontSize: 13,
    fontWeight: FontWeight.w400,
    color: AppColors.rideMeGrey600,
  ),
  displayMedium: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.rideMeGrey600,
  ),
  displayLarge: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color: AppColors.rideMeGrey600,
  ),
  headlineSmall: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.rideMeWhite500,
  ),
  headlineMedium: TextStyle(
    fontSize: 31,
    fontWeight: FontWeight.w600,
    color: AppColors.rideMeWhite500,
  ),
  headlineLarge: TextStyle(
    fontSize: 38,
    fontWeight: FontWeight.w600,
    color: AppColors.rideMeWhite500,
  ),
);
