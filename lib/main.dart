import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:penny_chats/controllers/Api/AuthServices/Authenticate.dart';

void main() {
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
