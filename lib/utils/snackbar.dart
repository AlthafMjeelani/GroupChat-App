import 'package:flutter/material.dart';
import 'package:get/get.dart';

class SnackbarShow {
static  void showSnackbarItem(title,Color? backgroundColor){
    Get.snackbar(
  title,
  "",
  colorText: Colors.white,
  backgroundColor:backgroundColor,
);
  }
}