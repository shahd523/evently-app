import 'package:easy_localization/easy_localization.dart';
import 'package:eventlyapp/Providers/ThemePovider/ThemeProvider.dart';
import 'package:eventlyapp/Providers/User%20Provider/UserProvider.dart';
import 'package:eventlyapp/core/Assets_Manger.dart';
import 'package:eventlyapp/core/Colors_Manager.dart';
import 'package:eventlyapp/core/Strings_Manager.dart';
import 'package:eventlyapp/ui/Login/screen/login_screen.dart';
import 'package:eventlyapp/ui/home/tabs/widgets/langbottomsheet.dart';
import 'package:eventlyapp/ui/home/tabs/widgets/themebottomsheet.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class ProfileTab extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    ThemeProvider provider=Provider.of<ThemeProvider>(context);
    UserProvider userprovider=Provider.of<UserProvider>(context);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Container(padding: EdgeInsets.symmetric(vertical: 40,
            horizontal: 16),
          decoration:
          BoxDecoration(color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.only(
                  bottomLeft:Radius.circular(24) )
          ),
          child: Row(
            children: [
              Container(
                height: 124,
                width: 124,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadiusDirectional.only(
                    topEnd: Radius.circular(1000),
                    bottomStart: Radius.circular(1000),
                    bottomEnd: Radius.circular(1000)
                  )
                ),
                child: Icon(Icons.person
                ,color: Colors.grey,
                size: 100,),
              ),
              SizedBox(width:  16,),
              Column(

                crossAxisAlignment: CrossAxisAlignment.start,
                children: [

                userprovider.isLoading ?
                 const CircularProgressIndicator(color: Colors.white):
                   Text(userprovider.user?.name??StringsManager.noname.tr(),style: Theme.of(context).textTheme.headlineMedium),
                  SizedBox(height: 8,),
                  Text(FirebaseAuth.instance.currentUser?.email??StringsManager.nouser.tr(),style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                      fontSize: 16,fontWeight: FontWeight.w500
                  ),),
                  SizedBox(height: 10,),

                ],
              ),
            ],
          ),
        ),
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              vertical:  24,
              horizontal: 16
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(StringsManager.lang.tr(), style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black)),
                SizedBox(height: 16,),
                InkWell(
                  onTap: (){
                    showModalBottomSheet(context: context,
                        builder:(context)=>LanguageButtomSheet());
                  },
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(16),
                      border: Border.all(
                        color: ColorsManager.primary_light
                      )
                    ),
                    child: Row(
                      children: [Text(context.locale.languageCode=="ar"?"العربيه":"English",
                        style: Theme.of(context).textTheme.titleMedium,),
                        Icon(Icons.arrow_drop_down,
                        size: 30,
                        color: ColorsManager.primary_light,)

                      ],
                    ),
                  ),
                ),
                SizedBox(height: 16,),
                Text(StringsManager.theme.tr(), style: Theme.of(context).textTheme.titleMedium?.copyWith(color: Colors.black)),

                InkWell(
                  onTap: (){
                    showModalBottomSheet(context: context, builder:(context)=> ThemeButtomSheet());
                  },
                  child: Container(
                    padding: EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(16),
                        border: Border.all(
                            color: ColorsManager.primary_light
                        )
                    ),
                    child: Row(
                      children: [Text(provider.currenttheme==ThemeMode.dark?StringsManager.dark.tr():StringsManager.light.tr(),
                        style: Theme.of(context).textTheme.titleMedium,),
                        Icon(Icons.arrow_drop_down,
                          size: 30,
                          color: ColorsManager.primary_light,)

                      ],
                    ),
                  ),
                ),
                Spacer(),
                ElevatedButton(onPressed: (){
                  logout();

                  Navigator.of(context).pushReplacementNamed(LoginScreen.routeName);
                }, child: Padding(
                  padding: const EdgeInsets.all(16),
                  child: Row(
                    children: [
                      Icon(Icons.logout,color:Colors.white ,),
                      SizedBox(width: 8,),
                      Text(StringsManager.logout.tr(),style: TextStyle(color: Colors.white),),

                    ],
                  ),
                ),
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.redAccent,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(16)
                    )
                  ),
                )
              ],
            ),
          ),
        )


      ],
    );
  }
  static Future<void> logout()async{
    FirebaseAuth.instance.signOut();
    await GoogleSignIn().signOut();
  }

}