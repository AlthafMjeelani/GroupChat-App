import 'package:chatapp/screens/chat/controller/chat_controller.dart';
import 'package:chatapp/screens/chat/view/screen_info.dart';
import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:get/get_instance/src/extension_instance.dart';

class ScreenChat extends StatelessWidget {
  const ScreenChat(
      {super.key,
      required this.groupId,
      required this.groupName,
      required this.userName});
  final String groupId;
  final String groupName;
  final String userName;

  @override
  Widget build(BuildContext context) {
    final ChatController chatController = Get.put(ChatController());
    WidgetsBinding.instance.addPostFrameCallback((timeStamp) {
      chatController.getChatAndAdmin(groupId);
    });
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Theme.of(context).primaryColor,
        title: Text(groupName),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () {
              Get.to(
                () => ScreenGroupInfo(
                    groupId: groupId,
                    groupName: groupName,
                    adminName: chatController.userName),
              );
            },
            icon: const Icon(
              Icons.info_outline,
            ),
          ),
        ],
      ),
      body: Center(
        child: Text(groupName),
      ),
    );
  }
}
