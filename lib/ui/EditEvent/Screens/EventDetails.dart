import 'package:easy_localization/easy_localization.dart';
import 'package:eventlyapp/core/Colors_Manager.dart';
import 'package:eventlyapp/core/FireStoreHandler.dart';
import 'package:eventlyapp/core/Strings_Manager.dart';
import 'package:eventlyapp/core/reusable_components/Date_Time%20Card.dart';
import 'package:eventlyapp/core/reusable_components/DialogUtils.dart';
import 'package:eventlyapp/core/reusable_components/Location_Card.dart';
import 'package:eventlyapp/core/reusable_components/Map_Card.dart';
import 'package:eventlyapp/model/EventModel.dart';
import 'package:eventlyapp/ui/create_event/Create_Event.dart';
import 'package:flutter/material.dart';
import '../../../core/Assets_Manger.dart';
import 'package:eventlyapp/core/Constrains.dart';

class EventDetailsScreen extends StatefulWidget{
  static const String routeName="Event Details Screen";
  final Event event;
  const EventDetailsScreen({super.key, required this.event});

  @override
  State<EventDetailsScreen> createState() => _EventDetailsScreenState();
}

class _EventDetailsScreenState extends State<EventDetailsScreen> {
  @override
  void dispose(){
    super.dispose();
  }
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          toolbarHeight: 40,
          foregroundColor: ColorsManager.primary_light,
          title: Text(StringsManager.eventdetails.tr()),
          actions: [
            IconButton(onPressed:(){
              Navigator.pushNamed(context,CreateEvent.routeName,arguments: widget.event);
              FireStoreHandler.updateEvent(widget.event);
            },
                icon:Icon(Icons.edit)),
            IconButton(onPressed: (){
              deleteEvent();
            },
                icon:Icon(Icons.delete,color: Colors.red,))
          ],
        ),

      body:Column(children: [

           Image.asset(getImagebycategory(),width: double.infinity,),

        ListView(
          shrinkWrap: true,
          padding: EdgeInsets.all(16),
          children: [
            const  SizedBox(height: 16),
            Text("${StringsManager.we.tr()} ${widget.event.title!}",style: Theme.of(context).textTheme.titleMedium!.copyWith(color: ColorsManager.primary_light
            ),),
            const  SizedBox(height: 16),
            DateTimeCard(date:widget.event.date!.toDate().toString()),
            const  SizedBox(height: 16),
            LocationCard(lat: widget.event.lat!.toDouble(), long: widget.event.lng!.toDouble()),
            const  SizedBox(height: 16),
            MapCard(lat: widget.event.lat!.toDouble(), lng: widget.event.lng!.toDouble()),
            const  SizedBox(height:5),
            Text(StringsManager.descr.tr(),style: Theme.of(context).textTheme.titleSmall,),
            Text(widget.event.description!,style: Theme.of(context).textTheme.titleSmall,)


          ],


        ),

      ],)

    );
  }

  String getImagebycategory(){
    if(widget.event.category==sportcat)
    {
      return AssetManager.eventphoto3;

    }
    else if (widget.event.category==birthdaycat){
      return AssetManager.eventphoto1;
    }
    else{
      return AssetManager.eventphoto2;
    }
  }

   Future<void>deleteEvent()async{
    await FireStoreHandler.deleteEvent(widget.event.id??"");
    Navigator.pop(context);
    DialogUtils.showtoast(StringsManager.deleted.tr());
  }
}

