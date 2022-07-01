import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../controllers/colors/colors.dart';
import 'login.dart';

class Thankyou extends StatefulWidget {
  const Thankyou({Key? key}) : super(key: key);

  @override
  _ThankyouState createState() => _ThankyouState();
}

class _ThankyouState extends State<Thankyou> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        flexibleSpace: Container(
          decoration: BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                    AppColors.REGISTER_PAGE_APPBAR_G1,
                    AppColors.REGISTER_PAGE_APPBAR_G2
                  ])),
        ),
        title: Text(
          'Registration Complete',
          style: TextStyle(
              fontSize: 23.3,
              color: AppColors.white,
              fontFamily: 'Gotham',
              fontWeight: FontWeight.bold),
        ),
      ),
      body: Container(
        height: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,

          children: [
            Icon(Icons.verified,size: 50,color: Colors.green,),
            SizedBox(height: 20,),
            Text(
              'Thank You!',
              style: TextStyle(
                  fontSize: 25,
                  color:  AppColors
                      .PROFILE_TAB_NORMAL_TEXT,
                  fontFamily: 'Gotham',
                  fontWeight: FontWeight.w800),
            ),

            Padding(
              padding: EdgeInsets.only(top:20,left: 30,right: 30,bottom: 20),
              child: Text(
                'Please check your email and follow the instructions.',
                textAlign: TextAlign.center,
                style: TextStyle(
                    fontSize: 15,
                    color:  AppColors
                        .PROFILE_TAB_NORMAL_TEXT,
                    fontFamily: 'Gotham',
                    fontWeight: FontWeight.w400),
              ),
            ),

            ElevatedButton(
              child: Text("Login",
                style: TextStyle(
                    fontSize: 18,

                    fontWeight: FontWeight.w400),
              ),
              onPressed: () async {


                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => Login()));

              },
              style: ElevatedButton.styleFrom(
                primary: AppColors.PROFILE_TAB_GENERALTEXT_COLOR,
                onPrimary: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
