import 'package:eventlyapp/Providers/ThemePovider/ThemeProvider.dart';
import 'package:eventlyapp/core/Assets_Manger.dart';
import 'package:eventlyapp/core/Colors_Manager.dart';
import 'package:eventlyapp/model/OnBoardingModel.dart';
import 'package:eventlyapp/ui/Login/screen/login_screen.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class OnBoardingScreen extends StatefulWidget{
  static const String routeName="OnBoarding";
  @override
  State<OnBoardingScreen> createState() => _OnBoardingScreenState();
}

class _OnBoardingScreenState extends State<OnBoardingScreen> {
  PageController pageController=PageController(initialPage: 0);
 late ThemeProvider provider;

  int index=0;
  @override
  Widget build(BuildContext context) {
    provider=Provider.of(context);
   return Scaffold(
     appBar:AppBar(
       title: Image.asset(AssetManager.logo),
     ),
     body: Expanded(
         flex:1,
       child: PageView.builder(controller:pageController ,
       onPageChanged: (value){
       setState(() {
         index=value;
       });},
       itemCount:provider.currenttheme==ThemeMode.light?
       OnBoardingModel.onbourdinglight.length
           :OnBoardingModel.onbourdingdark.length ,
       itemBuilder:provider.currenttheme==ThemeMode.light?(context,index)=>Column(
         crossAxisAlignment: CrossAxisAlignment.center,
         children: [  Padding(
           padding: const EdgeInsets.all(19),
           child: Image.asset(OnBoardingModel.onbourdinglight[index].sora,height: 400,),
         ),
           SizedBox(height: 15,),
           Text( OnBoardingModel.onbourdinglight[index].text1,style: Theme.of(context).textTheme.titleMedium?.copyWith(color: ColorsManager.primary_light),
               textAlign: TextAlign.start
             ),
           SizedBox(height: 20,),
           Text( OnBoardingModel.onbourdinglight[index].text2,style: Theme.of(context).textTheme.titleSmall?.copyWith(color: ColorsManager.secondary_light)
             ,textAlign: TextAlign.start,),
         ],
       ):(context,index)=>Column(
    crossAxisAlignment: CrossAxisAlignment.center,
    children: [  Padding(
    padding: const EdgeInsets.all(19),
    child: Image.asset(OnBoardingModel.onbourdingdark[index].sora,height: 400,),
    ),
    SizedBox(height: 15,),
    Text( OnBoardingModel.onbourdingdark[index].text1
    ,style: Theme.of(context).textTheme.titleMedium?.copyWith(color: ColorsManager.primary_dark),textAlign: TextAlign.start),
    SizedBox(height: 20,),
    Text( OnBoardingModel.onbourdingdark[index].text2,style: Theme.of(context).textTheme.titleSmall?.copyWith(color: ColorsManager.secondary_dark)
    ,textAlign: TextAlign.start,),
         Row(
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             /*onPressed:() {pageController.previousPage(
                     duration: Duration(milliseconds: 200),
                     curve: Curves.easeInSine);*/
             Container(decoration: BoxDecoration(border: Border.all(color: ColorsManager.primary_light,
             ),borderRadius: BorderRadius.circular(25)),
               child: Visibility(
                   visible: index>0,
                   child:IconButton(onPressed:() {pageController.previousPage(
                   duration: Duration(milliseconds: 200),
                   curve: Curves.easeInSine);},
                       icon:Icon(Icons.arrow_back),color: ColorsManager.primary_light)
               ),
             )
             ,
             AnimatedSmoothIndicator(activeIndex:index,
               count: OnBoardingModel.onbourdinglight.length,effect:ExpandingDotsEffect(dotHeight:7,
                   dotWidth: 7,activeDotColor: ColorsManager.primary_light,
                   dotColor: provider.currenttheme==ThemeMode.light? ColorsManager.secondary_light:ColorsManager.secondary_dark),)


             ,Container(decoration: BoxDecoration(borderRadius: BorderRadius.circular(25),
             border:Border.all(color: ColorsManager.primary_light)),
               child: IconButton(onPressed:() {
                 if(provider.currenttheme==ThemeMode.light?index>=OnBoardingModel.onbourdinglight.length-1:index>=OnBoardingModel.onbourdingdark.length-1){
                   Navigator.pushNamed(context, LoginScreen.routeName);
                   }
                   else{
                   pageController.nextPage(
                   duration: Duration(milliseconds: 200),
                   curve: Curves.easeInSine);}}

                ,icon:Icon(Icons.arrow_forward),color: ColorsManager.primary_light,),
             )
    ],)
    ]
       ),
     )

     )
   );

  }
}
/*if(index>=OnBoardingModel.onbourding.length-1){
                 Navigator.pushNamed(context, HomeScreen.routeName);
               }
               else{
                 pageController.nextPage(
                     duration: Duration(milliseconds: 200),
                     curve: Curves.easeInSine);
               }*/