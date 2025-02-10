import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:eventlyapp/core/Assets_Manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ThemeToggle extends StatefulWidget{
  @override
  State<ThemeToggle> createState() => _ThemeToggleState();
}

class _ThemeToggleState extends State<ThemeToggle> {
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
        SvgPicture.asset(AssetManager.sun,
            colorFilter:ColorFilter.mode(currentval==0?Theme.of(context).colorScheme.onPrimaryContainer:
            Theme.of(context).colorScheme.primary,BlendMode.srcIn) ,
            height: 40,
            width:40),
        SvgPicture.asset(AssetManager.moon,
            colorFilter:ColorFilter.mode(currentval==1?Theme.of(context).colorScheme.onPrimaryContainer:
            Theme.of(context).colorScheme.primary,BlendMode.srcIn) ,
            height: 40,
            width:40)
      ],);
  }
}