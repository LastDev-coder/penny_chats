import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:penny_chats/controllers/colors/colors.dart';
import 'package:penny_chats/views/Screens/Auth/login.dart';
import 'package:penny_chats/views/Screens/Auth/register.dart';

class WelcomeFirst extends StatefulWidget {
  WelcomeFirst({Key? key}) : super(key: key);

  @override
  _WelcomeFirstState createState() => _WelcomeFirstState();
}

class _WelcomeFirstState extends State<WelcomeFirst> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.SCAFFOLD_BACKGROUND,
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Stack(
          children: <Widget>[
            Image.asset(
              'assets/images/login-2.jpg',
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 40,
                top: 420,
                right: 40,
              ),
              child: Container(
                height: 246.5,
                child: Card(
                  elevation: 2,
                  child: Center(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(top: 20),
                          child: Text(
                            'Welcome to',
                            style: GoogleFonts.doHyeon(
                              color: AppColors.WELCOME_TEXT_COLOR,
                              fontWeight: FontWeight.w900,
                              fontSize: 20,
                              fontStyle: FontStyle.normal,
                            ),
                          ),
                        ),
                        Text(
                          'PennyChats.com',
                          textAlign: TextAlign.center,
                          style: GoogleFonts.doHyeon(
                            color: AppColors.PENNY_TEXT_COLOR,
                            fontWeight: FontWeight.w900,
                            fontSize: 30,
                            fontStyle: FontStyle.normal,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 20),
                          child: Text(
                            'Sign up to create your account It take less than 1 minute',
                            textAlign: TextAlign.center,
                            style: TextStyle(
                                fontSize: 15,
                                color: AppColors.FADE_TEXT_COLOR,
                                fontFamily: 'Gotham',
                                fontWeight: FontWeight.w400),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20.0),
                          child: Container(
                            child: Row(
                              children: [
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey[400],

                                      borderRadius: BorderRadius.only(
                                        bottomLeft: const Radius.circular(5.0),
                                      ), // BorderRadius
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                        top: 0.5,
                                      ),
                                      child: FlatButton(
                                        onPressed: () => {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Register()))
                                        },
                                        color: AppColors.white,
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Text(
                                            "I'M NEW",
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.roboto(
                                              color:
                                                  AppColors.Button_TEXT_COLOR,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              fontStyle: FontStyle.normal,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                                Expanded(
                                  child: Container(
                                    decoration: BoxDecoration(
                                      color: Colors.grey[400],

                                      borderRadius: BorderRadius.only(
                                        bottomRight: const Radius.circular(5.0),
                                      ), // BorderRadius
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.only(
                                          top: 0.5, left: 0.5),
                                      child: FlatButton(
                                        onPressed: () => {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      Login()))
                                        },
                                        color: AppColors.white,
                                        child: Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: Text(
                                            "SIGN IN",
                                            textAlign: TextAlign.center,
                                            style: GoogleFonts.roboto(
                                              color:
                                                  AppColors.Button_TEXT_COLOR,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 18,
                                              fontStyle: FontStyle.normal,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
