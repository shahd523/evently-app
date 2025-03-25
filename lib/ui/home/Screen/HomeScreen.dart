import 'package:easy_localization/easy_localization.dart';
import 'package:eventlyapp/core/Assets_Manger.dart';
import 'package:eventlyapp/core/FireStoreHandler.dart';
import 'package:eventlyapp/core/Strings_Manager.dart';
import 'package:eventlyapp/ui/create_event/Create_Event.dart';
import 'package:eventlyapp/ui/home/tabs/Home_tab.dart';
import 'package:eventlyapp/ui/home/tabs/Love_tab.dart';
import 'package:eventlyapp/ui/home/tabs/Map_tab.dart';
import 'package:eventlyapp/ui/home/tabs/Profile_tab.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget{
  static const String routename="Home";

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int selectedIndex=0;
  List<Widget>tabs=[
    HomeTab(),MapTab(),LoveTab(),ProfileTab()
  ];
  void initState(){
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
   // print("user: ${FirebaseAuth.instance.currentUser?.uid}");
    return Scaffold(
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: selectedIndex,
          onTap: (newindex){
          selectedIndex=newindex;
          setState(() {
          });
          },
          showSelectedLabels: true,
          showUnselectedLabels: true,
          unselectedItemColor: Colors.white,
          selectedItemColor: Colors.white,
          items: [
        BottomNavigationBarItem(icon: SvgPicture.asset(AssetManager.homeaicon),
          activeIcon:SvgPicture.asset(AssetManager.homeaicons
        ),
          label:StringsManager.hometab.tr(),
        ),
        BottomNavigationBarItem(icon: SvgPicture.asset(AssetManager.mapicon),
            activeIcon:SvgPicture.asset(AssetManager.mapicons
            ),
          label:StringsManager.maptab.tr() ,
        ),
        BottomNavigationBarItem(icon: SvgPicture.asset(AssetManager.loveicon),
            activeIcon:SvgPicture.asset(AssetManager.loveicons
            ),
          label:StringsManager.lovetab.tr() ,
        ),
        BottomNavigationBarItem(icon: SvgPicture.asset(AssetManager.profileicon),
            activeIcon:SvgPicture.asset(AssetManager.profileicons
            ),
          label:StringsManager.profiletab.tr() ,

        )]),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          Navigator.pushNamed(context,CreateEvent.routeName);
        },
        shape: StadiumBorder(
          side: BorderSide(
            color: Colors.white,
            width: 5

          ),

        ),
        child: Icon(Icons.add,
        size: 30,),
      ),
      floatingActionButtonLocation:FloatingActionButtonLocation.centerDocked ,
      body: tabs[selectedIndex],
    );
  }
}