import 'package:eventlyapp/core/FireStoreHandler.dart';
import 'package:eventlyapp/model/User.dart'as myuser;
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/foundation.dart';

class UserProvider extends ChangeNotifier{
  bool isLoading=false;
  myuser.User? user;
   Future<void> getUser()async{
    isLoading=true;
    notifyListeners();
    user=await FireStoreHandler.getUser(FirebaseAuth.instance.currentUser!.uid);
    print(FirebaseAuth.instance.currentUser!.uid);
    print(user?.favorites);
    isLoading=false;
    notifyListeners();
  }
}