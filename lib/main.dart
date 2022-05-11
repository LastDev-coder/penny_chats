import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:penny_chats/controllers/Api/AuthServices/Authenticate.dart';
import 'NotificationService/LocalNotificationService.dart';
import 'package:firebase_core/firebase_core.dart';


// Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
//   // If you're going to use other Firebase services in the background, such as Firestore,
//   // make sure you call `initializeApp` before using other Firebase services.
//   // await Firebase.initializeApp();
//
//   print("Handling a background message: ${message.messageId}");
// }
//
//
//
// void main() async{
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//
//   NotificationSettings settings = await FirebaseMessaging.instance.requestPermission(
//     alert: true,
//     announcement: false,
//     badge: true,
//     carPlay: false,
//     criticalAlert: false,
//     provisional: false,
//     sound: true,
//   );
//   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//     print('Got a message whilst in the foreground!');
//     print('Message data: ${message.data}');
//
//     if (message.notification != null) {
//       print('Message also contained a notification: ${message.notification}');
//     }
//   });
//
//   print('User granted permission: ${settings.authorizationStatus}');
//   final fcmToken = await FirebaseMessaging.instance.getToken();
//
//   // FirebaseInstanceId.getInstance().getToken('old-sender-id', FirebaseMessaging.INSTANCE_ID_SCOPE)
// print('FCM Token -> $fcmToken');
//
//
//   final  appInstanceId = await FirebaseInstanceId.appInstanceId ?? 'Unknown instance Id';
//
//   print('*********************** $appInstanceId');
//
//   FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
//   // LocalNotificationService.initialize();
//   runApp(MyApp());
// }

// void main() async{
//   WidgetsFlutterBinding.ensureInitialized();
//   await Firebase.initializeApp();
//
//   FirebaseMessaging message =  FirebaseMessaging.instance;
//   message = FirebaseMessaging.instance;
//   message.getToken().then((value){
//     print(value);
//   });
//
//   NotificationSettings settings = await message.requestPermission(
//     alert: true,
//     announcement: false,
//     badge: true,
//     carPlay: false,
//     criticalAlert: false,
//     provisional: false,
//     sound: true
//   );
//   print("User grand permission: ${settings.authorizationStatus}");
//   FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//     print("Got a new foreground message");
//     if(message!=null){
//       print('Message also contain a notification : ${message.data}');
//     }
//   });
//   FirebaseMessaging.onMessageOpenedApp.listen((message) {
//     print('Message clicked!');
//   });
//   runApp(MyApp());
// }



const AndroidNotificationChannel channel = AndroidNotificationChannel(
    'high_importance_channel', // id
    'High Importance Notifications', // title
    // 'This channel is used for important notifications.', // description
    importance: Importance.high,
    playSound: true,
    sound: RawResourceAndroidNotificationSound("sound3"));
Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  // If you're going to use other Firebase services in the background, such as Firestore,
  // make sure you call `initializeApp` before using other Firebase servic

  // await Firebase.initializeApp();
  print('Handling a background message ${message.messageId}');
  print('Handling a background message $message');
  try {
    final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
    FlutterLocalNotificationsPlugin();
    const AndroidInitializationSettings initializationSettingsAndroid =
    AndroidInitializationSettings('@mipmap/ic_launcher');

    final IOSInitializationSettings initializationSettingsIOS =
    IOSInitializationSettings(
      requestSoundPermission: false,
      requestBadgePermission: false,
      requestAlertPermission: false,
    );
    final InitializationSettings initializationSettings =
    InitializationSettings(
        android: initializationSettingsAndroid,
        iOS: initializationSettingsIOS);
    await flutterLocalNotificationsPlugin.initialize(initializationSettings);
    var androidDetails = AndroidNotificationDetails(
      "12345",
      "flutterfcm",
      // "flutterfcm",
      importance: Importance.max,
      priority: Priority.high,
      autoCancel: false,
      sound: RawResourceAndroidNotificationSound("sound3"),
      playSound: true,
    );
    var iosDetails = IOSNotificationDetails();

    var generateNotification =
    NotificationDetails(android: androidDetails, iOS: iosDetails);
    // print("--------------");
    // final player = AudioPlayer();
    // await player.setAsset('assets/sound/sound3.wav').whenComplete(() {
    //   player.play();
    // });
    //
    // print("--------------");

    flutterLocalNotificationsPlugin
        .show(
      DateTime.now().second + DateTime.now().minute + DateTime.now().hour,
      message.notification!.title,
      message.notification!.body,
      generateNotification,
      payload: 'Default_Sound',
    )
        .then((value) {
      // final player = AudioPlayer();
      // player.setAsset('assets/sound/sound3.wav').whenComplete(() {
      //   player.play();
      // });
    });
  } catch (e) {
    print(e);
  }
}
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
    final fcmToken = await FirebaseMessaging.instance.getToken();
print('FCM Token -> $fcmToken');
  print('-------------------------------------------------------------------------------');
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(MyApp(
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PennyChats',
      // theme: ThemeData(
      //   primarySwatch: Colors.blue,
      // ),
      home: Authenticate(),
    );
  }
}
