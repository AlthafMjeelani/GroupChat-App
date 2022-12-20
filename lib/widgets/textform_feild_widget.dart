import 'package:chatapp/helpers/color/constent_color.dart';
import 'package:flutter/material.dart';

class TextFormFieldWidget extends StatelessWidget {
  const TextFormFieldWidget({
    Key? key,
    this.text,
    this.prifixIcon,
    this.controller,
    this.validator,
  }) : super(key: key);
  final String? text;
  final IconData? prifixIcon;
  final TextEditingController? controller;
  final String? Function(String?)? validator;
  @override
  Widget build(BuildContext context) {
    return TextFormField(
      decoration: InputDecoration(
          labelStyle: const TextStyle(color: Colors.black),
          focusedBorder: const OutlineInputBorder(
              borderSide: BorderSide(color: Colors.blue, width: 2)),
          enabledBorder: const OutlineInputBorder(
              borderSide:
                  BorderSide(color: ConstentColor.primeryColor, width: 2)),
          errorBorder: const OutlineInputBorder(
              borderSide:
                  BorderSide(color: ConstentColor.primeryColor, width: 2)),
          labelText: text,
          prefixIcon: Icon(
            prifixIcon,
            color: ConstentColor.primeryColor,
          )),
      controller: controller,
      validator: validator,
    );
  }
}
