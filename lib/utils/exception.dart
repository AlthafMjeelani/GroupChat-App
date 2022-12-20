import 'package:chatapp/utils/snackbar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class FireBaseExceptionsHandler {
 static void authExceptions(FirebaseAuthException e) {
    switch (e.code) {
      case 'invalid-email':
        return SnackbarShow.showSnackbarItem(
          'The email address is Not correct format',
          Colors.red,
        );

      case 'weak-password':
        return SnackbarShow.showSnackbarItem(
          'Password should be at least 6 characterst',
          Colors.red,
        );

      case 'email-already-in-use':
        return SnackbarShow.showSnackbarItem(
          'The email address is already in use by another account',
          Colors.red,
        );

      default:
        return SnackbarShow.showSnackbarItem(
          'Invalid email or password ',
          Colors.red,
        );
    }
  }
}
