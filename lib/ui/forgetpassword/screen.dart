
import 'package:easy_localization/easy_localization.dart';
import 'package:eventlyapp/core/Assets_Manger.dart';
import 'package:eventlyapp/core/Strings_Manager.dart';
import 'package:eventlyapp/core/reusable_components/DialogUtils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import '../../core/Constrains.dart';
import '../../core/reusable_components/Custom_Btn.dart';
import '../../core/reusable_components/custom_textfield.dart';
class ForgetPasswordScreen extends StatefulWidget{
  static const String routename="forgetpassword";

  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
}

class _ForgetPasswordScreenState extends State<ForgetPasswordScreen> {
  late  TextEditingController emailcontroller;
  GlobalKey<FormState>formkey=GlobalKey<FormState>();
  @override
  State<ForgetPasswordScreen> createState() => _ForgetPasswordScreenState();
  void initState(){
    emailcontroller=TextEditingController();

  }
  void dispose(){
    emailcontroller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar:AppBar(
        title: Text(StringsManager.forgetpass.tr()),
      ) ,
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: formkey,
          child: SingleChildScrollView(
            child: Column(
              children: [Image.asset(AssetManager.forget),
                SizedBox(height: 24,),
                CustomField(prifex: AssetManager.emailicon,hinttext: StringsManager.email.tr(),
                  controller:emailcontroller,keyboard: TextInputType.emailAddress,
                  validator: (value){
                    if(value==null||value.isEmpty){
                      return StringsManager.required.tr();
                    }
                    if(!RegExp(emailRegex).hasMatch(value)){
                      return StringsManager.notvalidemail.tr();
                    }
                    return null;
                  },
                ),
                SizedBox(height: 24,),
                CustomBtn(label: StringsManager.reset.tr(), onpressed:(){
                  if(formkey.currentState!.validate()){
                    resetpass();
                  }
                }),
            
              ],
            ),
          ),
        ),
      ),
    );
  }
  resetpass()async{
    await FirebaseAuth.instance
        .sendPasswordResetEmail(email: "user@example.com");
    Navigator.pop(context);
    DialogUtils.showtoast("Email Sent");
  }
}
  
  
