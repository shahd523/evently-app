import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:eventlyapp/Providers/ThemePovider/ThemeProvider.dart';
import 'package:eventlyapp/core/App_Style.dart';
import 'package:eventlyapp/core/Assets_Manger.dart';
import 'package:eventlyapp/core/Colors_Manager.dart';
import 'package:eventlyapp/core/reusable_components/Custom_Btn.dart';
import 'package:eventlyapp/core/Strings_Manager.dart';
import 'package:eventlyapp/ui/Register/screens/RegisterScreen.dart';
import 'package:eventlyapp/ui/onboarding/screen/onboardingscreen.dart';
import 'package:eventlyapp/ui/start_screen/widgets/Language_Toggle.dart';
import 'package:eventlyapp/ui/start_screen/widgets/Theme_Toggle.dart';
import 'package:eventlyapp/ui/start_screen/widgets/Toggle_Btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class StartScreen extends StatelessWidget{
  static const String routeName="StartScreen";
  late ThemeProvider provider;
  @override
  Widget build(BuildContext context) {
    provider=Provider.of(context);
    return Scaffold(
      appBar:AppBar(
        title: Image.asset(AssetManager.logo),
      ),
      body: Container(
        width: double.infinity,

        child: Padding(
          padding: const EdgeInsets.symmetric(vertical: 28,horizontal: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Align(alignment: Alignment.center,
                  child: provider.currenttheme==ThemeMode.light?Image.asset(AssetManager.startimage):Image.asset(AssetManager.startimagedark)),
              Text(StringsManager.personalize.tr(),style:Theme.of(context).textTheme.titleMedium,),
              SizedBox(height: 28,),
              Text(StringsManager.starttext.tr(),style:Theme.of(context).textTheme.titleSmall),
              SizedBox(height: 28,),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(StringsManager.lang.tr(),
                    style:Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500),),
                       LanguageToggle(),
                ],
              ),
              SizedBox(height: 16,),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(StringsManager.theme.tr(),
                    style:Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500),),
                  ThemeToggle(),],
              ),
              SizedBox(height: 28,),
              CustomBtn(label:StringsManager.startbtn.tr(), onpressed: () {
                Navigator.pushReplacementNamed(context,OnBoardingScreen.routeName);
              },)


            ],
          ),
        ),
      ),

    );
  }

}