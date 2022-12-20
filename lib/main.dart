import 'package:chatapp/core/firebase_constents.dart';
import 'package:chatapp/helpers/color/constent_color.dart';
import 'package:chatapp/screens/authentication/view/screen_login.dart';
import 'package:chatapp/screens/home/view/screen_home.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:get/route_manager.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
        options: const FirebaseOptions(
      apiKey: FirebaseConstents.apiKey,
      appId: FirebaseConstents.appId,
      messagingSenderId: FirebaseConstents.messagingCenterId,
      projectId: FirebaseConstents.projuctId,
    ));
  } else {
    await Firebase.initializeApp();
  }

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primaryColor: ConstentColor.primeryColor,
        scaffoldBackgroundColor: Colors.white
      ),
      home:  ScreenHome(),
    );
  }
}
