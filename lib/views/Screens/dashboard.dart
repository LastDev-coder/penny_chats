import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:penny_chats/controllers/colors/colors.dart';

class Dashboard extends StatefulWidget {
  Dashboard({Key? key}) : super(key: key);

  @override
  _DashboardState createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  int _currentIndex = 0;
  @override
  void initState() {
    super.initState();
  }

  static final tabs = [
    Center(
      child: Text('chat'),
    ),
    Center(
      child: Text('Stock Alert'),
    ),
    Center(
      child: Text('Weekly Watch'),
    ),
    Center(
      child: Text('Post'),
    ),
    Center(
      child: Text('Profile'),
    )
  ];
  static final appBarName = [
    Text('CHAT'),
    Text('STOCK ALERT'),
    Text('WEEKLY WATCH'),
    Text('POST'),
    Text('PROFILE'),
  ];

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
        title: appBarName[_currentIndex],
        actions: [
          Badge(
              position: BadgePosition.topEnd(top: -20),
              child: Icon(Icons.search)),
          SizedBox(
            width: 20,
          ),
          Badge(
              position: BadgePosition.topEnd(top: 5, end: -5),
              badgeContent: Text(
                '20',
                style: TextStyle(
                  fontSize: 7.93,
                  color: AppColors.DASHBOARD_SELECTED_ICON_COLOR,
                  fontFamily: 'Gotham',
                  fontWeight: FontWeight.bold,
                ),
              ),
              badgeColor: AppColors.white,
              child: Icon(Icons.notifications_outlined)),
          SizedBox(
            width: 20,
          )
        ],
      ),
      body: tabs[_currentIndex],
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        type: BottomNavigationBarType.fixed,
        selectedFontSize: 7,
        unselectedFontSize: 7,
        selectedItemColor: AppColors.DASHBOARD_SELECTED_ICON_COLOR,
        unselectedItemColor: AppColors.DASHBOARD_UNSELECTED_ICON_COLOR,
        items: [
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icon/chat.svg',
                height: 25,
              ),
              label: 'chat'),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icon/stock.svg',
                height: 25,
              ),
              label: 'Stock Alert'),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icon/calendar.svg',
                height: 25,
              ),
              label: 'Weekly Watch'),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icon/globe.svg',
                height: 25,
              ),
              label: 'Post'),
          BottomNavigationBarItem(
              icon: SvgPicture.asset(
                'assets/icon/user.svg',
                height: 25,
              ),
              label: 'Profile'),
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
