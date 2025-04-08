import 'package:easy_localization/easy_localization.dart';
import 'package:eventlyapp/core/Assets_Manger.dart';
import 'package:eventlyapp/core/Colors_Manager.dart';
import 'package:eventlyapp/core/Constrains.dart';
import 'package:eventlyapp/core/FireStoreHandler.dart';
import 'package:eventlyapp/core/Strings_Manager.dart';
import 'package:eventlyapp/core/reusable_components/Custom_Btn.dart';
import 'package:eventlyapp/core/reusable_components/custom_textfield.dart';
import 'package:eventlyapp/ui/Register/screens/RegisterScreen.dart';
import 'package:eventlyapp/ui/forgetpassword/screen.dart';
import 'package:eventlyapp/ui/home/Screen/HomeScreen.dart';
import 'package:eventlyapp/ui/start_screen/widgets/Language_Toggle.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:eventlyapp/model/User.dart'as myuser;

import '../../../core/reusable_components/DialogUtils.dart';

class LoginScreen extends StatefulWidget{
  static const String routeName="Login";


  @override


  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  late TextEditingController namecontroller;
  late TextEditingController emailcontroller;
  late TextEditingController passcontroller;
  late TextEditingController repasscontroller;
  GlobalKey<FormState>formkey = GlobalKey<FormState>();

  @override
  void initState() {
    emailcontroller = TextEditingController();
    passcontroller = TextEditingController();
  }

  void dispose() {
    super.dispose();
    emailcontroller.dispose();
    passcontroller.dispose();
  }

  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Form(
              key: formkey,
              child: Column(

                children: [
                  Image.asset(AssetManager.logologin),
                  SizedBox(height: 24,),
                  CustomField(
                    prifex: AssetManager.emailicon,
                    hinttext: StringsManager.email.tr(),
                    controller: emailcontroller,
                    keyboard: TextInputType.emailAddress,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return StringsManager.required.tr();
                      }
                      if (!RegExp(emailRegex).hasMatch(value)) {
                        return StringsManager.notvalidemail.tr();
                      }
                      return null;
                    },
                  ),
                  SizedBox(height: 16,),
                  CustomField(
                    prifex: AssetManager.lockicon,
                    hinttext: StringsManager.pass.tr(),
                    controller: passcontroller,
                    keyboard: TextInputType.visiblePassword,
                    isobsecured: true,
                    validator: (value) {
                      if (value == null || value.isEmpty) {
                        return StringsManager.required.tr();
                      }
                      if (value.length < 8) {
                        return StringsManager.atleast.tr();
                      }
                      return null;
                    },),
                  SizedBox(height: 5,),
                  Align(alignment: AlignmentDirectional.centerEnd,
                    child: TextButton(onPressed: () {
                      Navigator.pushNamed(
                          context, ForgetPasswordScreen.routename);
                    },
                        child: Text(StringsManager.forgetpass.tr(),
                            style: Theme
                                .of(context)
                                .textTheme
                                .titleSmall
                                ?.copyWith(
                              fontWeight: FontWeight.w700,
                              fontStyle: FontStyle.italic,
                              color: ColorsManager.primary_dark,
                              decoration: TextDecoration.underline,
                              decorationColor: ColorsManager.primary_dark,))),
                  ),
                  CustomBtn(label: StringsManager.login.tr(), onpressed: () {
                    if (formkey.currentState!.validate()) {
                      signin();

                    }
                  }),
                  SizedBox(height: 16,),
                  Row(mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(StringsManager.donthaveacc.tr(),
                        style: Theme
                            .of(context)
                            .textTheme
                            .titleSmall,),
                      TextButton(onPressed: () {
                        Navigator.pushReplacementNamed(context,
                            RegisterScreen.routeName);
                      }, child: Text(StringsManager.register.tr(),
                          style: Theme
                              .of(context)
                              .textTheme
                              .titleSmall
                              ?.copyWith(
                            color: ColorsManager.primary_dark,
                            decoration: TextDecoration.underline,
                            decorationColor: ColorsManager.primary_dark,))),


                    ],
                  ),
                  SizedBox(height: 24,),
                  Row(
                    children: [
                      Expanded(child: Divider()),
                      SizedBox(width: 16,),
                      Text(StringsManager.or.tr(), style: Theme
                          .of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(
                        color: ColorsManager.primary_dark,)),
                      SizedBox(width: 16,),
                      Expanded(child: Divider()),
                      SizedBox(height: 24,),


                    ],
                  ),
                  ElevatedButton(
                      onPressed: () async{
                        try{ UserCredential response=await signInWithGoogle();
                          if(response.user?.uid !=null){
                            Navigator.pushReplacementNamed(context,HomeScreen.routename);
                            return;
                          }
                        Navigator.pop(context);
                        }
                        catch(e){
                          print(e.toString());
                        }



                      }, style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.transparent,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(16),
                          side: BorderSide(
                              color: ColorsManager.primary_light,
                              width: 1,
                              style: BorderStyle.solid
                          )
                      )
                  ),
                      child: Row(mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          SvgPicture.asset(AssetManager.googleicon),
                          SizedBox(width: 10,),
                          Text(StringsManager.loginwithgoogle.tr()
                              , style: Theme
                                  .of(context)
                                  .textTheme
                                  .titleSmall
                                  ?.copyWith(
                                color: ColorsManager.primary_dark,
                              )
                          )
                        ],)),
                  LanguageToggle()


                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  signin() async {
    if (formkey.currentState!.validate()) {


      try {
        final credential = await FirebaseAuth.instance
            .signInWithEmailAndPassword(
            email: emailcontroller.text,
            password: passcontroller.text
        );
        Navigator.pushReplacementNamed(context,HomeScreen.routename);
      } on FirebaseAuthException catch (e) {
        if (e.code == StringsManager.firebase5) {
          DialogUtils.showmessagedialog(context: context,
              text: StringsManager.firebase6.tr(), posbtntxt: StringsManager.Ok.tr(),
              posbtnclk: () {
                Navigator.pop(context);
              }
          );
        } else if (e.code == StringsManager.firebase7) {
          DialogUtils.showmessagedialog(context: context,
              text: StringsManager.firebase8.tr(), posbtntxt:StringsManager.Ok.tr(),
              posbtnclk: () {
                Navigator.pop(context);
              }

          );

        }
       }
    }
  }
  Future<UserCredential> signInWithGoogle() async {
    // Trigger the authentication flow
    final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();

    // Obtain the auth details from the request
    final GoogleSignInAuthentication? googleAuth = await googleUser?.authentication;

    // Create a new credential
    final credential = GoogleAuthProvider.credential(
      accessToken: googleAuth?.accessToken,
      idToken: googleAuth?.idToken,

    );
    var credentials= await FirebaseAuth.instance.signInWithCredential(credential);
    await FireStoreHandler.AddUser(myuser.User(
      id: credentials.user!.uid,
      email: credentials.user!.email,
      name: credentials.user!.displayName,
      favorites:[],

    ));
    return credentials;



    // Once signed in, return the UserCredential

  }




}





