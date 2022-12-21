import 'package:flutter/material.dart';
import 'package:tmdb_app/helpers/colors.dart';

class AppThemes {
  static final light = ThemeData(
    fontFamily: 'Poppins',
    scaffoldBackgroundColor: AppColors.backgroundColor,
    canvasColor: AppColors.primaryColor,
    buttonTheme: ButtonThemeData(
      buttonColor: AppColors.secondaryColor,
      textTheme: ButtonTextTheme.primary,
    ),
    textTheme: TextTheme(
      button: TextStyle(color: AppColors.textColor, fontSize: 16),
      headline6: TextStyle(color: AppColors.secondaryColor),
      bodyText1: TextStyle(color: AppColors.primaryColor, fontSize: 18),
      bodyText2: TextStyle(color: AppColors.secondaryColor, fontSize: 16),
    ),
  );
}
