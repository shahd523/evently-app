import 'package:eventlyapp/core/Constrains.dart';
import 'package:eventlyapp/core/FireStoreHandler.dart';
import 'package:eventlyapp/model/EventModel.dart';
import 'package:eventlyapp/ui/home/tabs/widgets/EventWidget.dart';
import 'package:flutter/material.dart';

class BookClubEvents extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return StreamBuilder(stream:FireStoreHandler.GetCategoryEventsStream(bookcat),
        builder:(context,snapshot){
          if(snapshot.connectionState==ConnectionState.waiting){
            //inloading
            return Center(child: const CircularProgressIndicator());
          }
          else if(snapshot.hasError){
            //error state
            return Text(snapshot.error!.toString());
          }
          else{
            List<Event>events=snapshot.data??[];
            return events.isEmpty?Center(child: Text("No Events Found"),):
            ListView.separated(
                itemBuilder:(context,index)=>EventItem(event: events[index],),
                separatorBuilder: (context,index)=>SizedBox(height: 16),
                itemCount:events.length);
            //sucsses state

          }
        });
  }

}