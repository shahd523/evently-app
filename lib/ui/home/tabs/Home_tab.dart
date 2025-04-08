import 'package:easy_localization/easy_localization.dart';
import 'package:eventlyapp/Providers/User%20Provider/UserProvider.dart';
import 'package:eventlyapp/core/Assets_Manger.dart';
import 'package:eventlyapp/core/Colors_Manager.dart';
import 'package:eventlyapp/core/Strings_Manager.dart';
import 'package:eventlyapp/ui/home/tabs/widgets/AllEventsWidget.dart';
import 'package:eventlyapp/ui/home/tabs/widgets/EventWidget.dart';
import 'package:eventlyapp/ui/home/tabs/widgets/birthdayevents.dart';
import 'package:eventlyapp/ui/home/tabs/widgets/bookclubevents.dart';
import 'package:eventlyapp/ui/home/tabs/widgets/sportsevents.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:provider/provider.dart';

class HomeTab extends StatefulWidget{


  @override
  State<HomeTab> createState() => _HomeTabState();
}

class _HomeTabState extends State<HomeTab> {
  @override

  int  selected=0;
  @override
  Widget build(BuildContext context) {
    UserProvider provider=Provider.of<UserProvider>(context);
    return DefaultTabController(
      length: 4,
      child: Column(
        children:
        [
          Container(padding: EdgeInsets.symmetric(vertical: 40,
            horizontal: 16),
          decoration:
          BoxDecoration(color: Theme.of(context).colorScheme.primary,
              borderRadius: BorderRadius.only(bottomRight:Radius.circular(24)
                  ,bottomLeft:Radius.circular(24) )
          ),
          child: Column(

            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(StringsManager.welcome.tr(),style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                  fontSize: 14,fontWeight: FontWeight.w400
              ),),
              SizedBox(height: 5,),
             provider.isLoading ?
                 const  CircularProgressIndicator(color: Colors.white):
             Text(provider.user?.name??StringsManager.noname.tr(),
                 style: Theme.of(context).textTheme.headlineMedium),
              SizedBox(height: 5,),
              Row(children: [
                SvgPicture.asset(AssetManager.mapicon),
                Text(StringsManager.location.tr(),style: Theme.of(context).textTheme.headlineMedium?.copyWith(
                    fontSize: 14,fontWeight: FontWeight.w400
                ),)

              ],),
              SizedBox(height: 10,),
              TabBar(onTap: (index){
                selected=index;
                setState(() {

                });
              },

                  indicator: BoxDecoration(color: Colors.white,
              borderRadius: BorderRadius.circular(46)),
                  isScrollable: true,
                  tabAlignment: TabAlignment.start,
                  dividerHeight: 0,
                  tabs: [
                Tab(child: Container(
                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: Colors.white
                    ),
                      borderRadius: BorderRadius.circular(46)
                  ),
                  child: Row(children: [
                    SvgPicture.asset(AssetManager.alltab,
                      height: 24,
                      width: 24,
                    colorFilter: ColorFilter.mode(
                      selected==0?ColorsManager.primary_light:Colors.white,
                      BlendMode.srcIn
                    ),
                    ),
                    SizedBox(width: 5,),
                    Text(StringsManager.all.tr(),style:TextStyle(fontSize: 16,fontWeight: FontWeight.w700,color: selected==0?Theme.of(context).colorScheme.primary:Colors.white)),

                  ],),
                ),

                ),
                Tab(child: Container(decoration: BoxDecoration(
                  border: Border.all(color: Colors.white),
                    borderRadius: BorderRadius.circular(46)
                ),
                  padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),
                  child: Row(children: [
                    SvgPicture.asset(AssetManager.sportstab,
                    height: 24,
                    width: 24,
                      colorFilter: ColorFilter.mode(
                          selected==1?ColorsManager.primary_light:Colors.white,
                          BlendMode.srcIn
                      ),

                    ),
                    SizedBox(width: 5,),
                    Text(StringsManager.sport.tr(),style:TextStyle(fontSize: 16,fontWeight: FontWeight.w700,color: selected==1?Theme.of(context).colorScheme.primary:Colors.white)),

                  ],),
                ),),
                Tab(
    child: Container( decoration: BoxDecoration(border: Border.all(
    color: Colors.white,
    ),
        borderRadius: BorderRadius.circular(46)
    ),
      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),

                  child: Row(children: [
                      SvgPicture.asset(AssetManager.caketab,
                      height: 24,
                      width: 24,
                        colorFilter: ColorFilter.mode(
                            selected==2?ColorsManager.primary_light:Colors.white,
                            BlendMode.srcIn
                        ),
                      ),
                    SizedBox(width: 5,),
                    Text(StringsManager.birthday.tr(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700,color: selected==2?Theme.of(context).colorScheme.primary:Colors.white)),

                  ],),
                ),
                  ),
                    Tab(child: Container(
                      decoration: BoxDecoration(border:Border.all(color: Colors.white),
                      borderRadius: BorderRadius.circular(46)),
                      padding: EdgeInsets.symmetric(horizontal: 10,vertical: 10),

                      child: Row(children: [
                        SvgPicture.asset(AssetManager.bookicon,
                          height: 24,
                          width: 24,
                          colorFilter: ColorFilter.mode(
                              selected==3?ColorsManager.primary_light:Colors.white,
                              BlendMode.srcIn
                          ),

                        ),
                        SizedBox(width: 5,),
                        Text(StringsManager.book.tr(),style: TextStyle(fontSize: 16,fontWeight: FontWeight.w700,color: selected==3?Theme.of(context).colorScheme.primary:Colors.white,),)

                      ],),
                    ),),
              ]),
            ],
          ),
          ),

          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: TabBarView(physics: NeverScrollableScrollPhysics(),
                  children:[
                    AllEventsWidget(),
                    SportsEvents(),
                    BirthdayEvents(),
                    BookClubEvents()
              ]
              )
            ),
          )


        ],
      ),
    );
  }
}