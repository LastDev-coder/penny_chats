import 'dart:async';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:penny_chats/controllers/colors/colors.dart';
import 'package:penny_chats/views/Screens/Auth/welcome_first.dart';

class Splash extends StatefulWidget {
  Splash({Key? key}) : super(key: key);

  @override
  _SplashState createState() => _SplashState();
}

class _SplashState extends State<Splash> {
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 3), () {
      Route route = MaterialPageRoute(builder: (context) => WelcomeFirst());
      Navigator.pushReplacement(context, route);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          Image.asset(
            'assets/images/splashALT.jpg',
            fit: BoxFit.cover,
            height: double.infinity,
            width: double.infinity,
            alignment: Alignment.center,
          ),
          Padding(
              padding: EdgeInsets.only(top: 135),
              child: Container(
                width: double.infinity,
                child: Text(
                  'PennyChats.com',
                  textAlign: TextAlign.center,
                  style: GoogleFonts.doHyeon(
                    color: AppColors.white,
                    fontWeight: FontWeight.w900,
                    fontSize: 35,
                    fontStyle: FontStyle.normal,
                  ),
                ),
              )),
          Align(
              alignment: Alignment.bottomCenter,
              // padding: EdgeInsets.only(bottom: 135),
              child: Padding(
                padding: const EdgeInsets.only(bottom: 40.0),
                child: Container(
                  width: double.infinity,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset(
                        'assets/images/copy-right.png',
                        height: 20,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      Text(
                        '2021 PennyChats',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: AppColors.white,
                            fontFamily: 'Gotham',
                            fontSize: 18,
                            fontWeight: FontWeight.bold),
                      ),
                    ],
                  ),
                ),
              )),
        ],
      ),
    );
  }
}
