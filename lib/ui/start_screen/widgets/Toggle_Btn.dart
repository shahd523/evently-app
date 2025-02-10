import 'package:eventlyapp/core/Assets_Manger.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class ToggleBtn extends StatefulWidget{
  @override
  State<ToggleBtn> createState() => _ToggleBtnState();
}

class _ToggleBtnState extends State<ToggleBtn> {
  bool isarabic=false;
  @override
  Widget build(BuildContext context) {
    return  Container(
      decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(35),
          border: Border.all(
              color: Theme.of(context).colorScheme.primary,
              width: 4
          )
      ),
      child: Row(
        children: [
          InkWell(
            onTap: (){
              setState(() {
                isarabic=false;
              });
            },
            child: CircleAvatar(
              radius: 30,
              backgroundColor:! isarabic? Theme.of(context).colorScheme.primary:Colors.transparent,
              child: SvgPicture.asset(AssetManager.us,
                height: 50,
                width: 50,),
            ),
          ),
          SizedBox(width: 16),
          InkWell(
            onTap: (){
              setState(() {
                isarabic=true;
              });
            },

            child: CircleAvatar(radius: 30,
              backgroundColor:isarabic? Theme.of(context).colorScheme.primary:Colors.transparent,
              child: SvgPicture.asset(AssetManager.eg,
                height: 50,
                width: 50,),
            ),
          )
        ],
      ),
    );
  }
}