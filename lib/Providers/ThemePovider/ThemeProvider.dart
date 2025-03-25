import 'package:eventlyapp/core/PrefsHelper.dart';
import 'package:flutter/material.dart';

class ThemeProvider extends ChangeNotifier{

  ThemeMode currenttheme=ThemeMode.light;
  initTheme(){
    bool isDark=PrefsHelper.getTheme();
    if(isDark){
      currenttheme=ThemeMode.dark;
    }else{
      currenttheme=ThemeMode.light;
    }
  }
  changeTheme(ThemeMode newtheme){
    currenttheme=newtheme;
    if(currenttheme==ThemeMode.dark){
      PrefsHelper.settheme(true);
    }
    else{
      PrefsHelper.settheme(false);
    }
    notifyListeners();
  }
}