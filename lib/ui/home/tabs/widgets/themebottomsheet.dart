import 'package:easy_localization/easy_localization.dart';
import 'package:eventlyapp/Providers/ThemePovider/ThemeProvider.dart';
import 'package:eventlyapp/core/Colors_Manager.dart';
import 'package:eventlyapp/core/Strings_Manager.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ThemeButtomSheet extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    ThemeProvider provider=Provider.of<ThemeProvider>(context);
    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(provider.currenttheme==ThemeMode.dark?StringsManager.dark.tr():StringsManager.light.tr(),
              style: Theme.of(context).textTheme.titleMedium,),
            Icon(Icons.check,size: 40,color: ColorsManager.primary_light,)
          ],
        ),
        InkWell(
          onTap: (){
            if(provider.currenttheme==ThemeMode.dark){
              provider.changeTheme(ThemeMode.light);


            }
            else{
              provider.changeTheme(ThemeMode.dark);
            }
          },
          child: Align(alignment: AlignmentDirectional.bottomStart,
            child: Text(provider.currenttheme!=ThemeMode.dark?StringsManager.dark.tr():StringsManager.light.tr(),
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 18,
                  color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }

}