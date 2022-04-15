import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:penny_chats/controllers/colors/colors.dart';

class Terms extends StatefulWidget {
  Terms({Key? key}) : super(key: key);

  @override
  _TermsState createState() => _TermsState();
}

class _TermsState extends State<Terms> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: true,
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
        title: Text('TERMS AND CONDITION'),
        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context, 'back');
          },
          child: Icon(
            Icons.chevron_left,
            size: 40,
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: double.infinity,
              color: Get.isDarkMode
                  ? Colors.black12
                  : AppColors.NOTIFICATION_BLACKSHADE,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 30, right: 30, top: 30, bottom: 30),
                child: Text('PRIVACY',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 15,
                        color: AppColors.LOGIN_PAGE_LOGINBOX,
                        fontFamily: 'Gotham',
                        fontWeight: FontWeight.bold)),
              ),
            ),
            Container(
              width: double.infinity,
              // color: AppColors.NOTIFICATION_BLACKSHADE,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 30, right: 30, top: 10, bottom: 10),
                child: Text(
                    'When you use our services, you’re trusting us with your information. We understand this is a big responsibility and work hard to protect your information and put you in control.This Privacy Policy is meant to help you understand what information we collect, why we collect it, and how you can update, manage, export, and delete your information.',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 14,
                        color: Get.isDarkMode
                            ? Colors.white
                            : AppColors.LOGIN_PAGE_INPUTBOX_INPUTTEXT,
                        fontFamily: 'Gotham',
                        fontWeight: FontWeight.w400)),
              ),
            ),
            Container(
              width: double.infinity,
              color: Get.isDarkMode
                  ? Colors.black12
                  : AppColors.NOTIFICATION_BLACKSHADE,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 30, right: 30, top: 30, bottom: 30),
                child: Text('ADVERTISING',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 15,
                        color: AppColors.LOGIN_PAGE_LOGINBOX,
                        fontFamily: 'Gotham',
                        fontWeight: FontWeight.bold)),
              ),
            ),
            Container(
              width: double.infinity,
              // color: AppColors.NOTIFICATION_BLACKSHADE,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 30, right: 30, top: 10, bottom: 10),
                child: Text(
                    'When you use our services, you’re trusting us with your information. We understand this is a big responsibility and work hard to protect your information and put you in control.This Privacy Policy is meant to help you understand what information we collect, why we collect it, and how you can update, manage, export, and delete your information.',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 14,
                        color: Get.isDarkMode
                            ? Colors.white
                            : AppColors.LOGIN_PAGE_INPUTBOX_INPUTTEXT,
                        fontFamily: 'Gotham',
                        fontWeight: FontWeight.w400)),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
