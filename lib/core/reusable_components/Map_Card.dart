import 'package:eventlyapp/core/Colors_Manager.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';

class MapCard extends StatelessWidget{
   double lat;
  double lng;
  MapCard({required this.lat,required this.lng});
  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(color: ColorsManager.primary_light,width: 1),
        borderRadius: BorderRadius.circular(16),

      ),
      width: double.infinity,
      height: MediaQuery.of(context).size.height*0.3,
      child: ClipRRect(
        borderRadius:BorderRadius.circular(16) ,
        child: GoogleMap(initialCameraPosition: CameraPosition(target: LatLng(lat, lng),
        zoom: 17),
          scrollGesturesEnabled: false,
          tiltGesturesEnabled: false,
          zoomGesturesEnabled: false,
          markers: { Marker(markerId: const MarkerId("0"),
              position: LatLng(lat, lng)),
          }),

      ),
    );

  }
}