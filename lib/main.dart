import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:odc_game/constants/my_string.dart';
import 'package:odc_game/routes/routes.dart';
 import 'package:firebase_messaging/firebase_messaging.dart';

Future<void> firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase services.
  debugPrint("on ${message.notification!.body} message ");
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp();
  await GetStorage.init();

  var token = await FirebaseMessaging.instance.getToken();
  debugPrint(token.toString());
  await FirebaseMessaging.instance.getNotificationSettings();

  FirebaseMessaging messaging = FirebaseMessaging.instance;

  await messaging.requestPermission(
    alert: true,
    announcement: true,
    badge: true,
    carPlay: true,
    criticalAlert: true,
    provisional: true,
    sound: true,
  );
  FirebaseMessaging.onMessage.listen((message) {


  });
  FirebaseMessaging.onMessageOpenedApp.listen((event) {


  });
  FirebaseMessaging.onBackgroundMessage(firebaseMessagingBackgroundHandler);
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final GetStorage savedData = GetStorage();

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // Try running your application with "flutter run". You'll see the
        // application has a blue toolbar. Then, without quitting the app, try
        // changing the primarySwatch below to Colors.green and then invoke
        // "hot reload" (press "r" in the console where you ran "flutter run",
        // or simply save your changes to "hot reload" in a Flutter IDE).
        // Notice that the counter didn't reset back to zero; the application
        // is not restarted.
        primarySwatch: Colors.blue,
      ),
      getPages: Routes.routes,
      initialRoute:
          savedData.read(KUid) == null ? Routes.loginScreen : Routes.mainScreen,
    );
  }
}
