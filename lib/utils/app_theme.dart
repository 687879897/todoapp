import 'package:flutter/material.dart';
import 'app_colors.dart';
abstract class AppTheme {
   static TextStyle titelstyel =TextStyle(
       color: app_colors.white,
   );
   static TextStyle titelstyeldark =TextStyle(
     color: Colors.black,
   );
   static TextStyle bottomsheetstyeldark =TextStyle(
     color: Colors.white,
   );
   static TextStyle bottomsheetstyel =TextStyle(
     color: Colors.black,
   );

  static  ThemeData lightthem=ThemeData(
      primaryColor: app_colors.primarycolor,
      scaffoldBackgroundColor: app_colors.grycolor,
      appBarTheme:const AppBarTheme(
          backgroundColor: app_colors.primarycolor,
          elevation: 0,
          shadowColor: app_colors.transparent,
          centerTitle: true,

      ),
      bottomNavigationBarTheme:const BottomNavigationBarThemeData(
        selectedIconTheme: IconThemeData(color: app_colors.primarycolor,size: 36),
        unselectedIconTheme: IconThemeData(color: app_colors.grycolor,size: 34),
      ),
      colorScheme: ColorScheme(
          brightness: Brightness.light,
          primary: app_colors.primarycolor,
          onPrimary: app_colors.primarycolor,
          secondary: app_colors.grycolor,
          onSecondary: app_colors.grycolor,
          error: Colors.red,
          onError: Colors.red,
          background: app_colors.transparent,
          onBackground: app_colors.transparent,
          surface: app_colors.transparent,
          onSurface: app_colors.transparent
      )
  );
  /////dark them mode
  static  ThemeData darkthem=ThemeData(
      primaryColor: app_colors.primarycolor,
      scaffoldBackgroundColor: app_colors.homenight,
      appBarTheme: AppBarTheme(
          backgroundColor: app_colors.primarycolor,
          elevation: 0,
          shadowColor: app_colors.transparent,
          centerTitle: true,

      ),

      colorScheme: const ColorScheme(
          brightness: Brightness.light,
          primary:app_colors.primarycolor,
          onPrimary: app_colors.primarycolor,
          secondary: app_colors.homenight,
          onSecondary: app_colors.homenight,
          error: Colors.red,
          onError: Colors.red,
          background: app_colors.transparent,
          onBackground: app_colors.transparent,
          surface: app_colors.transparent,
          onSurface: app_colors.transparent
      )
  );
}