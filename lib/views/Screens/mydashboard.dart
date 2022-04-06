import 'dart:io';

import 'package:badges/badges.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:get/get.dart';
import 'package:penny_chats/ApiService/Apiservice.dart';
import 'package:penny_chats/controllers/AppStrings.dart';
import 'package:penny_chats/controllers/Api/NotificationsApi.dart';
import 'package:penny_chats/controllers/colors/colors.dart';
import 'package:penny_chats/models/NotificationsModel.dart';
import 'package:penny_chats/models/ProfileModel.dart';
import 'package:penny_chats/views/Screen_Helper/ChatScreens/chat.dart';
import 'package:penny_chats/views/Screen_Helper/Drawer/Navigation_Drawer.dart';
import 'package:penny_chats/views/Screen_Helper/Notification/notification.dart';
import 'package:penny_chats/views/Screen_Helper/Notification/notification_setting.dart';
import 'package:penny_chats/views/Screen_Helper/PostScreens/post.dart';
import 'package:penny_chats/views/Screen_Helper/Profile/profile.dart';
import 'package:penny_chats/views/Screen_Helper/Stock/WeeklyWatch.dart';
import 'package:penny_chats/views/Screen_Helper/Stock/stock_alert_add.dart';
import 'package:penny_chats/views/Screens/Auth/splash.dart';
import 'package:penny_chats/views/Screens/ExtraScreens/disclaimerScreen.dart';
import 'package:penny_chats/views/Screens/appdrawer.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Mydashboard extends StatefulWidget {
  final int number;
  Mydashboard({Key? key, required this.number}) : super(key: key);

  @override
  _MydashboardState createState() => _MydashboardState();
}

class _MydashboardState extends State<Mydashboard> {
  int _currentIndex = 0;

  static final tabs = [
    Chat(),
    NoStocks(),
    WeeklyWatchScreen(),
    Post(),
    ProfileScreen(),
  ];
  static final _appBarName = [
    Text(
      'CHAT',
      style: TextStyle(
        fontSize: 16.34,
        fontFamily: 'Gotham',
        fontWeight: FontWeight.bold,
      ),
    ),
    Text(
      'STOCK ALERT',
      style: TextStyle(
        fontSize: 16.34,
        fontFamily: 'Gotham',
        fontWeight: FontWeight.bold,
      ),
    ),
    Text(
      'WEEKLY WATCH',
      style: TextStyle(
        fontSize: 16.34,
        fontFamily: 'Gotham',
        fontWeight: FontWeight.bold,
      ),
    ),
    Text(
      'POST',
      style: TextStyle(
        fontSize: 16.34,
        fontFamily: 'Gotham',
        fontWeight: FontWeight.bold,
      ),
    ),
    Text(
      'PROFILE',
      style: TextStyle(
        fontSize: 16.34,
        fontFamily: 'Gotham',
        fontWeight: FontWeight.bold,
      ),
    ),
  ];



  NotificationsModel? _notificationData;

  @override
  void initState() {
    NotificationsApi.getNotification(context, AppStrings.getNotificationApi)
        .then((value) {
      setState(() {
        _notificationData = value;
        _currentIndex = widget.number;
      });
    });
    super.initState();
  }
  Future<bool> onWillPop() async {
    final shouldPop = await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text('Are you sure?'),
        content: Text('Do you want to exit from app ?'),
        actions: <Widget>[
          FlatButton(
            onPressed: () => Navigator.of(context).pop(false),
            child: Text('No'),
          ),
          FlatButton(
            onPressed: () => exit(0),
            child: Text('Yes'),
          ),
        ],
      ),
    );

    return shouldPop ?? false;
  }
  

  @override
  Widget build(BuildContext context) {
    return _notificationData == null
        ? Scaffold(
            body: Center(
              child: CircularProgressIndicator(),
            ),
          )
        : Scaffold(
            drawer: appdrawer(),
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
              title: _appBarName[_currentIndex],
              actions: [
                Badge(
                  position: BadgePosition.topEnd(top: -20),
                  child: SvgPicture.asset(
                    "assets/icon/search.svg",
                    height: 20,
                  ),
                ),
                SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => NotificationScreen()));
                  },
                  child: Badge(
                    position: BadgePosition.topEnd(top: 5, end: -5),
                    badgeContent: Text(
                      _notificationData!.response!.length.toString(),
                      style: TextStyle(
                        fontSize: 7.93,
                        color: AppColors.DASHBOARD_SELECTED_ICON_COLOR,
                        fontFamily: 'Gotham',
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    badgeColor: AppColors.white,
                    child: SvgPicture.asset(
                      "assets/icon/bell.svg",
                      height: 25,
                    ),
                  ),
                ),
                SizedBox(
                  width: 20,
                )
              ],
            ),
            body: WillPopScope(
                onWillPop: onWillPop,
                child: tabs[_currentIndex]
            ),


            bottomNavigationBar: BottomNavigationBar(
              currentIndex: _currentIndex,
              type: BottomNavigationBarType.fixed,
              selectedFontSize: 7,
              unselectedFontSize: 7,
              selectedItemColor:  AppColors.DASHBOARD_SELECTED_ICON_COLOR,
              unselectedItemColor: AppColors.DASHBOARD_UNSELECTED_ICON_COLOR,
              items: [
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    "assets/icon/chat.svg",
                    height: 28,
                  ),
                  label: "Chat",
                  activeIcon: Image.asset(
                    "assets/images/chat-solid.png",
                    height: 28,
                    color:  AppColors.DASHBOARD_SELECTED_ICON_COLOR,
                  ),
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    "assets/icon/stock.svg",
                    height: 28,
                  ),
                  label: "Stock Alert",
                  activeIcon: SvgPicture.asset(
                    "assets/icon/stock.svg",
                    height: 28,
                    color: AppColors.DASHBOARD_SELECTED_ICON_COLOR,
                  ),
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    "assets/icon/calendar.svg",
                    height: 28,
                  ),
                  label: "Weekly watch",
                  activeIcon: SvgPicture.asset(
                    "assets/icon/calendar.svg",
                    height: 28,
                    color: AppColors.DASHBOARD_SELECTED_ICON_COLOR,
                  ),
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    "assets/icon/globe.svg",
                    height: 28,
                  ),
                  label: "Post",
                  activeIcon: SvgPicture.asset(
                    "assets/icon/globe.svg",
                    height: 28,
                    color: AppColors.DASHBOARD_SELECTED_ICON_COLOR,
                  ),
                ),
                BottomNavigationBarItem(
                  icon: SvgPicture.asset(
                    "assets/icon/user.svg",
                    height: 28,
                  ),
                  label: "Profile",
                  activeIcon: Image.asset(
                    "assets/images/profile-solid.png",
                    height: 28,
                    color: AppColors.DASHBOARD_SELECTED_ICON_COLOR,
                  ),
                ),
              ],
              onTap: (index) {
                setState(() {
                  _currentIndex = index;
                });

              },
            ),
          );
  }
}
