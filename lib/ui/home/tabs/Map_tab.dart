import 'package:eventlyapp/Providers/location%20provider/LocationProvider.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:provider/provider.dart';

class MapTab extends StatefulWidget{
  @override
  State<MapTab> createState() => _MapTabState();
}

class _MapTabState extends State<MapTab> {
  late LocationProvider provider;
  void initState(){
    super.initState();

  }
  @override
  Widget build(BuildContext context) {
    provider=Provider.of<LocationProvider>(context);
    return Consumer<LocationProvider>(builder: (context, value, child){
      return Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.endTop,
        floatingActionButton: FloatingActionButton(onPressed: (){
          provider.setLocation();
        },child: const Icon(Icons.gps_fixed_outlined)),
        body:Column(
          children: [
            Expanded(child: GoogleMap(
              markers: provider.markers,
              initialCameraPosition:
            LocationProvider.cameraPosition,
              onMapCreated: (controller){
                provider.mapcontroller=controller;
            },))
          ],
          
        )
      );
    });
    }
  }