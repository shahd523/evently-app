
import 'package:shared_preferences/shared_preferences.dart';

class PrefsHelper{
  static late SharedPreferences prefs;
  static  init()async{
    prefs=await SharedPreferences.getInstance();
  }
//false -> light  true -> dark
static settheme(bool value){
    prefs.setBool("theme", value);
    
}
static getTheme(){
    return prefs.getBool("theme")??false;
}


  }
