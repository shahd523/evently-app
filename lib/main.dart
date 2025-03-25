import 'package:eventlyapp/Providers/ThemePovider/ThemeProvider.dart';
import 'package:eventlyapp/Providers/User%20Provider/UserProvider.dart';
import 'package:eventlyapp/Providers/location%20provider/LocationProvider.dart';
import 'package:eventlyapp/core/App_Style.dart';
import 'package:eventlyapp/core/Colors_Manager.dart';
import 'package:eventlyapp/firebase_options.dart';
import 'package:eventlyapp/ui/EditEvent/Screens/EventDetails.dart';
import 'package:eventlyapp/ui/Login/screen/login_screen.dart';
import 'package:eventlyapp/ui/Register/screens/RegisterScreen.dart';
import 'package:eventlyapp/ui/create_event/Create_Event.dart';
import 'package:eventlyapp/ui/forgetpassword/screen.dart';
import 'package:eventlyapp/ui/home/Screen/HomeScreen.dart';
import 'package:eventlyapp/ui/home/tabs/widgets/PickMapScreen.dart';
import 'package:eventlyapp/ui/onboarding/screen/onboardingscreen.dart';
import 'package:eventlyapp/ui/start_screen/screen/StartScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:provider/provider.dart';

import 'core/PrefsHelper.dart';
import 'model/EventModel.dart';

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await PrefsHelper.init();
  await EasyLocalization.ensureInitialized();
  runApp(
      EasyLocalization(
      supportedLocales: [Locale('en'), Locale('ar')],
      path: 'assets/translations', // <-- change the path of the translation files
      fallbackLocale: Locale('en'),
      saveLocale: true,
      child: MultiProvider(
          providers: [
          ChangeNotifierProvider(create: (context)=>ThemeProvider()..initTheme()),
            ChangeNotifierProvider(create: (context)=>LocationProvider())
          ],
          child: const MyApp())));
}
/*MultiProvider(providers: [
ChangeNotifierProvider(create: (context)=>LocationProvider())
]),*/

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    ThemeProvider themeprovider=Provider.of<ThemeProvider>(context);
    return MaterialApp(
      localizationsDelegates: context.localizationDelegates,
      supportedLocales: context.supportedLocales,
      locale: context.locale,
      title: 'Flutter Demo',
      theme:AppStyle.LightTheme,
      darkTheme:AppStyle.DarkTheme,
      themeMode:themeprovider.currenttheme,
      routes: {
        StartScreen.routeName:(_)=>StartScreen(),
        RegisterScreen.routeName:(_)=>RegisterScreen(),
        LoginScreen.routeName:(_)=>LoginScreen(),
        ForgetPasswordScreen.routename:(_)=>ForgetPasswordScreen(),
        HomeScreen.routename:(_)=>ChangeNotifierProvider(create: (context)=>UserProvider()..getUser(),
            child: HomeScreen()),
        CreateEvent.routeName:(_)=>CreateEvent(),
        OnBoardingScreen.routeName:(_)=>OnBoardingScreen(),
        PickMapScreen.routeName:(_)=>PickMapScreen(),
        EventDetailsScreen.routeName:(context){
           Event event =ModalRoute.of(context)!.settings.arguments as Event;
          return  EventDetailsScreen(event: event);
        }
       // LoginScreen.routeName
      },
      initialRoute:FirebaseAuth.instance.currentUser==null?StartScreen.routeName:
      HomeScreen.routename,

    );
  }
}
