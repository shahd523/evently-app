import 'package:eventlyapp/core/Colors_Manager.dart';
import 'package:flutter/material.dart';

class AppStyle {
  static ThemeData LightTheme=ThemeData(
      scaffoldBackgroundColor: ColorsManager.bacground_light,
      colorScheme: ColorScheme.light(
        primary: ColorsManager.primary_light,
        secondary: ColorsManager.secondary_light,
        tertiary: ColorsManager.teretary_light,
        onPrimaryContainer:ColorsManager.secondary_dark


      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
      fontFamily: "Inter",
      textTheme: TextTheme(titleMedium: TextStyle(fontWeight: FontWeight.w700,fontSize: 20,
      color: ColorsManager.primary_light),
          titleSmall:  TextStyle(fontSize: 16,
              fontWeight: FontWeight.w500,color: ColorsManager.secondary_light),
        labelLarge:TextStyle(fontSize: 20,
        fontWeight: FontWeight.w500,color: Colors.white)

  ),


  );
  static ThemeData DarkTheme=ThemeData(
      scaffoldBackgroundColor: ColorsManager.backrround_dark,
      colorScheme: ColorScheme.dark(
        primary: ColorsManager.primary_dark,
        secondary: ColorsManager.secondary_dark,
        tertiary: ColorsManager.teretary_dark,
          onPrimaryContainer:ColorsManager.secondary_light,

      ),
      appBarTheme: AppBarTheme(
        backgroundColor: Colors.transparent,
        centerTitle: true,
      ),
    fontFamily: "Inter",
      textTheme: TextTheme(titleMedium: TextStyle(fontWeight: FontWeight.w700,fontSize: 20,
          color: ColorsManager.primary_dark),
        titleSmall:  TextStyle(fontSize: 16,
        fontWeight: FontWeight.w500,color: ColorsManager.secondary_dark),
          labelLarge:TextStyle(fontSize: 20,
              fontWeight: FontWeight.w500,color: Colors.white)

      )


  );

}