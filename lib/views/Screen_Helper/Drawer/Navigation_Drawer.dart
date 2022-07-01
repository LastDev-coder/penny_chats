import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:penny_chats/ApiService/Apiservice.dart';
import 'package:penny_chats/controllers/colors/colors.dart';
import 'package:penny_chats/views/Screens/mydashboard.dart';

import '../../../controllers/AppStrings.dart';

class NavigationDrawer extends StatefulWidget {
  const NavigationDrawer({Key? key}) : super(key: key);

  @override
  _NavigationDrawerState createState() => _NavigationDrawerState();
}

class _NavigationDrawerState extends State<NavigationDrawer> {
  String name = '', image = '';

  static bool _SwitchValue = false;

  getprofile() async {
    var data;
    data = await Apiservice().getprofile();
    var dataresponse = data["response"];

    if (this.mounted) {
      setState(() {
        name = dataresponse["name"].toString();
        image = dataresponse["profile_pic"].toString();
      });
    }

    print("profile ================ ${dataresponse} ");
  }

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    getprofile();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Container(
        width: double.infinity,

        //padding: EdgeInsets.only(top: 50.0),
        child: Stack(
          children: [
            Image.asset(
              'assets/images/menu_bg.png',
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 30, top: 30),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    // height: double.infinity,
                    child: Container(
                      decoration: BoxDecoration(
                        color: AppColors.white,
                        borderRadius: BorderRadius.circular(100),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(3.0),
                        child: CircleAvatar(
                          radius: 25,
                          backgroundImage: NetworkImage(image == ''
                              ? '${AppStrings.noProfilePicture}'
                              : '${AppStrings.profilePictureApi}/${image}'),
                        ),
                      ),
                    ),
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.all(10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Container(
                            width: MediaQuery.of(context).size.width,
                            child: Text(
                              '$name',
                              style: TextStyle(
                                  fontSize: 16,
                                  color: AppColors.white,
                                  fontFamily: 'Gotham',
                                  fontWeight: FontWeight.w400),
                            ),
                          ),
                          SizedBox(
                            height: 5,
                          ),
                          Container(
                            // color: Colors.red,
                            height: 30, //set desired REAL HEIGHT
                            width: 30, //set desired REAL WIDTH
                            child: Transform.scale(
                              transformHitTests: false,
                              scale: .7,
                              child: CupertinoSwitch(
                                value: _SwitchValue,
                                onChanged: (value) {

                                  setState(() {
                                    _SwitchValue = value;
                                    Get.isDarkMode
                                        ? Get.changeTheme(ThemeData.light())
                                        : Get.changeTheme(ThemeData.dark());

                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Mydashboard(
                                                  number: 1,
                                                )));
                                  });
                                },
                                activeColor: Colors.black,
                                trackColor: Colors.white,
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
          ],
        ),
      ),
    );
  }
}
