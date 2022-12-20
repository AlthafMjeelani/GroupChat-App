import 'dart:developer';

import 'package:chatapp/helpers/color/constent_color.dart';
import 'package:chatapp/helpers/spacing/constent_spacing.dart';
import 'package:chatapp/screens/authentication/controller/auth_controller.dart';
import 'package:chatapp/screens/authentication/view/screen_login.dart';
import 'package:chatapp/widgets/textform_feild_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';
import 'package:get/route_manager.dart';

class ScreenRegister extends StatelessWidget {
  ScreenRegister({super.key});
  final formKey = GlobalKey<FormState>();
  final AuthController controller = Get.put(AuthController());
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 10,
            ),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'Groupie',
                    style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
                  ),
                  ConstentSpacing.kSizedbox10,
                  const Text(
                    'Create your account now to chat and explore',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Container(
                    height: 250,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('lib/assets/register.png'),
                          fit: BoxFit.fill),
                    ),
                  ),
                  TextFormFieldWidget(
                    validator: (value) => controller.validatorFeild(value),
                    controller: controller.nameController,
                    text: 'Fullname',
                    prifixIcon: Icons.person,
                  ),
                  ConstentSpacing.kSizedbox10,
                  TextFormFieldWidget(
                    validator: (value) => controller.emailValidation(value),
                    controller: controller.regEmailController,
                    text: 'Email',
                    prifixIcon: Icons.email,
                  ),
                  ConstentSpacing.kSizedbox10,
                  TextFormFieldWidget(
                    validator: (value) => controller.passValidator(
                        value, 'Please enter password'),
                    controller: controller.regpasswordController,
                    text: 'Password',
                    prifixIcon: Icons.lock,
                  ),
                  ConstentSpacing.kSizedbox20,
                  Obx(
                    () {
                      return controller.isLoading.value
                          ? const CircularProgressIndicator()
                          : SizedBox(
                              width: double.infinity,
                              child: ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                      backgroundColor:
                                          ConstentColor.primeryColor,
                                      elevation: 0,
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(30))),
                                  onPressed: () {
                                    if (formKey.currentState!.validate()) {
                                      controller.userRegister(
                                        controller.nameController.text,
                                        controller.regEmailController.text,
                                        controller.regpasswordController.text,
                                      );
                                    } else {
                                      log('faild');
                                    }
                                  },
                                  child: const Text('Sign up')),
                            );
                    },
                  ),
                  ConstentSpacing.kSizedbox20,
                  RichText(
                    text: TextSpan(
                      text: "Already have an account? ",
                      style: const TextStyle(
                        color: Colors.black,
                        fontSize: 14,
                      ),
                      children: [
                        TextSpan(
                            text: 'Login here',
                            style: const TextStyle(
                              color: ConstentColor.primeryColor,
                              decoration: TextDecoration.underline,
                            ),
                            recognizer: TapGestureRecognizer()
                              ..onTap = () {
                                Get.offAll(() => ScreenLogIn());
                              })
                      ],
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
