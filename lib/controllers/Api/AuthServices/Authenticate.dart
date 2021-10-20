import 'package:flutter/material.dart';
import 'package:penny_chats/views/Screens/Auth/splash.dart';
import 'package:penny_chats/views/Screens/mydashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Authenticate extends StatefulWidget {
  @override
  _AuthenticateState createState() => _AuthenticateState();
}

class _AuthenticateState extends State<Authenticate> {
  checkLogin() async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    if (_prefs.getString('token') == null) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Splash()));
    } else {
      print("token => "+_prefs.getString('token').toString());
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Mydashboard()));
    }
  }

  @override
  void initState() {
    checkLogin();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: CircularProgressIndicator(),
    ));
  }
}
