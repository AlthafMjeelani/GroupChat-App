import 'package:cloud_firestore/cloud_firestore.dart';

class DatabaseService {
  final String uid;

  DatabaseService(this.uid);

  //reference for the collection

  final CollectionReference userCollection =
      FirebaseFirestore.instance.collection("users");

// upadete the user data
  Future<void> updateUserData(String name, String email) async {
    return await userCollection.doc(uid).set({
      "fullname": name,
      "email": email,
      "groups": [],
      "profilePic": '',
      "uid": uid,
    });
  }

  //getting user data-------------------
  Future<QuerySnapshot> gettingUserData(String email) async {
    QuerySnapshot snapshot =
        await userCollection.where('email', isEqualTo: email).get();

    return snapshot;
  }
}
