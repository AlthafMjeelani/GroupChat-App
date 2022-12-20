import 'dart:developer';

import 'package:chatapp/utils/snackbar.dart';
import 'package:chatapp/screens/home/service/home_service.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class HomeController extends GetxController {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  final TextEditingController newGroupController = TextEditingController();
  Stream? groups;
  RxBool isLoading = false.obs;
  String userName = "";

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

  groupList() {
    return StreamBuilder(
      stream: groups,
      builder: (context, AsyncSnapshot snapshot) {
        if (snapshot.hasData) {
          if (snapshot.data['groups'] != null) {
            if ((snapshot.data['groups'] as List).isNotEmpty) {
              return const Text('kjhfdkjhfjkdh');
            } else {
              return const Center(
                child: Text('No Groups'),
              );
            }
          } else {
            return const Center(
              child: Text('No Groups'),
            );
          }
        } else {
          return Center(
            child: CircularProgressIndicator(
              color: Theme.of(context).primaryColor,
            ),
          );
        }
      },
    );
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
