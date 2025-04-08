

import 'package:eventlyapp/Providers/ThemePovider/ThemeProvider.dart';
import 'package:eventlyapp/Providers/User%20Provider/UserProvider.dart';
import 'package:eventlyapp/core/Assets_Manger.dart';
import 'package:eventlyapp/core/Colors_Manager.dart';
import 'package:eventlyapp/core/Constrains.dart';
import 'package:eventlyapp/core/FireStoreHandler.dart';
import 'package:eventlyapp/core/reusable_components/DialogUtils.dart';
import 'package:eventlyapp/model/EventModel.dart';
import 'package:eventlyapp/ui/EditEvent/Screens/EventDetails.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class EventItem extends StatefulWidget{
  final Event event;

   EventItem({super.key,
    required this.event
  });

  @override
  State<EventItem> createState() => _EventItemState();
}

class _EventItemState extends State<EventItem> {

 late List<String>userfavsIds;
  @override
  Widget build(BuildContext context) {
    ThemeProvider provider=Provider.of(context);
    double height=MediaQuery.of(context).size.height;
    UserProvider userprovider=Provider.of<UserProvider>(context);
    userfavsIds=userprovider.user?.favorites??[];
    print(userfavsIds);

     return InkWell(
       borderRadius: BorderRadius.circular(16),
       onTap:(){
       Navigator.pushNamed(context,EventDetailsScreen.routeName,arguments:widget.event);},
       child: Container(
         height: height*0.25,

         decoration: BoxDecoration(
           image: DecorationImage(image: AssetImage(getImagebycategory(),
           ),fit: BoxFit.cover),
           borderRadius: BorderRadius.circular(8),
         ),
         child: Column(
           crossAxisAlignment: CrossAxisAlignment.start,
           mainAxisAlignment: MainAxisAlignment.spaceBetween,
           children: [
             Container(
               padding: EdgeInsets.all(8),
               decoration: BoxDecoration(
                 color: Theme.of(context).colorScheme.onPrimary,
                 borderRadius: BorderRadius.circular(8)
               ),
               child: Column(
                 children: [
                   Text(widget.event.date!.toDate().day.toString(),style: Theme.of(context).textTheme.titleMedium,),
                   Text(DateFormat.MMM().format(widget.event.date!.toDate()),style: Theme.of(context).textTheme.titleMedium,),
                 ],
               ),
             ),
             Container(
               width: double.infinity,
               padding:EdgeInsets.all(8) ,
               child: Container(
                 width: double.infinity,
                 padding: EdgeInsets.all(8),
                 decoration: BoxDecoration(
                   color: provider.currenttheme==ThemeMode.light?ColorsManager.bacground_light:ColorsManager.backrround_dark,
                   borderRadius: BorderRadius.circular(4)
                 ),

                 child: Row(
                   children: [
                   Expanded(child: Text(widget.event.title??"",style: Theme.of(context).textTheme.displaySmall?.copyWith(color: Theme.of(context).colorScheme.secondary),)),
                   InkWell(
                     onTap: () async {
                       if(userfavsIds.contains(widget.event.id)){
                         DialogUtils.showLoadingDialog(context);
                         await  FireStoreHandler.removeFromFav(FirebaseAuth.instance.currentUser!.uid,
                             widget.event.id!);
                        userprovider.user?.favorites?.remove(widget.event.id??"");
                       await FireStoreHandler.updateUserFaves(FirebaseAuth.instance.currentUser!.uid
                             ,userprovider.user?.favorites??[] );

                         Navigator.pop(context);
                       }
                       else{
                         DialogUtils.showLoadingDialog(context);

                         await  FireStoreHandler.addToFavorite(FirebaseAuth.instance.currentUser!.uid,
                             widget.event);
                         userprovider.user?.favorites?.add(widget.event.id??"");
                         await FireStoreHandler.updateUserFaves(FirebaseAuth.instance.currentUser!.uid
                             ,userprovider.user?.favorites??[] );

                         Navigator.pop(context);

                       }
                       setState(() {
                       });
                     },
                     child: SvgPicture.asset(
           userfavsIds.contains(widget.event.id)
                           ?
                       AssetManager.loveicons
                       :AssetManager.loveicon,
                     height: 24,
                     width: 24,
                     colorFilter: ColorFilter.mode(ColorsManager.primary_light, BlendMode.srcIn),),
                   )
                 ],),
               ),
             )
           ],
         ),

       ),
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
}