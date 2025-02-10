import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:eventlyapp/core/App_Style.dart';
import 'package:eventlyapp/core/Assets_Manger.dart';
import 'package:eventlyapp/core/Colors_Manager.dart';
import 'package:eventlyapp/core/Custom_Btn.dart';
import 'package:eventlyapp/core/Strings_Manager.dart';
import 'package:eventlyapp/ui/start_screen/widgets/Language_Toggle.dart';
import 'package:eventlyapp/ui/start_screen/widgets/Theme_Toggle.dart';
import 'package:eventlyapp/ui/start_screen/widgets/Toggle_Btn.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class StartScreen extends StatelessWidget{
  static const String routeName="StartScreen";
  @override
  Widget build(BuildContext context) {
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
                  child: Image.asset(AssetManager.startimage)),
              Text(StringsManager.personalize,style:Theme.of(context).textTheme.titleMedium,),
              SizedBox(height: 28,),
              Text(StringsManager.starttext,style:Theme.of(context).textTheme.titleSmall),
              SizedBox(height: 28,),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(StringsManager.lang,
                    style:Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500),),
                       LanguageToggle(),



                       // many more parameters available




                ],
              ),
              SizedBox(height: 16,),
              Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(StringsManager.theme,
                    style:Theme.of(context).textTheme.titleMedium?.copyWith(fontWeight: FontWeight.w500),),
                  ThemeToggle(),



                  // many more parameters available




                ],
              ),
              SizedBox(height: 28,),
              CustomBtn(label:StringsManager.startbtn, onpressed: () {  },)


            ],
          ),
        ),
      ),

    );
  }

}