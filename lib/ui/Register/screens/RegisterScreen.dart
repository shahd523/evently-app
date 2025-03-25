import 'package:easy_localization/easy_localization.dart';
import 'package:eventlyapp/core/Assets_Manger.dart';
import 'package:eventlyapp/core/Colors_Manager.dart';
import 'package:eventlyapp/core/Constrains.dart';
import 'package:eventlyapp/core/FireStoreHandler.dart';
import 'package:eventlyapp/core/Strings_Manager.dart';
import 'package:eventlyapp/core/reusable_components/Custom_Btn.dart';
import 'package:eventlyapp/core/reusable_components/DialogUtils.dart';
import 'package:eventlyapp/core/reusable_components/custom_textfield.dart';
import 'package:eventlyapp/ui/Login/screen/login_screen.dart';
import 'package:eventlyapp/ui/start_screen/widgets/Language_Toggle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:eventlyapp/model/User.dart'as Myuser;
import '../../home/Screen/HomeScreen.dart';

class RegisterScreen extends StatefulWidget{
  static const String routeName="RegisterScreen";


  @override



  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  late  TextEditingController namecontroller;
  late  TextEditingController emailcontroller;
  late  TextEditingController passcontroller;
  late  TextEditingController repasscontroller;
GlobalKey<FormState>formkey=GlobalKey<FormState>();
  @override
  void initState(){
    super.initState();
    namecontroller=TextEditingController();
    emailcontroller=TextEditingController();
    passcontroller=TextEditingController();
    repasscontroller=TextEditingController();
  }
  void dispose(){
    super.dispose();
    namecontroller.dispose();
  emailcontroller.dispose();
  passcontroller.dispose();
  repasscontroller.dispose();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(StringsManager.register.tr()),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: SingleChildScrollView(
          child: Form(
            key: formkey,
            child: Column(

              children: [
                Image.asset(AssetManager.logologin),
                SizedBox(height: 24,),

                CustomField(prifex: AssetManager.personicon,hinttext: StringsManager.name.tr(),
                     controller:namecontroller,keyboard:TextInputType.name ,
                  validator: (value){
                    if(value==null||value.isEmpty){
                      return StringsManager.required.tr();
                    }
                    return null;
                  },),
                SizedBox(height: 16,),
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
                SizedBox(height: 16,),
                CustomField(prifex: AssetManager.lockicon,hinttext: StringsManager.pass.tr(),
                  controller:passcontroller,keyboard: TextInputType.visiblePassword,
                  isobsecured: true,
                  validator: (value){
                    if(value==null||value.isEmpty){
                      return StringsManager.required.tr();
                    }
                    if(value.length<8){
                      return StringsManager.atleast.tr();
                    }
                    return null;
                  },),
                SizedBox(height: 16,),
                CustomField(prifex: AssetManager.lockicon,hinttext: StringsManager.repass.tr(),
                  controller:repasscontroller,
                  keyboard: TextInputType.visiblePassword,isobsecured: true,
                  validator: (value){
                    if(value==null||value.isEmpty){
                      return StringsManager.required.tr();
                    }
                    if(value!=passcontroller.text){
                      return StringsManager.dontmatch.tr();
                    }
                    return null;
                  },),
                SizedBox(height: 16,),
                CustomBtn(label: StringsManager.createacc.tr(), onpressed:(){
                  Createacc();
                }),
                SizedBox(height: 16,),
                Row(mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(StringsManager.alreadyhaveaccount.tr(),
                    style: Theme.of(context).textTheme.titleSmall,),
                    TextButton(onPressed: (){
                      Navigator.pushReplacementNamed(context, LoginScreen.routeName);
                    }, child: Text(StringsManager.login.tr(),
                        style: Theme.of(context).textTheme.titleSmall?.copyWith(
                            color: ColorsManager.primary_dark,
                        decoration: TextDecoration.underline,
                        decorationColor: ColorsManager.primary_dark,))),
                    SizedBox(height: 24,),

                  ],
                ),
                LanguageToggle()














              ],
            ),
          ),
        ),
      ),
    );
  }
  Createacc()async{
    if(formkey.currentState!.validate()){
      try {
        DialogUtils.showLoadingDialog(context);
        final credential = await FirebaseAuth.instance.createUserWithEmailAndPassword(
          email: emailcontroller.text,
          password: passcontroller.text,
        );
        await FireStoreHandler.AddUser(Myuser.User(
          id: credential.user!.uid,
          email: emailcontroller.text,
          name: namecontroller.text,
          favorites: [],
        ));
        Navigator.pop(context);

        Navigator.pushNamedAndRemoveUntil(context, HomeScreen.routename,(route)=>false);
      } on FirebaseAuthException catch (e) {
        if (e.code ==StringsManager.firebase1) {
          DialogUtils.showmessagedialog(context: context,
              text: StringsManager.firebase2.tr(), posbtntxt: "Ok",
              posbtnclk:(){
                Navigator.pop(context);
              });

        } else if (e.code == StringsManager.firebase3) {
          DialogUtils.showmessagedialog(context: context,
              text: StringsManager.firebase4.tr(), posbtntxt: "Ok",
              posbtnclk:(){
                Navigator.pop(context);
              });
        }

      } catch (e) {
        print(e);
      }
    }
  }
}
