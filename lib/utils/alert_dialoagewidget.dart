import 'package:chatapp/helpers/color/constent_color.dart';
import 'package:chatapp/screens/home/controller/home_controller.dart';
import 'package:chatapp/widgets/textform_feild_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';

class AlertDialogeWidget extends StatelessWidget {
  const AlertDialogeWidget({
    Key? key,
    this.headingText,
    this.texfeaildText,
    this.onPressed,
    this.controller,
    this.validator,
  }) : super(key: key);

  final String? headingText;
  final String? texfeaildText;
  final void Function()? onPressed;
  final TextEditingController? controller;
  final String? Function(String?)? validator;

  @override
  Widget build(BuildContext context) {
    
    return AlertDialog(
      title: Text(headingText ?? ""),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          TextFormFieldWidget(
            validator: validator,
            controller: controller,
            text: texfeaildText,
            prifixIcon: Icons.group,
          ),
        ],
      ),
      actions: [
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: ConstentColor.primeryColor,
          ),
          onPressed: () {
            Get.back();
          },
          child: const Text('CANCEL'),
        ),
        ElevatedButton(
          style: ElevatedButton.styleFrom(
            backgroundColor: ConstentColor.primeryColor,
          ),
          onPressed: onPressed,
          child: const Text('CREATE'),
        ),
      ],
    );
  }
}
