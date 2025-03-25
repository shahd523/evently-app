import 'package:easy_localization/easy_localization.dart';
import 'package:eventlyapp/core/Colors_Manager.dart';
import 'package:flutter/material.dart';

class LanguageButtomSheet extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
    Text(context.locale.languageCode=="ar"?"العربيه":"English",
      style: Theme.of(context).textTheme.titleMedium,),
            Icon(Icons.check,size: 40,color: ColorsManager.primary_light,)
          ],
        ),
        InkWell(
          onTap: (){
            if(context.locale.languageCode=="ar"){
              context.setLocale(Locale("en"));

            }
            else{
              context.setLocale(Locale("ar"));
            }
          },
          child: Align(alignment: AlignmentDirectional.bottomStart,
            child: Text(context.locale.languageCode!="ar"?"العربيه":"English",
              style: Theme.of(context).textTheme.titleMedium?.copyWith(fontSize: 18
              ,color: Colors.black),
            ),
          ),
        ),
      ],
    );
  }

}