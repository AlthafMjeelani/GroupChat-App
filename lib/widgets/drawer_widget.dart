import 'package:chatapp/helpers/spacing/constent_spacing.dart';
import 'package:chatapp/screens/authentication/controller/auth_controller.dart';
import 'package:chatapp/screens/home/view/screen_groups.dart';
import 'package:chatapp/screens/home/view/screen_home.dart';
import 'package:chatapp/screens/home/view/screen_profile.dart';
import 'package:chatapp/widgets/drawer_tile_widget.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class DrawerWidget extends StatelessWidget {
  const DrawerWidget({
    Key? key,
    required this.controller,
    required this.selected1,
    required this.selected2,
    required this.selected3,
  }) : super(key: key);

  final AuthController controller;
  final bool selected1;
  final bool selected2;

  final bool selected3;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 50),
        children: [
          Icon(
            Icons.account_circle,
            size: 150,
            color: Colors.grey[700],
          ),
          ConstentSpacing.kSizedbox15,
          Text(
            controller.firebaseAuth.currentUser!.email!,
            textAlign: TextAlign.center,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
            ),
          ),
          ConstentSpacing.kSizedbox30,
          const Divider(
            thickness: 2,
          ),
          DrawerTileWidget(
            selected: selected1,
            text: "Groups",
            iconData: Icons.groups,
            onTap: () {
              Get.off(()=> ScreenHome());
            },
          ),
          DrawerTileWidget(
            selected: selected2,
            text: "Profile",
            iconData: Icons.person,
            onTap: () {
              Get.off(() => const ScreenProfile());
            },
          ),
          DrawerTileWidget(
            selected: selected3,
            text: "Logout",
            iconData: Icons.logout,
            onTap: () {
              Get.defaultDialog(
                title: 'Logout',
                textCancel: 'No',
                textConfirm: "Yes",
                middleText: 'Are you confirm to delete?',
                onConfirm: () {
                  controller.logout();
                },
                onCancel: () {
                  Get.back();
                },
              );
            },
          ),
        ],
      ),
    );
  }
}
