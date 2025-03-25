import 'package:easy_localization/easy_localization.dart';
import 'package:eventlyapp/core/FireStoreHandler.dart';
import 'package:eventlyapp/core/Strings_Manager.dart';
import 'package:eventlyapp/core/reusable_components/custom_textfield.dart';
import 'package:eventlyapp/model/EventModel.dart';
import 'package:eventlyapp/ui/home/tabs/widgets/EventWidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class LoveTab extends StatefulWidget{
  @override
  State<LoveTab> createState() => _LoveTabState();
}
class _LoveTabState extends State<LoveTab> {
  late TextEditingController searchController;
  void initState(){
    super.initState();
    searchController=TextEditingController();
  }
  void dispose(){
    super.dispose();
    searchController.dispose();
  }
  @override
  SafeArea build(BuildContext context)  {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.only(
          left: 16,
          right: 16,
          top: 16,
        ),
        child: Column(
          children: [
            CustomField(hinttext:StringsManager.search.tr(), prifex:"assets/images/searchbaricon.svg",
              controller:searchController, keyboard:TextInputType.text ,
              validator:(value){
            return null;
              }),
          SizedBox(height: 16,),
           Expanded(
             child: StreamBuilder(stream:FireStoreHandler.getmywishlistStream(FirebaseAuth.instance.currentUser!.uid),
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
              return events.isEmpty?Center(child: Text(StringsManager.nowich.tr()),):
              ListView.separated(itemBuilder:(context,index)=>EventItem(event: events[index],),
                  separatorBuilder: (context,index)=>SizedBox(height: 16),
                  itemCount:events.length);
              //sucsses state

                       }
                     }),
           )
          ],


        ),
      ),
    );
  }
}