import 'package:flutter/material.dart';
import 'package:rideme_driver/core/theme/app_colors.dart';

final appLightTheme = ThemeData(
  useMaterial3: true,
  fontFamily: 'Outfit',
  textTheme: _lightTextTheme,
  primaryColor: AppColors.rideMeBlackNormal,
  brightness: Brightness.light,
  appBarTheme: _appBarThemeLight,
  scaffoldBackgroundColor: Colors.white,
  inputDecorationTheme: _inputDecorationThemeLight,
  bottomNavigationBarTheme: _bottomNavigationBarThemeLight,
);

// final appDarkTheme = ThemeData(
//   useMaterial3: true,
//   fontFamily: 'Outfit',
//   textTheme: _darkTextTheme,
//   primaryColor: AppColors.rideMeGreyDark,
//   brightness: Brightness.dark,
//   appBarTheme: _appBarThemeDark,
//   scaffoldBackgroundColor: AppColors.rideMeBackgroundDark,
//   inputDecorationTheme: _inputDecorationThemeDark,
//   bottomNavigationBarTheme: _bottomNavigationBarThemeDark,
// );

///INPUT DECORATION THEME
const _inputDecorationThemeLight = InputDecorationTheme(
  filled: true,
  fillColor: AppColors.rideMeGreyNormalHover,
  errorStyle: TextStyle(
    fontSize: 13,
    color: AppColors.rideMeErrorNormalHover,
    fontWeight: FontWeight.w400,
  ),
  hintStyle: TextStyle(
    fontSize: 13,
    color: AppColors.rideMeBlackLightActive,
    fontWeight: FontWeight.w400,
  ),
);

// const _inputDecorationThemeDark = InputDecorationTheme(
//   filled: true,
//   fillColor: AppColors.rideMeBottomNavigationBackgroundDark,
//   errorStyle: TextStyle(
//     fontSize: 13,
//     color: AppColors.rideMeErrorNormalHover,
//     fontWeight: FontWeight.w400,
//   ),
//   hintStyle: TextStyle(
//     fontSize: 13,
//     color: AppColors.rideMeGreyDark,
//     fontWeight: FontWeight.w400,
//   ),
// );

///APPBAR THEME
const _appBarThemeLight = AppBarTheme(
  elevation: 0,
  centerTitle: true,
  foregroundColor: AppColors.rideMeBlackNormal,
  backgroundColor: AppColors.rideMeBackgroundLight,
  surfaceTintColor: AppColors.rideMeBackgroundLight,
);

// const _appBarThemeDark = AppBarTheme(
//   elevation: 0,
//   centerTitle: true,
//   foregroundColor: AppColors.rideMeGreyDark,
//   backgroundColor: AppColors.rideMeBackgroundDark,
//   surfaceTintColor: AppColors.rideMeBackgroundDark,
// );

//BOTTOM NAVIGATION BAR THEME
const _bottomNavigationBarThemeLight = BottomNavigationBarThemeData(
  elevation: 3,
  selectedItemColor: AppColors.rideMeBlackNormalHover,
  unselectedItemColor: AppColors.rideMeGreyDarkHover,
  backgroundColor: AppColors.rideMeBackgroundLight,
  selectedLabelStyle: TextStyle(
    fontSize: 12,
    color: AppColors.rideMeBlackNormalHover,
    fontWeight: FontWeight.w600,
  ),
  unselectedLabelStyle: TextStyle(
    fontSize: 12,
    color: AppColors.rideMeGreyDarkHover,
    fontWeight: FontWeight.w400,
  ),
);

// const _bottomNavigationBarThemeDark = BottomNavigationBarThemeData(
//   elevation: 3,
//   selectedItemColor: AppColors.rideMeGreyLight,
//   unselectedItemColor: AppColors.rideMeGreyDarkHover,
//   backgroundColor: AppColors.rideMeBottomNavigationBackgroundDark,
//   selectedLabelStyle: TextStyle(
//     fontSize: 12,
//     color: AppColors.rideMeGreyLight,
//     fontWeight: FontWeight.w600,
//   ),
//   unselectedLabelStyle: TextStyle(
//     fontSize: 12,
//     color: AppColors.rideMeGreyDarkHover,
//     fontWeight: FontWeight.w400,
//   ),
// );

//LIGHT TEXT THEME
const _lightTextTheme = TextTheme(
  displaySmall: TextStyle(
    fontSize: 14,
    fontWeight: FontWeight.w400,
    color: AppColors.rideMeBlackNormal,
  ),
  displayMedium: TextStyle(
    fontSize: 16,
    fontWeight: FontWeight.w400,
    color: AppColors.rideMeBlackNormal,
  ),
  displayLarge: TextStyle(
    fontSize: 20,
    fontWeight: FontWeight.w400,
    color: AppColors.rideMeBlackNormal,
  ),
  headlineSmall: TextStyle(
    fontSize: 24,
    fontWeight: FontWeight.w600,
    color: AppColors.rideMeBlackNormal,
  ),
  headlineMedium: TextStyle(
    fontSize: 31,
    fontWeight: FontWeight.w600,
    color: AppColors.rideMeBlackNormal,
  ),
  headlineLarge: TextStyle(
    fontSize: 38,
    fontWeight: FontWeight.w600,
    color: AppColors.rideMeBlackNormal,
  ),
);

//DARK TEXT THEME
// const _darkTextTheme = TextTheme(
//   displaySmall: TextStyle(
//     fontSize: 13,
//     fontWeight: FontWeight.w400,
//     color: AppColors.rideMeGreyDark,
//   ),
//   displayMedium: TextStyle(
//     fontSize: 16,
//     fontWeight: FontWeight.w400,
//     color: AppColors.rideMeGreyDark,
//   ),
//   displayLarge: TextStyle(
//     fontSize: 20,
//     fontWeight: FontWeight.w400,
//     color: AppColors.rideMeGreyDark,
//   ),
//   headlineSmall: TextStyle(
//     fontSize: 24,
//     fontWeight: FontWeight.w600,
//     color: AppColors.rideMeWhite500,
//   ),
//   headlineMedium: TextStyle(
//     fontSize: 31,
//     fontWeight: FontWeight.w600,
//     color: AppColors.rideMeWhite500,
//   ),
//   headlineLarge: TextStyle(
//     fontSize: 38,
//     fontWeight: FontWeight.w600,
//     color: AppColors.rideMeWhite500,
//   ),
// );
