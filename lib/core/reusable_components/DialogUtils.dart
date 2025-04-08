import 'package:eventlyapp/core/Colors_Manager.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class DialogUtils{
      static showLoadingDialog(BuildContext context){
      showDialog(context:context, builder:(context)=>AlertDialog(
        content: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text("Loading...",style: Theme.of(context).textTheme.titleMedium,),
            SizedBox(width: 10,),
            CircularProgressIndicator()
          ],
        ),
      ));

    }
    static showmessagedialog({required BuildContext context,required String text,
      required String posbtntxt,required void Function() posbtnclk}){
        showDialog(context: context, builder:(context)=>AlertDialog(
          content: Text(text,style: Theme.of(context).textTheme.titleMedium,),
          actions: [
            TextButton(onPressed:posbtnclk , child:Text(posbtntxt))
          ],
        )
        );
    }
   static showtoast(String mssg){
     Fluttertoast.showToast(
         msg: mssg,
         toastLength: Toast.LENGTH_SHORT,
         gravity: ToastGravity.BOTTOM,
         timeInSecForIosWeb: 1,
         backgroundColor:  ColorsManager.primary_light,
         textColor: Colors.white,
         fontSize: 16.0
     );
   }
}

