import 'dart:developer';
import 'package:cloud_firestore/cloud_firestore.dart';

class HomeDatabaseService {
  final String uid;

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");

  final CollectionReference groupCollection =
      FirebaseFirestore.instance.collection("groups");

  HomeDatabaseService(this.uid);


  //get user Group

  Future<Stream?> getUserGroups() async {
    try {
      return userCollection.doc(uid).snapshots();
    } catch (e) {
      log(e.toString());
    }
    return null;
  }

  //Create user Group

  Future<void> createGroups(
      String userName, String id, String groupName) async {
    try {
      DocumentReference groupDocumentReference = await groupCollection.add(
        {
          "groupName": groupName,
          "groupIcon": "",
          "admin": "${id}_$userName",
          "members": [],
          "groupId": "",
          "recentMessage": "",
          "recentMessageSender": "",
        },
      );
// ------------------update the member of the group---------------------------------
      await groupDocumentReference.update(
        {
          "member": FieldValue.arrayUnion(["${uid}_$userName"]),
          "groupId": groupDocumentReference.id,
        },
      );

      DocumentReference userdocumentReference = userCollection.doc(uid);
      return await userdocumentReference.update(
        {
          "groups": FieldValue.arrayUnion(
            ["${groupDocumentReference.id}_$groupName"],
          ),
        },
      );
    } catch (e) {
      log(e.toString());
    }
  }

//-----------------geting the chat------------------//

 Future getChat(String groupId) async {
    return groupCollection
        .doc(groupId)
        .collection("messages")
        .orderBy("time")
        .snapshots();
  }

  Future getGroupAdmin(String groupId) async {
    DocumentReference documentReference = groupCollection.doc(groupId);
    DocumentSnapshot documentSnapshot = await documentReference.get();
    return documentSnapshot["admin"];
  }

    Future getFullname() async {
    DocumentReference userCollections = userCollection.doc(uid);
    DocumentSnapshot documentSnapshot = await userCollections.get();
    return documentSnapshot["fullname"];
  }



}
