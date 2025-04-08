import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:eventlyapp/model/EventModel.dart';
import 'package:eventlyapp/model/User.dart';

class  FireStoreHandler{
  static CollectionReference<User> getusercollection(){
    var collectionRefrence= FirebaseFirestore.instance.collection("user").
    withConverter(fromFirestore:(
        snapshot,options) {
      Map<String,dynamic>?data=snapshot.data();
      return User.fromFireStore(data);
    },
        toFirestore: (user,options){
          return user.toFireStore();
        }
        );
    return collectionRefrence;


  }
  static Future<void> AddUser(User user){
var collection=getusercollection();
var document=collection.doc(user.id);
return document.set(user);
  }
  static Future<User?> getUser(String uId)async{
    var collection =getusercollection();
    var document=collection.doc(uId);
    var snapshot=await document.get();
    return snapshot.data();
  }
  static  CollectionReference<Event>geteventcollection(){
    var collection=FirebaseFirestore.instance.collection("event").withConverter(fromFirestore: (snapshot,options){
      var data=snapshot.data();
      return Event.fromFireStore(data);
    }, toFirestore: (event,options){
      return event.toFireStore();
    });
    return collection;
  }
 static Future<void> createevent(Event event)async {
    var collection=geteventcollection();
    var doc =collection.doc();
    event.id=doc.id;
    doc.set(event);
  }
  static Future<List<Event>> getAllEvents()async{
    var collection=geteventcollection();
     var querysnapshot= await collection.get();
    var doclist= querysnapshot.docs;
    var eventlist=doclist.map((doc)=>doc.data()).toList();
    return eventlist;
  }
  static Stream<List<Event>>GetAllEventsStream()async*{
    var collection=geteventcollection();
    var snapshots=collection.snapshots();
    Stream<List<Event>> eventstreem=snapshots.map((snapshot)=>
        snapshot.docs.map((doc)=>doc.data()).toList());
    yield* eventstreem;

  }
  static  Stream<List<Event>> GetCategoryEventsStream(String category)async*{
    var collection=geteventcollection().where("category",isEqualTo: category);
    var alleventsstreem=collection.snapshots();
    Stream<List<Event>>eventstreem=alleventsstreem.map((snapshot)=>
        snapshot.docs.map((doc)=>doc.data()).toList());
    yield* eventstreem;

  }
  static Future<List<Event>> getCategoryEvents(String category)async{
    var collection=geteventcollection().where("category",isEqualTo:category);
    var querysnapshot= await collection.get();
    var doclist= querysnapshot.docs;
    var eventlist=doclist.map((doc)=>doc.data()).toList();
    return eventlist;
  }
  static CollectionReference<Event> GetWishListCollection(String uid){
    var collection=getusercollection().doc(uid).collection("favorites").withConverter(fromFirestore:
        (snapshot,options){
      var data=snapshot.data();
      return Event.fromFireStore(data);
    }, toFirestore: (event,options){
      return event.toFireStore();
    });
    return collection;


  }
  static Future<void> addToFavorite(String uid,Event event){
    var collection=GetWishListCollection(uid);
    var doc=collection.doc(event.id);
    return doc.set(event);
  }
  static Future<void> removeFromFav(String uid,String eventid){
    var collection=GetWishListCollection(uid);
     return collection.doc(eventid).delete();
  }
  static Future<List<Event>> getmywishlist(String uid)async{
    var collection=GetWishListCollection(uid);
    var quereysnapshot=await collection.get();
    var doclist=quereysnapshot.docs;
    var eventlist=doclist.map((doc)=>doc.data()).toList();
    return eventlist;

  }
  static Stream<List<Event>>getmywishlistStream(String uid)async*{
    var collection=GetWishListCollection(uid);
   var querysnapshots= collection.snapshots();
    Stream<List<Event>> faveventsStream=querysnapshots.map(
            (snapshot)=>snapshot.docs.map((doc)=>doc.data()).toList());
    yield* faveventsStream;
  }
static Future<void> updateUserFaves(String uid,List<String>newfavs)async {
    var collection=getusercollection();
        var document=collection.doc(uid);
        document.update({
          "favorites":newfavs
        });
}
static Future<void>deleteEvent(String id)async{
    var event=geteventcollection() ;
     await event.doc(id).delete();
}
static Future <void>updateEvent(Event event)async{
    // geteventcollection();FirebaseFirestore.instance.collection("events");
     await geteventcollection().doc(event.id).update(event.toFireStore());
}

}
