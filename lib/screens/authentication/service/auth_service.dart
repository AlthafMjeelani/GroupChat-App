import 'dart:developer';

import 'package:chatapp/screens/authentication/service/database_service.dart';
import 'package:chatapp/utils/exception.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;

//------------------------register---------------------//

  Future<bool> registerUserWithEmailandPassword(
      String fullname, String email, String password) async {
    try {
      User user = (await firebaseAuth.createUserWithEmailAndPassword(
              email: email, password: password))
          .user!;
      await DatabaseService(user.uid).updateUserData(fullname, email);
      log('success');
      return true;
    } on FirebaseAuthException catch (e) {
      FireBaseExceptionsHandler.authExceptions(e);
      log(e.toString());
      return false;
    }
  }

  Future<bool> userLogin(String email, String password) async {
    try {
      log('service called');
      await firebaseAuth.signInWithEmailAndPassword(
          email: email, password: password);
      log('success');
      return true;
    } on FirebaseAuthException catch (e) {
      FireBaseExceptionsHandler.authExceptions(e);
      log(e.toString());
      return false;
    }
  }

  Future<bool> logout() async {
    try {
      log('service called');
      await firebaseAuth.signOut();
      log('success');
      return true;
    } on FirebaseAuthException catch (e) {
      FireBaseExceptionsHandler.authExceptions(e);
      log(e.toString());
      return false;
    }
  }
}
