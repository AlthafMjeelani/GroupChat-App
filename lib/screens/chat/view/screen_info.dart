import 'package:flutter/material.dart';

class ScreenGroupInfo extends StatelessWidget {
  const ScreenGroupInfo(
      {super.key,
      required this.groupId,
      required this.groupName,
      required this.adminName});

  final String groupId;
  final String groupName;
  final String adminName;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text("info"),
        centerTitle: true,
      ),
      body: Center(
        child: Text(adminName),
      ),
    );
  }
}
