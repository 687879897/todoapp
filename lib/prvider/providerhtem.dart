
import 'package:flutter/material.dart';
import 'package:todo1/utils/app_colors.dart';

import '../utils/app_theme.dart';

class Themprovider extends ChangeNotifier{
  ThemeMode currentmode=ThemeMode.light;
  void setcurrentmode(ThemeMode newmode ){
    currentmode=newmode;
    notifyListeners();
  }

  String splashscreen(){
    if(currentmode==ThemeMode.dark){
      return "assets/assets/splash – 1.png";
    }
    else{
      return "assets/assets/splash.png";
    }
  }
  Color colorscreen(){
    if(currentmode==ThemeMode.dark){
     return app_colors.homenight;
    }
    else{
      return app_colors.grycolor;
    }

  }
  Color colorbottomsheet(){
    if(currentmode==ThemeMode.dark){
      return app_colors.bottomsheet;
    }
    else{
      return app_colors.white;
    }

  }
  Color colorunselect(){
    if(currentmode==ThemeMode.dark){
      return app_colors.white;
    }
    else{
      return app_colors.grycolor;
    }

  }
  Color colorunselectclaender(){
    if(currentmode==ThemeMode.dark){
      return app_colors.white;
    }
    else{
      return Colors.black;
    }

  }
  TextStyle style(){
    if(currentmode==ThemeMode.dark){
      return AppTheme.titelstyeldark;
    }
    else{
      return AppTheme.titelstyel;
    }

  }
  TextStyle stylebottomsheet(){
    if(currentmode==ThemeMode.dark){
      return AppTheme.bottomsheetstyeldark;
    }
    else{
      return AppTheme.bottomsheetstyel;
    }

  }
}