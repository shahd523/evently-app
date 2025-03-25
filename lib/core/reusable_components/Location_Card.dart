import 'package:eventlyapp/core/Colors_Manager.dart';
import 'package:flutter/material.dart';
import 'package:geocode/geocode.dart';

class LocationCard extends StatefulWidget{
  @override
  final double lat;
  final double long;

  const LocationCard({super.key, required this.lat, required this.long});

  @override
  State<LocationCard> createState() => _LocationCardState();
}

class _LocationCardState extends State<LocationCard> {
  String locationmsg=" ";
  void initState(){
    super.initState();
    getLocation();
  }
  Widget build(BuildContext context) {

    return Container(
      decoration: BoxDecoration(borderRadius: BorderRadius.circular(16),
          border: Border.all(color: ColorsManager.primary_light)),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Container(
            padding: const EdgeInsets.all(8),
            decoration:  BoxDecoration(
                color: Theme.of(context).colorScheme.primary,
                borderRadius: BorderRadius.circular(8)
            ),
            child: Icon(Icons.gps_fixed,size: 32,color: Theme.of(context).colorScheme.secondary),


          ),
          const SizedBox(width:8,),
          Expanded(child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(locationmsg, style: Theme.of(context).textTheme.titleSmall!
                  .copyWith(color: ColorsManager.primary_light),)
            ],
          ))

        ],
      ),
    ) ;
  }
  void getLocation()async{
  var responce=await GeoCode().
  reverseGeocoding(latitude:widget.lat, longitude: widget.long);
  locationmsg="${responce.countryName}${responce.streetAddress}"??" ";
  setState(() {});
}
}