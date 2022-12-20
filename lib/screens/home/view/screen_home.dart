import 'package:chatapp/helpers/color/constent_color.dart';
import 'package:chatapp/screens/authentication/controller/auth_controller.dart';
import 'package:chatapp/screens/home/controller/home_controller.dart';
import 'package:chatapp/utils/alert_dialoagewidget.dart';
import 'package:chatapp/utils/snackbar.dart';
import 'package:chatapp/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenHome extends StatelessWidget {
  ScreenHome({super.key});
  final AuthController controller = Get.put(AuthController());
  final HomeController homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
  
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ConstentColor.primeryColor,
          title: const Text(
            'Groups',
            style: TextStyle(
              fontSize: 27,
              fontWeight: FontWeight.bold,
            ),
          ),
          actions: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.search),
            ),
          ],
          centerTitle: true,
        ),
        drawer: DrawerWidget(
          controller: controller,
          selected1: true,
          selected2: false,
          selected3: false,
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Get.dialog(
              Obx(
                () {
                  return homeController.isLoading.value
                      ? const Center(
                          child: CircularProgressIndicator(),
                        )
                      : AlertDialogeWidget(
                          controller: homeController.newGroupController,
                          validator: (value) => homeController.validator(value),
                          headingText: 'Create a Group',
                          texfeaildText: "Enter group name",
                          onPressed: () {
                            homeController.createGroups(
                                homeController.userName,
                                homeController.firebaseAuth.currentUser!.uid,
                                homeController.newGroupController.text);
                            Get.back();
                            SnackbarShow.showSnackbarItem(
                                "Group created successfully", Colors.green);
                          },
                        );
                },
              ),
            );
          },
          elevation: 0,
          backgroundColor: Theme.of(context).primaryColor,
          child: const Icon(Icons.add, size: 32, color: Colors.white),
        ),
        body: homeController.groupList(),
      ),
    );
  }
}
