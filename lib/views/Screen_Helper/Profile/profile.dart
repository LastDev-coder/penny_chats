import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:penny_chats/ApiService/Apiservice.dart';
import 'package:penny_chats/controllers/colors/colors.dart';
import 'package:penny_chats/models/ProfileModel.dart';
import 'package:penny_chats/views/Screen_Helper/Notification/notification_setting.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  void initState() {
    super.initState();
  }

  getprofile() async {
    var data;
    List<ProfileModel> profilemodel = [];

    data = await Apiservice().getprofile();
    var dataresponse = data["response"];
    print("profile ================ $dataresponse ");

    ProfileModel model = ProfileModel(
      dataresponse["id"],
      dataresponse["name"],
      dataresponse["email"],
      dataresponse["email_verified"],
      dataresponse["username"],
      dataresponse["password"],
      dataresponse["profile_pic"],
      dataresponse["created"],
      dataresponse["modified"],
      dataresponse["is_active"],
      dataresponse["is_online"],
      dataresponse["is_login"],
    );
    profilemodel.add(model);

    return profilemodel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.white,
      body: Form(
          child: FutureBuilder(
        future: getprofile(),
        // initialData: InitialData,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (snapshot.data == null) {
            return Container(
              child: Center(
                  child:
                      CupertinoActivityIndicator(animating: true, radius: 15)),
            );
          } else {
            return ListView.builder(
                scrollDirection: Axis.vertical,
                shrinkWrap: true,
                itemCount: snapshot.data.length,
                itemBuilder: (BuildContext context, int i) {
             return  SingleChildScrollView(
                child: Column(
                  children: [
                    Container(
                        color: Colors.green,
                        height: 260,
                        child: Stack(
                          children: [
                            Image.asset(
                              'assets/images/profile-bg.jpg',
                              height: 260,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                            Container(
                              height: double.infinity,
                              child: Center(
                                child: Container(
                                  decoration: BoxDecoration(
                                    color: AppColors.white,
                                    borderRadius: BorderRadius.circular(100),
                                  ),
                                  child: Padding(
                                    padding: const EdgeInsets.all(3.0),
                                    child: CircleAvatar(
                                      radius: 65,
                                      backgroundImage: NetworkImage(
                                          'https://www.pennychats.com/beta/uploads/profile_pictures/${snapshot.data[i].profile_pic}'),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              child: Center(
                                child: Padding(
                                  padding: const EdgeInsets.only(
                                      left: 120, bottom: 80),
                                  child: Container(
                                    height: 40,
                                    width: 40,
                                    decoration: BoxDecoration(
                                      color: AppColors.white,
                                      borderRadius: BorderRadius.circular(100),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(3.0),
                                      child: Icon(
                                        Icons.camera_alt,
                                        size: 25,
                                        color: AppColors
                                            .PROFILE_TAB_CAMERA_ICON_COLOR,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            )
                          ],
                        )),
                    Container(
                      height: 100,
                      color: AppColors.PROFILE_TAB_CONTAINER1_COLOR,
                      child: Center(
                        child: Padding(
                          padding: const EdgeInsets.only(left: 30, right: 30),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text('GENERAL',
                                  style: TextStyle(
                                      fontSize: 13,
                                      color:
                                          AppColors.PROFILE_TAB_GENERALTEXT_COLOR,
                                      fontFamily: 'Gotham',
                                      fontWeight: FontWeight.bold)),
                              TextButton(
                                onPressed: () => {},

                                // padding: EdgeInsets.all(10.0),
                                child: Row(
                                  // Replace with a Row for horizontal icon + text
                                  children: <Widget>[
                                    Icon(
                                      Icons.edit,
                                      size: 20,
                                      color: AppColors.LOGIN_PAGE_LOGINBOX,
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(left: 5),
                                      child: Text("Edit",
                                          style: TextStyle(
                                              fontSize: 13,
                                              color:
                                                  AppColors.LOGIN_PAGE_LOGINBOX,
                                              fontFamily: 'Gotham',
                                              fontWeight: FontWeight.bold)),
                                    )
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Container(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 30, top: 40, right: 30, bottom: 30),
                          child: Column(
                            children: [
                              Container(
                                  width: double.infinity,
                                  child: Text(
                                    'Name',
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: AppColors.PROFILE_TAB_LABEL_TEXT,
                                        fontFamily: 'Gotham',
                                        fontWeight: FontWeight.w500),
                                  )),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                  width: double.infinity,
                                  child: Text(
                                    snapshot.data[i].name,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: AppColors.PROFILE_TAB_NORMAL_TEXT,
                                        fontFamily: 'Gotham',
                                        fontWeight: FontWeight.w500),
                                  )),
                            ],
                          ),
                        )),
                    Divider(
                      thickness: 1,
                      color: AppColors.PROFILE_TAB_DIVIDER,
                    ),
                    Container(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 30, top: 40, right: 30, bottom: 30),
                          child: Column(
                            children: [
                              Container(
                                  width: double.infinity,
                                  child: Text(
                                    'Email',
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: AppColors.PROFILE_TAB_LABEL_TEXT,
                                        fontFamily: 'Gotham',
                                        fontWeight: FontWeight.w500),
                                  )),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                  width: double.infinity,
                                  child: Text(
                                    snapshot.data[i].email,
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: AppColors.PROFILE_TAB_NORMAL_TEXT,
                                        fontFamily: 'Gotham',
                                        fontWeight: FontWeight.w500),
                                  )),
                            ],
                          ),
                        )),
                    Divider(
                      thickness: 1,
                      color: AppColors.PROFILE_TAB_DIVIDER,
                    ),
                    Container(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 30, top: 40, right: 30, bottom: 30),
                          child: Column(
                            children: [
                              Container(
                                  width: double.infinity,
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Text(
                                        'Password',
                                        style: TextStyle(
                                            fontSize: 13,
                                            color:
                                                AppColors.PROFILE_TAB_LABEL_TEXT,
                                            fontFamily: 'Gotham',
                                            fontWeight: FontWeight.w500),
                                      ),
                                      Text(
                                        'Change password',
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: AppColors.LOGIN_PAGE_LOGINBOX,
                                            fontFamily: 'Gotham',
                                            fontWeight: FontWeight.w500),
                                      ),
                                    ],
                                  )),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                  width: double.infinity,
                                  child: Text(
                                    "................",
                                    style: TextStyle(

                                        fontSize: 14,
                                        color: AppColors.PROFILE_TAB_NORMAL_TEXT,
                                        fontFamily: 'Gotham',
                                        fontWeight: FontWeight.w500),
                                  )),
                            ],
                          ),
                        )),
                    Divider(
                      thickness: 1,
                      color: AppColors.PROFILE_TAB_DIVIDER,
                    ),
                    Container(
                        width: double.infinity,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 30, top: 40, right: 30, bottom: 30),
                          child: Column(
                            children: [
                              Container(
                                  width: double.infinity,
                                  child: Text(
                                    'Birthday',
                                    style: TextStyle(
                                        fontSize: 13,
                                        color: AppColors.PROFILE_TAB_LABEL_TEXT,
                                        fontFamily: 'Gotham',
                                        fontWeight: FontWeight.w500),
                                  )),
                              SizedBox(
                                height: 10,
                              ),
                              Container(
                                  width: double.infinity,
                                  child: Text(
                                    'January 12, 1990',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: AppColors.PROFILE_TAB_NORMAL_TEXT,
                                        fontFamily: 'Gotham',
                                        fontWeight: FontWeight.w500),
                                  )),
                            ],
                          ),
                        )),
                    Container(
                      width: double.infinity,
                      color: AppColors.PROFILE_TAB_CONTAINER1_COLOR,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 30, right: 30, top: 30, bottom: 30),
                        child: Text('GENERAL',
                            textAlign: TextAlign.start,
                            style: TextStyle(
                                fontSize: 13,
                                color: AppColors.PROFILE_TAB_GENERALTEXT_COLOR,
                                fontFamily: 'Gotham',
                                fontWeight: FontWeight.bold)),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => NotificationSetting()));
                      },
                      splashColor: Colors.black38,
                      child: Container(
                          child: Padding(
                        padding: const EdgeInsets.only(
                            left: 30, top: 40, right: 30, bottom: 30),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'Chat Settings',
                              style: TextStyle(
                                  fontSize: 14,
                                  color: AppColors.PROFILE_TAB_NORMAL_TEXT,
                                  fontFamily: 'Gotham',
                                  fontWeight: FontWeight.w500),
                            ),
                            Icon(
                              Icons.chevron_right,
                              size: 25,
                              color: AppColors.PROFILE_TAB_NORMAL_TEXT,
                            )
                          ],
                        ),
                      )),
                    ),
                  ],
                ),
              );

    }
            );
          }
        },
      )),
    );
  }
}
