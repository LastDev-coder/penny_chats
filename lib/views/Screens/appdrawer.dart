import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:get/get.dart';
import 'package:penny_chats/controllers/colors/colors.dart';
import 'package:penny_chats/views/Screen_Helper/Drawer/Navigation_Drawer.dart';
import 'package:penny_chats/views/Screens/Auth/splash.dart';
import 'package:penny_chats/views/Screens/ExtraScreens/FAQ.dart';
import 'package:penny_chats/views/Screens/ExtraScreens/ManageTestimonial.dart';
import 'package:penny_chats/views/Screens/ExtraScreens/MyTestimonials.dart';
import 'package:penny_chats/views/Screens/ExtraScreens/StocksToWatch.dart';
import 'package:penny_chats/views/Screens/ExtraScreens/contact.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'ExtraScreens/Tradng.dart';
import 'ExtraScreens/disclaimerScreen.dart';
import 'dashboard.dart';
import 'mydashboard.dart';

class appdrawer extends StatefulWidget {
  appdrawer({Key? key}) : super(key: key);

  @override
  _appdrawerState createState() => _appdrawerState();
}

class _appdrawerState extends State<appdrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
         child: SingleChildScrollView(
                child: Container(
                  height: MediaQuery.of(context).size.height,
                  width: MediaQuery.of(context).size.width,
                  child: Column(
                    children: [
                      Expanded(
                        flex: 1,
                        child: SingleChildScrollView(
                          child: Column(
                            children: [
                              NavigationDrawer(),
                              ListTile(
                                title: Text(
                                  'Dashboard',
                                  style: TextStyle(
                                      color:
                                      Get.isDarkMode
                                          ?Colors.white:  AppColors.LOGIN_PAGE_INPUTBOX_INPUTTEXT,
                                      fontFamily: 'Gotham',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                                leading: Icon(Icons.dashboard_outlined,size: 28,color:  Get.isDarkMode
                                ?Colors.white: Colors.black,),
                                onTap: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Mydashboard(number: 0,)));
                                },
                              ),
                              ListTile(
                                title: Text(
                                  'Tools',
                                  style: TextStyle(
                                      color:
                                      Get.isDarkMode
                                          ?Colors.white: AppColors.LOGIN_PAGE_INPUTBOX_INPUTTEXT,
                                      fontFamily: 'Gotham',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                                leading: SvgPicture.asset(
                                  "assets/icon/wrench.svg",
                                  height: 28,
                                  color: Get.isDarkMode
                                      ?Colors.white: Colors.black,
                                ),
                                onTap: () {
                                  // Update the state of the app.
                                  // ...
                                },
                              ),
                              ListView(
                                shrinkWrap: true,
                                children: [
                                  ExpansionTile(
                                    title: Row(
                                      children: [
                                         SvgPicture.asset(
                                          "assets/icon/bar.svg",
                                          height: 28,
                                           color: Get.isDarkMode
                                               ?Colors.white: Colors.black,
                                        ),
                                        SizedBox(width: 30,),
                                        Text(
                                          'Penny Stocks',
                                          style: TextStyle(
                                              color:
                                              Get.isDarkMode
                                                  ?Colors.white: AppColors.LOGIN_PAGE_INPUTBOX_INPUTTEXT,
                                              fontFamily: 'Gotham',
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                    children: <Widget>[
                                      InkWell(
                                        onTap: (){
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => StocksToWatch(id: "2",)));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(6.0),
                                          child: Text(
                                            'Penny Stocks To Watch',
                                            style: TextStyle(
                                                color:
                                                Get.isDarkMode
                                                    ?Colors.white: AppColors.LOGIN_PAGE_INPUTBOX_INPUTTEXT,
                                                fontFamily: 'Gotham',
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 5,),
                                      InkWell(
                                        onTap: (){
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => StocksToWatch(id: "3",)));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(6.0),
                                          child: Text(
                                            'Penny Stocks Help',
                                            style: TextStyle(
                                                color:
                                                Get.isDarkMode
                                                    ?Colors.white: AppColors.LOGIN_PAGE_INPUTBOX_INPUTTEXT,
                                                fontFamily: 'Gotham',
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 5,),
                                      InkWell(
                                        onTap: (){
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => StocksToWatch(id: "4",)));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(6.0),
                                          child: Text(
                                            'Upcoming IPO Stocks',
                                            style: TextStyle(
                                                color:
                                                Get.isDarkMode
                                                    ?Colors.white: AppColors.LOGIN_PAGE_INPUTBOX_INPUTTEXT,
                                                fontFamily: 'Gotham',
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 5,),
                                    ],
                                  )
                                ],

                              ),
                              ListTile(
                                title: Text(
                                  'Trading 101',
                                  style: TextStyle(
                                      color:
                                      Get.isDarkMode
                                          ?Colors.white: AppColors.LOGIN_PAGE_INPUTBOX_INPUTTEXT,
                                      fontFamily: 'Gotham',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                                leading: SvgPicture.asset(
                                  "assets/icon/exchange.svg",
                                  height: 28,
                                  color: Get.isDarkMode
                                      ?Colors.white: Colors.black,
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Trading()));
                                },
                              ),
                              ListView(
                                shrinkWrap: true,
                                children: [
                                  ExpansionTile(
                                    title: Row(
                                      children: [
                                       Icon(Icons.insert_comment_outlined,size: 26,),
                                        SizedBox(width: 30,),
                                        Text(
                                          'Testimonials',
                                          style: TextStyle(
                                              color:
                                              Get.isDarkMode
                                                  ?Colors.white: AppColors.LOGIN_PAGE_INPUTBOX_INPUTTEXT,
                                              fontFamily: 'Gotham',
                                              fontSize: 16,
                                              fontWeight: FontWeight.w400),
                                        ),
                                      ],
                                    ),
                                    children: <Widget>[
                                      InkWell(
                                        onTap: (){
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => ManageTestimonial()));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(6.0),
                                          child: Text(
                                            'Add Testimonial',
                                            style: TextStyle(
                                                color:
                                                Get.isDarkMode
                                                    ?Colors.white: AppColors.LOGIN_PAGE_INPUTBOX_INPUTTEXT,
                                                fontFamily: 'Gotham',
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 5,),
                                      InkWell(
                                        onTap: (){
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) => MyTestimonials()));
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(6.0),
                                          child: Text(
                                            'My Testimonials',
                                            style: TextStyle(
                                                color:
                                                Get.isDarkMode
                                                    ?Colors.white: AppColors.LOGIN_PAGE_INPUTBOX_INPUTTEXT,
                                                fontFamily: 'Gotham',
                                                fontSize: 14,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ),
                                      ),
                                      SizedBox(height: 5,),

                                    ],
                                  )
                                ],

                              ),


                              ListTile(
                                title: Text(
                                  'Contact Us',
                                  style: TextStyle(
                                      color:
                                      Get.isDarkMode
                                          ?Colors.white:  AppColors.LOGIN_PAGE_INPUTBOX_INPUTTEXT,
                                      fontFamily: 'Gotham',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                                leading: SvgPicture.asset(
                                  "assets/icon/envelope.svg",
                                  height: 28,
                                  color: Get.isDarkMode
                                      ?Colors.white: Colors.black,
                                ),
                                onTap: () {
                                  // Update the state of the app.
                                  // ...
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => contact()));
                                },
                              ),
                              ListTile(
                                title: Text(
                                  'FAQs',
                                  style: TextStyle(
                                      color:
                                      Get.isDarkMode
                                          ?Colors.white:  AppColors.LOGIN_PAGE_INPUTBOX_INPUTTEXT,
                                      fontFamily: 'Gotham',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                                leading: SvgPicture.asset(
                                  "assets/icon/faq.svg",
                                  height: 28,
                                  color: Get.isDarkMode
                                      ?Colors.white: Colors.black,
                                ),
                                onTap: () {
                                 Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                        builder: (context) => FAQ()));
                                },
                              ),
                              ListTile(
                                title: Text(
                                  'Disclaimer',
                                  style: TextStyle(
                                      color:
                                      Get.isDarkMode
                                          ?Colors.white: AppColors.LOGIN_PAGE_INPUTBOX_INPUTTEXT,
                                      fontFamily: 'Gotham',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                ),
                                leading: SvgPicture.asset(
                                  "assets/icon/faq.svg",
                                  height: 28,
                                  color: Get.isDarkMode
                                      ?Colors.white: Colors.black,
                                ),
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              DisclaimerScreen()));
                                },
                              ),
                              // ListTile(
                              //   title: Text(
                              //     'About',
                              //     style: TextStyle(
                              //         color:
                              //             AppColors.LOGIN_PAGE_INPUTBOX_INPUTTEXT,
                              //         fontFamily: 'Gotham',
                              //         fontSize: 16,
                              //         fontWeight: FontWeight.w400),
                              //   ),
                              //   leading: Text('ⓘ',
                              //       style: TextStyle(
                              //           fontSize: 25,
                              //           color: AppColors
                              //               .LOGIN_PAGE_INPUTBOX_INPUTTEXT,
                              //           fontFamily: 'Gotham',
                              //           fontWeight: FontWeight.normal)),
                              //   onTap: () {
                              //     // Update the state of the app.
                              //     // ...
                              //   },
                              // ),
                            ],
                          ),
                        ),
                      ),
                      Align(
                          alignment: Alignment.bottomCenter,
                          child: InkWell(
                            onTap: () async {
                              SharedPreferences _prefs =
                                  await SharedPreferences.getInstance();
                              _prefs.clear();
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Splash()));
                            },
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 20, top: 20, bottom: 20),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Icon(
                                    Icons.logout,
                                    size: 20,
                                  ),
                                  SizedBox(
                                    width: 10,
                                  ),
                                  Text(
                                    'Log Out',
                                    style: TextStyle(
                                        color:Get.isDarkMode ? Colors.white : AppColors
                                            .LOGIN_PAGE_INPUTBOX_INPUTTEXT,
                                        fontFamily: 'Gotham',
                                        fontSize: 16,
                                        fontWeight: FontWeight.w400),
                                  )
                                ],
                              ),
                            ),
                          ))
                    ],
                  ),
                ),
              ),
          
    );
  }
}