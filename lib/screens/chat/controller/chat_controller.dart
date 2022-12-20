import 'package:chatapp/screens/home/service/home_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get_state_manager/get_state_manager.dart';

class ChatController extends GetxController {
  String admin = "";
  Stream<QuerySnapshot>? chats;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  String userName = "";

  // @override
  // void onInit() {

  //   getChatAndAdmin(groupId)
  //   super.onInit();

  // }

  void getChatAndAdmin(String groupId) {
    HomeDatabaseService(firebaseAuth.currentUser!.uid)
        .getChat(groupId)
        .then((value) {
      chats = value;
    });
    HomeDatabaseService(firebaseAuth.currentUser!.uid)
        .getGroupAdmin(groupId)
        .then((value) {
      admin = value;
    });
  }

  void getuserFullname() {
    HomeDatabaseService(firebaseAuth.currentUser!.uid)
        .getFullname()
        .then((value) {
      userName = value;
    });
  }
}
