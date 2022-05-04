import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:penny_chats/controllers/colors/colors.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../ApiService/Apiservice.dart';

class NotificationSetting extends StatefulWidget {
  NotificationSetting({Key? key}) : super(key: key);

  @override
  _NotificationSettingState createState() => _NotificationSettingState();
}

class _NotificationSettingState extends State<NotificationSetting> {
  bool _emailSwitchValue = true;
  bool _phoneSwitchValue = false;
  bool isLoading = false;

onClickNotification() async {
  setState(() {
    isLoading = true;
  });
  var data = await Apiservice().getNotificationEnable();
if(data['response']=='0'){
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  _prefs.setString('Notification-Status', data['response']);
setState(() {
  _phoneSwitchValue = false;
  isLoading = false;

});
}else{
  SharedPreferences _prefs = await SharedPreferences.getInstance();
  _prefs.setString('Notification-Status', data['response']);
  setState(() {
    _phoneSwitchValue = true;
    isLoading = false;

  });
}



}
getStatus() async {
  final prefs = await SharedPreferences.getInstance();
  final status = prefs.getString('Notification-Status') ?? '1';
print(status.toString());
if(status.toString()=='1'){
  setState(() {
    _phoneSwitchValue = true;
  });
}else{
  setState(() {
    _phoneSwitchValue = false;
  });
}

}

@override
  void initState() {
    // TODO: implement initState
    super.initState();
    getStatus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor:Get.isDarkMode ? Colors.white24 : AppColors.white,
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
        title: Text('NOTIFICATION SETTINGS'),
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
              color: Get.isDarkMode ? Colors.black12 :AppColors.NOTIFICATION_BLACKSHADE,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 30, right: 30, top: 30, bottom: 30),
                child: Text('NOTIFICATION',
                    textAlign: TextAlign.start,
                    style: TextStyle(
                        fontSize: 12,
                        color: AppColors.LOGIN_PAGE_LOGINBOX,
                        fontFamily: 'Gotham',
                        fontWeight: FontWeight.bold)),
              ),
            ),
            // Container(
            //     child: Padding(
            //   padding: const EdgeInsets.only(
            //       left: 30, top: 40, right: 30, bottom: 30),
            //   child: Row(
            //     mainAxisAlignment: MainAxisAlignment.spaceBetween,
            //     children: [
            //       Text(
            //         'Email Notification',
            //         style: TextStyle(
            //             fontSize: 14,
            //             color:Get.isDarkMode ? Colors.white : AppColors.PROFILE_TAB_NORMAL_TEXT,
            //             fontFamily: 'Gotham',
            //             fontWeight: FontWeight.w500),
            //       ),
            //       CupertinoSwitch(
            //         value: _emailSwitchValue,
            //         onChanged: (value) {
            //           setState(() {
            //             _emailSwitchValue = value;
            //           });
            //         },
            //       ),
            //     ],
            //   ),
            // )),
            Container(
                child: Padding(
              padding: const EdgeInsets.only(
                  left: 30, top: 40, right: 30, bottom: 30),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Phone Notification',
                    style: TextStyle(
                        fontSize: 14,
                        color:Get.isDarkMode ? Colors.white : AppColors.PROFILE_TAB_NORMAL_TEXT,
                        fontFamily: 'Gotham',
                        fontWeight: FontWeight.w500),
                  ),
                  isLoading ?
                  CircularProgressIndicator():
                  CupertinoSwitch(
                    value: _phoneSwitchValue,

                    onChanged: (value) {
                      onClickNotification();
                      // setState(() {
                      //   _phoneSwitchValue = value;
                      // });
                    },
                  ),
                ],
              ),
            )),
          ],
        ),
      ),
    );
  }
}
