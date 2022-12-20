import 'dart:developer';
import 'package:chatapp/screens/home/service/home_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class HomeController extends GetxController {
  HomeController() {
    getUserData();
  }
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final TextEditingController newGroupController = TextEditingController();
  Stream? groups;
  RxBool isLoading = false.obs;

    final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");


  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a name';
    }
    return null;
  }

// get  user data

  void getUserData() async {
    await HomeDatabaseService(firebaseAuth.currentUser!.uid)
        .getUserGroups()
        .then((snapshot) {
      log("replaced to groups");
      groups = snapshot;
      update();
    });
  }


// --------------------String manipulation------------//

//get Id
String getId(String res){
  return res.substring(0,res.indexOf("_"));
}

 //get groupName

 String getName(String res){
  return res.substring(res.indexOf("_")+1);

}
  //---------------Create groups---------------------//

  void createGroups(String userName, String id, String groupName) async {
    isLoading.value = true;
    await HomeDatabaseService(firebaseAuth.currentUser!.uid)
        .createGroups(userName, id, groupName);
    newGroupController.clear();
    isLoading.value = false;
    update();
  }
}
