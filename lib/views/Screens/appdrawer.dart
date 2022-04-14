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


  Calculate(String stprice, String edprice) {
    double startprice, totalprice;

    totalprice = double.parse(stprice);
    startprice = double.parse(edprice);

    double result = ((startprice - totalprice) / totalprice) * 100;
    String r = "";

    setState(() {
      r = result.toStringAsFixed(2);
    });

    return r;
  }

  Future<bool> Calculator() async {
    String CalculateResult = '';
    TextEditingController spController = TextEditingController();
    TextEditingController epController = TextEditingController();
    final shouldPop = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(

          content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
                return Container(
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Align(
                            alignment: Alignment.topRight,
                            child: GestureDetector(
                                onTap: (){
                                  Navigator.of(context).pop();
                                },
                                child: Icon(Icons.close))),
                        SizedBox(
                          height: 10,
                        ),
                        Text('Percent gain calculator',
                            style: TextStyle(
                                color: Colors.black,
                                fontFamily: 'Gotham',
                                fontSize: 20,
                                fontWeight: FontWeight.w600)
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        Text('From',
                            style: TextStyle(
                                color: AppColors.FROMTO_TEXT,
                                fontFamily: 'Gotham',
                                fontSize: 15,
                                fontWeight: FontWeight.normal)),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 0, right: 0),
                          child: Container(
                            decoration: new BoxDecoration(
                                color: AppColors.INPUT_BOX,
                                borderRadius: new BorderRadius.only(
                                  topLeft: const Radius.circular(5.0),
                                  topRight: const Radius.circular(5.0),
                                  bottomLeft: const Radius.circular(5.0),
                                  bottomRight: const Radius.circular(5.0),
                                )),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: TextFormField(
                                controller: spController,
                                keyboardType: TextInputType.number,
                                style: TextStyle(color: AppColors.INPUT_TEXT),
                                decoration: new InputDecoration.collapsed(
                                  hintText: 'Starting Price',
                                  hintStyle:
                                  TextStyle(color: AppColors.FROMTO_TEXT),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text('To',
                            style: TextStyle(
                                color: AppColors.FROMTO_TEXT,
                                fontFamily: 'Gotham',
                                fontSize: 15,
                                fontWeight: FontWeight.normal)),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 0, right: 0),
                          child: Container(
                            decoration: new BoxDecoration(
                                color: AppColors.INPUT_BOX,
                                borderRadius: new BorderRadius.only(
                                  topLeft: const Radius.circular(5.0),
                                  topRight: const Radius.circular(5.0),
                                  bottomLeft: const Radius.circular(5.0),
                                  bottomRight: const Radius.circular(5.0),
                                )),
                            child: Padding(
                              padding: const EdgeInsets.all(15.0),
                              child: TextFormField(
                                controller: epController,
                                keyboardType: TextInputType.number,
                                style: TextStyle(color: AppColors.INPUT_TEXT),
                                decoration: new InputDecoration.collapsed(
                                  hintText: 'Ending Price',
                                  hintStyle:
                                  TextStyle(color: AppColors.FROMTO_TEXT),
                                ),
                              ),
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(top: 20, bottom: 10),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text('$CalculateResult',
                                  style: TextStyle(
                                      color: AppColors.RESULT_TEXT,
                                      fontFamily: 'Gotham',
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal)),
                            ],
                          ),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            FlatButton(
                              // onPressed: () => exit(0),
                              color: AppColors.RESULT_TEXT,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              onPressed: () {
                                if (spController.text.toString().isEmpty ||
                                    epController.text.toString().isEmpty) {
                                  if (mounted) { setState(() {
                                    CalculateResult = "Error in input";
                                  }

                                  ); }
                                  //   CalculateResult = "Error in input";

                                } else {
                                  String result = Calculate(
                                      spController.text.toString(),
                                      epController.text.toString());
                                  print("------> " + result);
                                  setState(() {
                                    CalculateResult = "$result %";
                                  });
                                }
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.subdirectory_arrow_left_sharp,
                                    color: Colors.white,
                                    size: 15,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text('Calculate',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Gotham',
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal)),
                                ],
                              ),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            FlatButton(
                              color: AppColors.CLEAR_BOX,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              onPressed: () {
                                setState(() {
                                  spController.clear();
                                  epController.clear();
                                  CalculateResult = '';
                                });
                              },
                              child: Row(
                                children: [
                                  Icon(
                                    Icons.clear,
                                    color: AppColors.CLEAR_BOXTEXT,
                                    size: 15,
                                  ),
                                  SizedBox(
                                    width: 5,
                                  ),
                                  Text('Clear',
                                      style: TextStyle(
                                          color: AppColors.CLEAR_BOXTEXT,
                                          fontFamily: 'Gotham',
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal)),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              }),
        );
      },
    );

    return shouldPop ?? false;
  }


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
                              ListView(
                                shrinkWrap: true,
                                children: [
                                  ExpansionTile(
                                    title: Row(
                                      children: [
                                        SvgPicture.asset(
                                          "assets/icon/wrench.svg",
                                          height: 28,
                                          color: Get.isDarkMode
                                              ?Colors.white: Colors.black,
                                        ),
                                        SizedBox(width: 30,),
                                        Text(
                                          'Tools',
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
                                       Calculator();
                                        },
                                        child: Padding(
                                          padding: const EdgeInsets.all(6.0),
                                          child: Text(
                                            'Gain Calculator',
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