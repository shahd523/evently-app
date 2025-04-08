import 'package:easy_localization/easy_localization.dart';
import 'package:eventlyapp/Providers/ThemePovider/ThemeProvider.dart';
import 'package:eventlyapp/core/Assets_Manger.dart';
import 'package:eventlyapp/core/Strings_Manager.dart';

class OnBoardingModel{
  String sora;
  String text1;
  String text2;
  OnBoardingModel({required this.sora,required this.text1,required this.text2});
  static List<OnBoardingModel>onbourdinglight=[
    OnBoardingModel (sora: AssetManager.on1light, text1:StringsManager.ontext1.tr() , text2:StringsManager.ontext11.tr()),
    OnBoardingModel(sora: AssetManager.on2light, text1:StringsManager.ontext2.tr() , text2: StringsManager.ontext22.tr()),
    OnBoardingModel(sora: AssetManager.on3light, text1:StringsManager.ontext3.tr(), text2: StringsManager.ontext33.tr()),
  ];
  static List<OnBoardingModel>onbourdingdark=[
    OnBoardingModel (sora: AssetManager.on1dark, text1:StringsManager.ontext1.tr(), text2:StringsManager.ontext11.tr()),
    OnBoardingModel(sora: AssetManager.on2dark, text1:StringsManager.ontext2.tr(), text2: StringsManager.ontext22.tr()),
    OnBoardingModel(sora: AssetManager.on3dark, text1:StringsManager.ontext3.tr(), text2: StringsManager.ontext33.tr()),
  ];


}