import 'dart:developer';
import 'package:chatapp/utils/snackbar.dart';
import 'package:chatapp/screens/authentication/service/database_service.dart';
import 'package:chatapp/screens/authentication/view/screen_login.dart';
import 'package:chatapp/screens/home/view/screen_home.dart';
import 'package:email_validator/email_validator.dart';
import 'package:chatapp/screens/authentication/service/auth_service.dart';
import 'package:chatapp/screens/authentication/view/screen_register.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/route_manager.dart';

class AuthController extends GetxController {
  final TextEditingController nameController = TextEditingController();
  final TextEditingController regEmailController = TextEditingController();
  final TextEditingController regpasswordController = TextEditingController();
  final TextEditingController logEmailController = TextEditingController();
  final TextEditingController logpasswordController = TextEditingController();
  RxBool isLoading = false.obs;
  final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
  void toRegister() {
    Get.to(() => ScreenRegister());
  }

  String? passValidator(String? value, String text) {
    if (value == null || value.isEmpty) {
      return text;
    }
    if (value.length < 6) {
      return 'Please Enter Minimum 6 Cheracter';
    }
    return null;
  }

  String? emailValidation(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please Enter Email ';
    }
    return EmailValidator.validate(value.toString())
        ? null
        : "Please enter a valid email";
  }

  String? validatorFeild(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter a name';
    }
    return null;
  }

  void userRegister(fullname, email, password) async {
    log('called Controller');
    isLoading.value = true;
    await AuthService()
        .registerUserWithEmailandPassword(fullname, email, password)
        .then((value) {
      if (value == true) {
        SnackbarShow.showSnackbarItem("Success", Colors.green);
        Get.to(() => ScreenHome());
      }
    });
    isLoading.value = false;
  }

  void userLogin(email, password) async {
    log('called Controller');
    isLoading.value = true;
    await AuthService().userLogin(email, password).then((value) async {
      if (value == true) {
        await DatabaseService(firebaseAuth.currentUser!.uid)
            .gettingUserData(email);
        SnackbarShow.showSnackbarItem("Logged Successfully", Colors.green);
        Get.to(() => ScreenHome());
      }
    });
    isLoading.value = false;
  }

  void logout() async {
    log('called Controller');
    isLoading.value = true;
    await AuthService().logout().then((value) {
      if (value == true) {
        SnackbarShow.showSnackbarItem("Logouted", Colors.green);
        Get.offAll(() => ScreenLogIn());
      }
    });
    isLoading.value = false;
  }
}
