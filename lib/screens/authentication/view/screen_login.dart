import 'dart:developer';
import 'package:chatapp/helpers/color/constent_color.dart';
import 'package:chatapp/helpers/spacing/constent_spacing.dart';
import 'package:chatapp/screens/authentication/controller/auth_controller.dart';
import 'package:chatapp/widgets/textform_feild_widget.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get_state_manager/get_state_manager.dart';
import 'package:get/instance_manager.dart';

class ScreenLogIn extends StatelessWidget {
  ScreenLogIn({super.key});
  final formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    final AuthController controller = Get.put(AuthController());
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Theme.of(context).primaryColor,
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(
              horizontal: 20,
              vertical: 40,
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
                    'Login now to see what they are talking!',
                    style: TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                  Container(
                    height: 250,
                    decoration: const BoxDecoration(
                      image: DecorationImage(
                          image: AssetImage('lib/assets/login.png'),
                          fit: BoxFit.fill),
                    ),
                  ),
                  TextFormFieldWidget(
                    controller: controller.logEmailController,
                    validator: (value) => controller.emailValidation(value),
                    text: 'Email',
                    prifixIcon: Icons.email,
                  ),
                  ConstentSpacing.kSizedbox10,
                  TextFormFieldWidget(
                    controller: controller.logpasswordController,
                    validator: (value) => controller.passValidator(
                        value, "Please Enter some Text"),
                    text: 'Password',
                    prifixIcon: Icons.lock,
                  ),
                  ConstentSpacing.kSizedbox20,
                  Obx(
                    () => controller.isLoading.value
                        ? const CircularProgressIndicator()
                        : SizedBox(
                            width: double.infinity,
                            child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                    backgroundColor: ConstentColor.primeryColor,
                                    elevation: 0,
                                    shape: RoundedRectangleBorder(
                                        borderRadius:
                                            BorderRadius.circular(30))),
                                onPressed: () {
                                  if (formKey.currentState!.validate()) {
                                    controller.userLogin(
                                      controller.logEmailController.text,
                                      controller.logpasswordController.text,
                                    );
                                  } else {
                                    log('faild');
                                  }
                                },
                                child: const Text('Sign in')),
                          ),
                  ),
                  ConstentSpacing.kSizedbox20,
                  RichText(
                    text: TextSpan(
                        text: "Don't have an account? ",
                        style: const TextStyle(
                          color: Colors.black,
                          fontSize: 14,
                        ),
                        children: [
                          TextSpan(
                              text: 'Register here',
                              style: const TextStyle(
                                color: ConstentColor.primeryColor,
                                decoration: TextDecoration.underline,
                              ),
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  controller.toRegister();
                                })
                        ]),
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
