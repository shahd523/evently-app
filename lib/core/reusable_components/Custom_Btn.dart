import 'package:flutter/material.dart';

class CustomBtn extends StatelessWidget{
  final String label;
  final void Function() onpressed;
  CustomBtn({required  this.label,required this.onpressed});
  @override
  Widget build(BuildContext context) {
    return ElevatedButton(style: ElevatedButton.styleFrom(
      padding: EdgeInsets.symmetric(horizontal: 16),
      backgroundColor: Theme.of(context).colorScheme.primary,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(16)
      )
      
    ),
        onPressed:onpressed

         , child:Text(label,style: Theme.of(context).textTheme.labelLarge,),);
  }

}