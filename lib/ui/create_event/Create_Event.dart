import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:easy_localization/easy_localization.dart';
import 'package:eventlyapp/Providers/location%20provider/LocationProvider.dart';
import 'package:eventlyapp/core/Constrains.dart';
import 'package:eventlyapp/core/FireStoreHandler.dart';
import 'package:eventlyapp/core/Strings_Manager.dart';
import 'package:eventlyapp/core/reusable_components/Custom_Btn.dart';
import 'package:eventlyapp/core/reusable_components/DialogUtils.dart';
import 'package:eventlyapp/core/reusable_components/custom_textfield.dart';
import 'package:eventlyapp/model/EventModel.dart';
import 'package:eventlyapp/ui/home/Screen/HomeScreen.dart';
import 'package:eventlyapp/ui/home/tabs/widgets/PickMapScreen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';

import '../../core/Assets_Manger.dart';
import '../../core/Colors_Manager.dart';

class CreateEvent extends StatefulWidget{
  static const String routeName ="Create Event";

  /*CreateEvent({this.event,super.key});*/

  @override
  State<CreateEvent> createState() => _CreateEventState();
}

class _CreateEventState extends State<CreateEvent> {
  late Event ?event;
  late LocationProvider provider;


  late TextEditingController controlertitle;

  late TextEditingController controlerdesc;

  GlobalKey<FormState>formkey = GlobalKey<FormState>();

  @override
  void initState() {
    super.initState();
    controlertitle = TextEditingController();
    controlerdesc = TextEditingController();
    /* if(widget.event!=null){
    provider.initdata(widget.event!);}*/
  }

  void dispose() {
    super.dispose();
    controlertitle.dispose();
    controlerdesc.dispose();
  }

  void didChangeDependencies() {
    super.didChangeDependencies();

    event = ModalRoute
        .of(context)!
        .settings
        .arguments as Event?;
    if (event != null) {
      controlertitle = TextEditingController(text: event?.title ?? " ");
      controlerdesc = TextEditingController(text: event?.description ?? " ");

      selectedDate = DateTime(
          event!.date!.toDate().year, event!.date!.toDate().month,
          event!.date!.toDate().day);
      selectedTime = TimeOfDay(hour: event!.date!.toDate().hour,
        minute: event!.date!.toDate().minute,);
      //provider.userlocation=LatLng(event!.lat!, event!.lng!) ;
    }
  }

  int selected = 0;

