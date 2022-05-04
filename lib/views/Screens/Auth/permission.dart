import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:penny_chats/views/Screens/Auth/welcome_first.dart';
import 'package:permission_handler/permission_handler.dart';

class Permission extends StatefulWidget {
  const Permission({Key? key}) : super(key: key);

  @override
  _PermissionState createState() => _PermissionState();
}

class _PermissionState extends State<Permission> {

  Future<bool> onWillPop() async {
    final shouldPop = await showDialog(
      barrierDismissible: false,
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Allow PennyChats to access your camera,gallery,internet only when you are using this app?',
        textAlign: TextAlign.center,
          style: TextStyle(
              fontFamily: 'Gotham',
              fontWeight: FontWeight.bold
          ),
        ),
        content: Text('PennyChats uses the local network to connect with other people and need to access to your photo library to send photos.',
          textAlign: TextAlign.center,

        ),
        actions: <Widget>[
          FlatButton(
            onPressed: (){
              Route route = MaterialPageRoute(builder: (context) => WelcomeFirst());
              Navigator.pushReplacement(context, route);
            },
            child: Text('Ok'),
          ),

        ],
      ),
    );

    return shouldPop ?? false;
  }

  void initState() {
    // TODO: implement initState
    super.initState();
    Future.delayed(Duration.zero, () {
      this.onWillPop();
    });

  }



  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white70,

    );
  }
}
