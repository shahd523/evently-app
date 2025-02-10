import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:eventlyapp/core/Assets_Manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class LanguageToggle extends StatefulWidget{
  @override
  State<LanguageToggle> createState() => _LanguageToggleState();
}

class _LanguageToggleState extends State<LanguageToggle> {
  int currentval=0;
  @override
  Widget build(BuildContext context) {
   return AnimatedToggleSwitch<int>.rolling(
     current: currentval,
     values: [0, 1],
     onChanged: (newvalue){
       setState(() {
         currentval=newvalue;

       });
     },
     iconOpacity: 1,
     style: ToggleStyle(
         borderColor: Theme.of(context).colorScheme.primary,
         indicatorColor: Theme.of(context).colorScheme.primary
     ),
     iconList: [
       SvgPicture.asset(AssetManager.us,
           height: 40,
           width:40),
       SvgPicture.asset(AssetManager.eg,
           height: 40,
           width:40)
     ],);
  }
}