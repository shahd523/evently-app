import 'package:easy_localization/easy_localization.dart';
import 'package:eventlyapp/Providers/location%20provider/LocationProvider.dart';
import 'package:eventlyapp/core/Strings_Manager.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';
import 'package:eventlyapp/core/Colors_Manager.dart';

class PickMapScreen extends StatefulWidget{
  static const String routeName="Pick Map screen";

  @override
  State<PickMapScreen> createState() => _PickMapScreenState();
}

class _PickMapScreenState extends State<PickMapScreen> {
  late LocationProvider provider;
  @override
  void initState(){
    super.initState();
    provider=Provider.of(context,listen:(false));
    provider.getlocation();
    provider.setLocation();
  }
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(child: GoogleMap(
            markers: provider.markers,
            onTap: (location){
              provider.changelocation(location);
              Navigator.pop(context);
            },
            initialCameraPosition:
            LocationProvider.cameraPosition,onMapCreated: (controller){
            provider.mapcontroller=controller;
          },)
          ),
          Container(
            padding: EdgeInsets.all(16),
            width: double.infinity,
            decoration:  BoxDecoration(
              color: ColorsManager.primary_light
            ),
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(bottom: 8.0),
                child: Text(StringsManager.tab.tr(),
                  style:Theme.of(context).textTheme.titleSmall?.copyWith(color: Colors.white,fontSize: 18) ,),
              ),
            ),
          )
          
        ],

      ),
    );
  }
}