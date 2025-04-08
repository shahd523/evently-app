import 'package:eventlyapp/core/Colors_Manager.dart';
import 'package:flutter/material.dart';

class AppStyle {
  static ThemeData LightTheme=ThemeData(
      scaffoldBackgroundColor: ColorsManager.bacground_light,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: ColorsManager.primary_light,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 12,
        ),
        unselectedLabelStyle:TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 12,
        ),
      ),
      tabBarTheme: TabBarTheme(
        labelColor:Colors.white,
        unselectedLabelColor:Colors.white ,
      ),
      colorScheme: ColorScheme.light(
        primary: ColorsManager.primary_light,
        secondary: ColorsManager.secondary_light,
        tertiary: ColorsManager.teretary_light,
        onPrimaryContainer:ColorsManager.secondary_dark,
        onSecondaryContainer: ColorsManager.textfieldborder,
          onTertiaryContainer: ColorsManager.textfieldborder,
        onPrimary: Colors.white,


      ),
      appBarTheme: AppBarTheme(
        scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
          iconTheme: IconThemeData(color: Colors.black,),
        titleTextStyle: TextStyle(fontWeight: FontWeight.w400,
        color: ColorsManager.secondary_light,
          fontSize: 30
        )
      ),
      fontFamily: "Inter",
      textTheme: TextTheme(titleMedium: TextStyle(fontWeight: FontWeight.w700,fontSize: 20,
      color: ColorsManager.primary_light),
          titleSmall:  TextStyle(fontSize: 16,
              fontWeight: FontWeight.w500,color: ColorsManager.secondary_light),
        labelLarge:TextStyle(fontSize: 20,
        fontWeight: FontWeight.w500,color: Colors.white),
        bodySmall: TextStyle(fontSize: 16,fontWeight:FontWeight.w500,
        color: ColorsManager.textfieldborder),
        headlineMedium: TextStyle(fontWeight: FontWeight.w700,
            fontSize: 24,color: ColorsManager.bacground_light),
        displaySmall: TextStyle(fontWeight: FontWeight.w700,
        fontSize: 14,color: Colors.black
        )

  ),
    dividerTheme: DividerThemeData(color: ColorsManager.primary_light)


  );
  static ThemeData DarkTheme=ThemeData(
      scaffoldBackgroundColor: ColorsManager.backrround_dark,
      bottomNavigationBarTheme: BottomNavigationBarThemeData(
          backgroundColor: ColorsManager.backrround_dark,
        type: BottomNavigationBarType.fixed,
        selectedLabelStyle: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 12,
        ),
        unselectedLabelStyle:TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w700,
          fontSize: 12,
        ),

      ),
      colorScheme: ColorScheme.dark(
        primary: ColorsManager.primary_dark,
        secondary: ColorsManager.secondary_dark,
        tertiary: ColorsManager.teretary_dark,
          onPrimaryContainer:ColorsManager.secondary_light,
          onSecondaryContainer:ColorsManager.primary_dark,
        onTertiaryContainer: Colors.white,
        onPrimary: ColorsManager.backrround_dark,

      ),
      appBarTheme: AppBarTheme(
          scrolledUnderElevation: 0,
        backgroundColor: Colors.transparent,
        centerTitle: true,
          iconTheme: IconThemeData(color: ColorsManager.primary_dark,),
          titleTextStyle: TextStyle(fontWeight: FontWeight.w400,
              color: ColorsManager.primary_dark,
              fontSize: 30
          )
      ),
    fontFamily: "Inter",
      textTheme: TextTheme(titleMedium: TextStyle(fontWeight: FontWeight.w700,fontSize: 20,
          color: ColorsManager.primary_dark),
        titleSmall:  TextStyle(fontSize: 16,
        fontWeight: FontWeight.w500,color: ColorsManager.secondary_dark),
          labelLarge:TextStyle(fontSize: 20,
              fontWeight: FontWeight.w500,color: Colors.white),
          bodySmall: TextStyle(fontSize: 16,fontWeight:FontWeight.w500,
              color: ColorsManager.primary_dark),
          displaySmall: TextStyle(fontWeight: FontWeight.w700,
              fontSize: 14,color: Colors.white
          )

      ),
      dividerTheme: DividerThemeData(color: ColorsManager.primary_dark)


  );

}