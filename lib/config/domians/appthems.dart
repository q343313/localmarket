



import 'package:flutter/material.dart';
import 'appcolors.dart';

class AppThemes {

  static final ThemeData lightthemedata = ThemeData(
      scaffoldBackgroundColor: AppColors.scaffoldLightMode,
      brightness: Brightness.light,
      textTheme: TextTheme(
          bodyLarge: TextStyle(color: AppColors.primaryTextLightMode),
          bodyMedium: TextStyle(color: AppColors.primaryTextLightMode),
          bodySmall: TextStyle(color: AppColors.primaryTextLightMode)
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.secondaryButtonLightMode,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))
        ),
      ),
      appBarTheme: AppBarTheme(
          backgroundColor: AppColors.scaffoldLightMode,
          centerTitle: true,
          titleTextStyle: TextStyle(
              fontFamily: "title",
              fontSize: 20,
              color: AppColors.primaryTextLightMode
          )
      )
  );
  static final ThemeData darkthemedata = ThemeData(
      scaffoldBackgroundColor: AppColors.scaffoldDarkMode,
      brightness: Brightness.dark,
      textTheme: TextTheme(
          bodyLarge: TextStyle(color: AppColors.primaryButtonDarkMode),
          bodyMedium: TextStyle(color: AppColors.primaryTextDarkMode),
          bodySmall: TextStyle(color: AppColors.primaryButtonDarkMode)
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.secondaryButtonDarkMode,
            shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14))
        ),
      ),
      appBarTheme: AppBarTheme(
          backgroundColor: AppColors.scaffoldDarkMode,
          centerTitle: true,
          titleTextStyle: TextStyle(fontFamily: "title",fontSize: 20,color: AppColors.primaryTextDarkMode)
      )
  );

}