  Widget build(BuildContext context) {
    LocationProvider provider = Provider.of(context);
    if (event != null) {
      provider.userlocation = LatLng(event!.lat!, event!.lng!);
    }
    createnewevent() async {
      if (formkey.currentState!.validate()) {
        if (selectedDate != null && selectedTime != null) {
          DateTime eventdate = DateTime(
              selectedDate!.year, selectedDate!.month, selectedDate!.day,
              selectedTime!.hour, selectedTime!.minute);
          DialogUtils.showLoadingDialog(context);
          Navigator.pop(context);

          await FireStoreHandler.createevent(Event(title: controlertitle.text,

              description: controlerdesc.text,
              date: Timestamp.fromDate(eventdate),
              userId: FirebaseAuth.instance.currentUser!.uid,
              category: getscreencat(),
              lat: provider.userlocation!.latitude,
              lng: provider.userlocation!.longitude

          ));
        }
        else {
          DialogUtils.showtoast(StringsManager.enter.tr());
        }
      }
    }
    Future<void> updateEvent(BuildContext context) {
      event!.title = controlertitle.text;
      event!.description = controlerdesc.text;
      event!.category = getscreencat();
      event!.lat = provider.userlocation!.latitude;
      event!.lng = provider.userlocation!.longitude;
      return FireStoreHandler.updateEvent(event!);
    }

    double height = MediaQuery
        .of(context)
        .size
        .height;


    return Scaffold(
      appBar: AppBar(
        title: Text(event == null ? StringsManager.createevent.tr() : StringsManager.editevent.tr()),
      ),
      body: DefaultTabController(length: 3,
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Form(
              key: formkey,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: height * 0.25,
                      child: TabBarView(children:
                      [ClipRRect
                        (borderRadius: BorderRadius.circular(16),
                          child: Image.asset(AssetManager.eventphoto2,
                            height: height * 0.25, fit: BoxFit.cover,)),
                        ClipRRect(
                            borderRadius: BorderRadius.circular(16),

                            child: Image.asset(AssetManager.eventphoto3,
                              height: height * 0.25, fit: BoxFit.cover,)),
                        ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                            child: Image.asset(AssetManager.eventphoto1,
                              height: height * 0.25, fit: BoxFit.cover,))
                      ]),
                    ),
                    SizedBox(height: 16,),
                    TabBar(onTap: (index) {
                      selected = index;
                      setState(() {

                      });
                    },

                        indicator: BoxDecoration(
                            color: ColorsManager.primary_light,
                            borderRadius: BorderRadius.circular(46)),
                        isScrollable: true,
                        tabAlignment: TabAlignment.start,
                        dividerHeight: 0,
                        tabs: [
                          Tab(child: Container(
                            padding: EdgeInsets.symmetric(horizontal: 10,
                                vertical: 10),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: Colors.white
                                ),
                                borderRadius: BorderRadius.circular(46)
                            ),
                            child: Row(children: [
                              SvgPicture.asset(AssetManager.bookicon,
                                height: 24,
                                width: 24,
                                colorFilter: ColorFilter.mode(
                                    selected == 0 ? Colors.white : ColorsManager
                                        .primary_light,
                                    BlendMode.srcIn
                                ),
                              ),
                              SizedBox(width: 5,),
                              Text(StringsManager.book.tr(), style: TextStyle(fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: selected == 0 ? Colors.white : Theme
                                    .of(context)
                                    .colorScheme
                                    .primary,)),

                            ],),
                          ),

                          ),
                          Tab(child: Container(decoration: BoxDecoration(
                              border: Border.all(color: Colors.white),
                              borderRadius: BorderRadius.circular(46)
                          ),
                            padding: EdgeInsets.symmetric(horizontal: 10,
                                vertical: 10),
                            child: Row(children: [
                              SvgPicture.asset(AssetManager.sportstab,
                                height: 24,
                                width: 24,
                                colorFilter: ColorFilter.mode(
                                    selected == 1 ? Colors.white : ColorsManager
                                        .primary_light,
                                    BlendMode.srcIn
                                ),

                              ),
                              SizedBox(width: 5,),
                              Text(StringsManager.sport.tr(), style: TextStyle(fontSize: 16,
                                fontWeight: FontWeight.w700,
                                color: selected == 1 ? Colors.white : Theme
                                    .of(context)
                                    .colorScheme
                                    .primary,)),

                            ],),
                          ),),
                          Tab(
                            child: Container(decoration: BoxDecoration(
                                border: Border.all(
                                  color: Colors.white,
                                ),
                                borderRadius: BorderRadius.circular(46)
                            ),
                              padding: EdgeInsets.symmetric(horizontal: 10,
                                  vertical: 10),

                              child: Row(children: [
                                SvgPicture.asset(AssetManager.caketab,
                                  height: 24,
                                  width: 24,
                                  colorFilter: ColorFilter.mode(
                                      selected == 2
                                          ? Colors.white
                                          : ColorsManager.primary_light,
                                      BlendMode.srcIn
                                  ),
                                ),
                                SizedBox(width: 5,),
                                Text(StringsManager.birthday.tr(), style: TextStyle(fontSize: 16,
                                  fontWeight: FontWeight.w700,
                                  color: selected == 2 ? Colors.white : Theme
                                      .of(context)
                                      .colorScheme
                                      .primary,)),

                              ],),
                            ),
                          ),

                        ]),
                    SizedBox(height: 16,)
                    ,
                    Text(StringsManager.title.tr(), style: TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 16),),
                    SizedBox(height: 8,),
                    CustomField(hinttext: StringsManager.eventtitle.tr(),
                        prifex: AssetManager.titleicon,
                        controller: controlertitle,
                        keyboard: TextInputType.text,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return StringsManager.required.tr();
                          }
                          return null;
                        }),
                    SizedBox(height: 16,),
                    Text(StringsManager.descr.tr(), style: TextStyle(
                        fontWeight: FontWeight.w500, fontSize: 16),),
                    SizedBox(height: 8,),
                    CustomField(hinttext:StringsManager.descrtext.tr() ,
                        maxlines: 5,
                        prifex: null,
                        controller: controlerdesc,
                        keyboard: TextInputType.multiline,
                        validator: (value) {
                          if (value == null || value.isEmpty) {
                            return StringsManager.required.tr();
                          }
                          return null;
                        }
                    ),
                    SizedBox(height: 16,),
                    Row(
                      children: [
                        Icon(Icons.calendar_month),
                        SizedBox(width: 5,),
                        Text(StringsManager.eventdate.tr(), style: TextStyle(fontSize: 16),),
                        Spacer(),
                        TextButton(onPressed: () {
                          ChooseEventDate();
                        },
                          child: Text(selectedDate == null && event == null
                              ? StringsManager.chosedate.tr()
                              : selectedDate == null ? DateTime
                              .fromMillisecondsSinceEpoch(
                              event!.date?.millisecondsSinceEpoch ?? 0)
                              .toString() : "${selectedDate!
                              .day}/${selectedDate!.month}/${selectedDate!
                              .year}", style: TextStyle(
                              fontSize: 16), overflow: TextOverflow.ellipsis,),)

                      ],
                    ),
                    Row(
                      children: [
                        Icon(Icons.access_time),
                        SizedBox(width: 5,),
                        Text(StringsManager.editt.tr(), style: TextStyle(fontSize: 16),),
                        Spacer(),
                        TextButton(onPressed: () {
                          ChooseEventTime();
                        },
                          child: Text(selectedTime == null ? StringsManager.choset.tr()
                              : "${selectedTime!.hourOfPeriod}:${selectedTime!
                              .minute}${selectedTime!.period.name}",
                            style: TextStyle(fontSize: 16),),)

                      ],
                    ),
                    ElevatedButton(
                        onPressed: () {
                          Navigator.pushNamed(context, PickMapScreen.routeName);
                        }, style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        padding: EdgeInsets.all(8),
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(16),
                            side: BorderSide(
                                color: ColorsManager.primary_light
                            )
                        )
                    )
                        , child: Row(
                      children: [
                        Container(
                          decoration: BoxDecoration(
                              color: ColorsManager.primary_light,
                              borderRadius: BorderRadius.circular(8)
                          ),
                          child: Padding(
                            padding: const EdgeInsets.all(12),
                            child: Icon(
                              Icons.location_searching, color: Colors.white,),
                          ),
                        ),
                        SizedBox(height: 8,),
                        Expanded(
                          child: Text(provider.userlocation == null ?
                          StringsManager.choseel.tr() : "${provider.userlocation!
                              .latitude.toString()},${provider.userlocation!
                              .longitude.toString()}",
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(fontSize: 16,
                                color: ColorsManager.primary_light),),
                        ),
                        Icon(Icons.arrow_forward_ios)

                      ],
                    )
                    ),
                    SizedBox(height: 16,),
                    Container(width: double.infinity,
                        child: CustomBtn(
                            label: event != null ? StringsManager.createevent.tr() : StringsManager.editevent.tr(),
                            onpressed: () {
                              if (event != null) {
                                updateEvent(context);
                              }
                              else {
                                createnewevent();
                              }
                              Navigator.pop(context);
                            }))


                  ],
                ),
              ),
            ),
          )),
    );
  }

  DateTime? selectedDate;

  ChooseEventDate() async {
    DateTime? temp = await showDatePicker(context: context,
        firstDate: DateTime.now(),
        initialDate: selectedDate,
        lastDate: DateTime.now().add(Duration(days: 365)));
    if (temp != null) {
      selectedDate = temp;
      setState(() {

      });
    }
  }

  String getscreencat() {
    if (selected == 0) {
      return bookcat;
    }
    else if (selected == 1) {
      return sportcat;
    }
    else {
      return birthdaycat;
    }
  }


  TimeOfDay? selectedTime;

  ChooseEventTime() async {
    TimeOfDay? temptime = await showTimePicker(context: context,
        initialTime: selectedTime == null ? TimeOfDay.now() : selectedTime!);
    if (temptime != null) {
      selectedTime = temptime;
      setState(() {});
    }
  }
}







