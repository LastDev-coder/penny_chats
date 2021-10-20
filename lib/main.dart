import 'package:flutter/material.dart';
import 'package:penny_chats/controllers/Api/AuthServices/Authenticate.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'PennyChats',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Authenticate(),
    );
  }
}
