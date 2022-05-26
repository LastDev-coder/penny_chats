import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:just_audio/just_audio.dart';
import 'package:penny_chats/controllers/Api/AuthServices/Authenticate.dart';

// Future<void> _messageHandler(RemoteMessage message) async {
//   print('background message ${message.notification!.body}');
//     print('Handling a background message ${message.messageId}');
//   print('Handling a background message $message');
//   try {
//     final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//     FlutterLocalNotificationsPlugin();
//     const AndroidInitializationSettings initializationSettingsAndroid =
//     AndroidInitializationSettings('@mipmap/ic_launcher');
//
//     final IOSInitializationSettings initializationSettingsIOS =
//     IOSInitializationSettings(
//       requestSoundPermission: false,
//       requestBadgePermission: false,
//       requestAlertPermission: false,
//     );
//     final InitializationSettings initializationSettings =
//     InitializationSettings(
//         android: initializationSettingsAndroid,
//         iOS: initializationSettingsIOS);
//     await flutterLocalNotificationsPlugin.initialize(initializationSettings);
//     var androidDetails = AndroidNotificationDetails(
//       "12345",
//       "flutterfcm",
//       // "flutterfcm",
//       importance: Importance.max,
//       priority: Priority.high,
//       autoCancel: false,
//       sound: RawResourceAndroidNotificationSound("sound3"),
//       playSound: true,
//     );
//     var iosDetails = IOSNotificationDetails();
//
//     var generateNotification =
//     NotificationDetails(android: androidDetails, iOS: iosDetails);
//     // print("--------------");
//     // final player = AudioPlayer();
//     // await player.setAsset('assets/sound/sound3.wav').whenComplete(() {
//     //   player.play();
//     // });
//     //
//     // print("--------------");
//
//     flutterLocalNotificationsPlugin
//         .show(
//       DateTime.now().second + DateTime.now().minute + DateTime.now().hour,
//       message.notification!.title,
//       message.notification!.body,
//       generateNotification,
//       payload: 'Default_Sound',
//     )
//         .then((value) {
//       // final player = AudioPlayer();
//       // player.setAsset('assets/sound/sound3.wav').whenComplete(() {
//       //   player.play();
//       // });
//     });
//   } catch (e) {
//     print(e);
//   }
// }
//
//
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   print("----------------------------------------");
//   await Firebase.initializeApp();
//   print("----------------------------------------");
//   FirebaseMessaging messaging = FirebaseMessaging.instance;
//
//   NotificationSettings settings = await messaging.requestPermission(
//     alert: true,
//     announcement: false,
//     badge: true,
//     carPlay: false,
//     criticalAlert: false,
//     provisional: false,
//     sound: true,
//   );
//
//   print('User granted permission: ${settings.authorizationStatus}');
//   FirebaseMessaging.instance.getToken().then((value){
//     print("my firebase token -> $value");
//   });
//
//   FirebaseMessaging.onBackgroundMessage(_messageHandler);
//   LocalNotificationService.initialize();
//   runApp( MyApp());
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
    sound: RawResourceAndroidNotificationSound("notification"));

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
      sound: RawResourceAndroidNotificationSound("notification"),
      playSound: true,
    );
    var iosDetails = IOSNotificationDetails();

    var generateNotification =
        NotificationDetails(android: androidDetails, iOS: iosDetails);
    print("--------------");
    final player = AudioPlayer();
    await player.setAsset('assets/sound/notification.mp3').whenComplete(() {
      player.play();
    });

    print("--------------");

    flutterLocalNotificationsPlugin
        .show(
      DateTime.now().second + DateTime.now().minute + DateTime.now().hour,
      message.notification!.title,
      message.notification!.body,
      generateNotification,
      payload: 'Default_Sound',
    )
        .then((value) {
      final player = AudioPlayer();
      player.setAsset('assets/sound/notification.mp3').whenComplete(() {
        player.play();
      });
    });
  } catch (e) {
    print(e);
  }
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  final fcmToken = await FirebaseMessaging.instance.getToken();
  print('FCM Token ->$fcmToken');
  print(
      '-------------------------------------------------------------------------------');
  await FirebaseMessaging.instance.requestPermission(
      alert: true,
      announcement: false,
      badge: true,
      carPlay: false,
      sound: true
  );
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);
  runApp(MyApp());
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
