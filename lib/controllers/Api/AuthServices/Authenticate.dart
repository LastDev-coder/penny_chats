import 'package:flutter/material.dart';
import 'package:penny_chats/views/Screens/Auth/splash.dart';
import 'package:penny_chats/views/Screens/mydashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:firebase_messaging/firebase_messaging.dart';

import '../../../ApiService/Apiservice.dart';
import '../../../NotificationService/LocalNotificationService.dart';


class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> with WidgetsBindingObserver{

  checkLogin() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    try{
      final time = _prefs.getString('idleTime') ?? '';
      DateTime dt1 = DateTime.parse(time);
      DateTime dt2 = DateTime.now();

      Duration diff = dt2.difference(dt1);
      // print("Difference in Hours: " + diff.inHours.toString());
      if( int.parse(diff.inHours.toString())<10){
        if (_prefs.getString('token') == null) {
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Splash()));
        } else {
          print("token => "+_prefs.getString('token').toString());
          Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => Mydashboard(number: 0,)));
        }
      }else{
        _prefs.setString('idleTime', DateTime.now().toString());
        Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => Splash()));
      }
    }catch(e){
      _prefs.setString('idleTime', DateTime.now().toString());
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Splash()));
    }



  }

  @override
  void initState() {
    checkLogin();
    super.initState();
    WidgetsBinding.instance!.addObserver(this);
    print("-----------------------initstate done");

       FirebaseMessaging.instance.getInitialMessage().then(
          (message) {
        print("FirebaseMessaging.instance.getInitialMessage");
        if (message != null) {
          print("New Notification");
          // if (message.data['_id'] != null) {
          //   Navigator.of(context).push(
          //     MaterialPageRoute(
          //       builder: (context) => DemoScreen(
          //         id: message.data['_id'],
          //       ),
          //     ),
          //   );
          // }
        }
      },
    );

    // 2. This method only call when App in forground it mean app must be opened
    FirebaseMessaging.onMessage.listen(
          (message) {
        print("FirebaseMessaging.onMessage.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message ------>  ${message.data}");
          LocalNotificationService.createanddisplaynotification(message);
        }
      },
    );

    // 3. This method only call when App in background and not terminated(not closed)
    FirebaseMessaging.onMessageOpenedApp.listen(
          (message) {
        print("FirebaseMessaging.onMessageOpenedApp.listen");
        if (message.notification != null) {
          print(message.notification!.title);
          print(message.notification!.body);
          print("message2 --------->  ${message.data['_id']}");
        }
      },
    );
  }

  // @override
  // void dispose() {
  //   WidgetsBinding.instance!.removeObserver(this);
  //   print("-----------------------dispose done");
  //
  //   super.dispose();
  // }

  @override
  Future<void> didChangeAppLifecycleState(AppLifecycleState state) async {
    super.didChangeAppLifecycleState(state);

    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) return;

    final isBackground = state == AppLifecycleState.paused;

    if (isBackground) {
    var data =  await Apiservice().getUserActivity('2');
    print(data['response']);

      print("--------------------------->> background true");
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      _prefs.setString('idleTime', DateTime.now().toString());


    }
    final isForeground = state== AppLifecycleState.resumed;
    if(isForeground){

      var data = await Apiservice().getUserActivity('1');
      print(data['response']);

      print('-------------------->>>>> active');
      SharedPreferences _prefs = await SharedPreferences.getInstance();
      _prefs.setString('idleTime', DateTime.now().toString());

    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: CircularProgressIndicator(),
    ));
  }
}
