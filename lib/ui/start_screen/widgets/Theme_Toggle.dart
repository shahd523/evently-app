import 'package:animated_toggle_switch/animated_toggle_switch.dart';
import 'package:eventlyapp/Providers/ThemePovider/ThemeProvider.dart';
import 'package:eventlyapp/core/App_Style.dart';
import 'package:eventlyapp/core/Assets_Manger.dart';
import 'package:eventlyapp/core/PrefsHelper.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class ThemeToggle extends StatefulWidget{
  @override
  State<ThemeToggle> createState() => _ThemeToggleState();
}

class _ThemeToggleState extends State<ThemeToggle> {
  int currentval=0;
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((timeStamp){
      if(PrefsHelper.getTheme()){
        currentval=1;
      }
      else{
        currentval=0;
      }

    });

  }
  Widget build(BuildContext context) {
    ThemeProvider themeProvider=Provider.of<ThemeProvider>(context);
    return AnimatedToggleSwitch<int>.rolling(
      current: currentval,
      values: [0, 1],
      onChanged: (newvalue){
        setState(() {
          currentval=newvalue;
          if(currentval==0){
            themeProvider.changeTheme(ThemeMode.light);
          }
          else{
            themeProvider.changeTheme(ThemeMode.dark);
          }


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