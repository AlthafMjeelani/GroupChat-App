import 'package:chatapp/helpers/color/constent_color.dart';
import 'package:chatapp/screens/home/controller/home_controller.dart';
import 'package:flutter/material.dart';

class GroupListtileWidget extends StatelessWidget {
  const GroupListtileWidget({
    Key? key,
    required this.homeController,
    required this.snapshot,
    required this.index,
  }) : super(key: key);

  final HomeController homeController;
  final AsyncSnapshot snapshot;
  final int index;

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: CircleAvatar(
        radius: 30,
        backgroundColor: Theme.of(context).primaryColor,
        child: Text(
          homeController
              .getName(snapshot.data["groups"][index])
              .substring(0, 1)
              .toUpperCase(),
          textAlign: TextAlign.center,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 25,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      title: Text(
        homeController.getName(snapshot.data["groups"][index]),
        style: const TextStyle(
          color: Colors.black,
          fontSize: 18,
          fontWeight: FontWeight.w500,
        ),
      ),
      subtitle: Text("Join the conversation as ${snapshot.data["fullname"]}"),
    );
  }
}
