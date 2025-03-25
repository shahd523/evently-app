import 'package:eventlyapp/model/EventModel.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';

class LocationProvider extends ChangeNotifier{
  late Event event;
  late TextEditingController controlertitle;

  late TextEditingController controlerdesc;
  Location location=Location();
  String locationMsg=" ";
  late GoogleMapController mapcontroller;
  static  CameraPosition cameraPosition = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 17,
  );
  Set<Marker>markers={

       Marker(markerId:const MarkerId("0"),
         position: LatLng(37.42796133580664, -122.085749655962),
       )

  };
  Future<bool> _getLocationPermission()async{
    var permissionstatues=await location.hasPermission();
    if(permissionstatues==PermissionStatus.denied){
      permissionstatues=await location.requestPermission();
    }
    return permissionstatues==PermissionStatus.granted;
  }

  Future<void>getlocation()async{
    locationMsg="Checking Location Service";
    bool locationpermissiongranted=await _getLocationPermission();
    if(!locationpermissiongranted){
      locationMsg="Location Permission Denied";
      notifyListeners();
      return;
    }
    bool locationserviceEnabled=await _serviceEnabled();
    if(!locationserviceEnabled){
      locationMsg="Location Service Disabled";
      notifyListeners();
      return;
    }
    LocationData locationdata=await location.getLocation();
    //mapcontroller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
   // locationMsg ="Location:${locationdata.latitude},${locationdata.longitude}";
    //notifyListeners();
   ChangeLocationData(locationdata);

  }


  Future<bool>_serviceEnabled()async{
  var serviceEnabled=await Location.instance.serviceEnabled();
    if(!serviceEnabled){
      serviceEnabled=await location.requestService();

    }
    return serviceEnabled;
  }
  void setLocation(){
    location.onLocationChanged.listen((Location){
      ChangeLocationData(Location);
      notifyListeners();

    }
    );


  }
  LatLng? userlocation;

  void ChangeLocationData(LocationData location) {
    cameraPosition=CameraPosition(
        target:LatLng(location.latitude!,location.longitude!) );
    markers={
      Marker(markerId: const MarkerId("0"),
      position: LatLng(location.latitude!,location.longitude!))
    };
    mapcontroller.animateCamera(CameraUpdate.newCameraPosition(cameraPosition));
    notifyListeners();
  }
  void changelocation(LatLng newlocation){
    userlocation=newlocation;
    notifyListeners();
  }
  void initdata(Event evnt){
    event=evnt;
    controlertitle.text=evnt.title!;
    controlerdesc.text=evnt.description!;
    location=LatLng(evnt.lat!, evnt.lng!) as Location;
    notifyListeners();



  }
}