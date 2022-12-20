import 'dart:developer';

import 'package:chatapp/helpers/color/constent_color.dart';
import 'package:chatapp/screens/authentication/controller/auth_controller.dart';
import 'package:chatapp/screens/chat/controller/chat_controller.dart';
import 'package:chatapp/screens/chat/view/screen_chat.dart';
import 'package:chatapp/screens/home/controller/home_controller.dart';
import 'package:chatapp/screens/home/widget/grouplist_tile_widget.dart';
import 'package:chatapp/utils/alert_dialoagewidget.dart';
import 'package:chatapp/utils/snackbar.dart';
import 'package:chatapp/widgets/drawer_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenHome extends StatelessWidget {
  ScreenHome({super.key});
  final AuthController controller = Get.put(AuthController());
  final HomeController homeController = Get.put(HomeController());
  final ChatController chatController = Get.put(ChatController());
  @override
  Widget build(BuildContext context) {
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      chatController.getuserFullname();
    });
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
                                chatController.userName,
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
        body: StreamBuilder(
          stream: homeController.groups,
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasData) {
              log("has data in snapshot");
              if (snapshot.data['groups'] != null) {
                log(snapshot.data['groups'].toString());
                if (snapshot.data['groups'].length != 0) {
                  return ListView.builder(
                    itemCount: snapshot.data["groups"].length,
                    itemBuilder: (context, index) {
                      return GestureDetector(
                        onTap: () {
                          Get.to(
                            () => ScreenChat(
                              groupId: homeController
                                  .getId(snapshot.data["groups"][index]),
                              groupName: homeController
                                  .getName(snapshot.data["groups"][index]),
                              userName: snapshot.data["fullname"],
                            ),
                          );
                        },
                        child: GroupListtileWidget(
                          homeController: homeController,
                          snapshot: snapshot,
                          index: index,
                        ),
                      );
                    },
                  );
                } else {
                  return const Center(
                    child: Text('No Groups'),
                  );
                }
              } else {
                return const Center(
                  child: Text('No Groups'),
                );
              }
            } else {
              return Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
