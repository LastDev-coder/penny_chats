import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:intl/intl.dart';
import 'package:penny_chats/controllers/Api/User/UserDataApi.dart';
import 'package:penny_chats/controllers/AppStrings.dart';
import 'package:penny_chats/controllers/colors/colors.dart';
import 'package:penny_chats/models/PostUserDataModel.dart';

class PostUserScreen extends StatefulWidget {
  final String? postUserId;

  PostUserScreen({Key? key, this.postUserId}) : super(key: key);

  @override
  _PostUserScreenState createState() => _PostUserScreenState();
}

class _PostUserScreenState extends State<PostUserScreen> {
  DateFormat dateFormat = DateFormat('yyyy');

  PostUserDataModel? _postUserData;

  void initState() {
    UserDataApi.getUserData(
            context, '${AppStrings.getUserDataApi}${widget.postUserId}')
        .then((value) {
      setState(() {
        _postUserData = value;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Get.isDarkMode ? Colors.black : AppColors.white,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: true,
        centerTitle: true,
        // backgroundColor: Colors.transparent,
        flexibleSpace: Container(
          child: Image.asset(
            'assets/images/profile-bg.jpg',
            fit: BoxFit.cover,
          ),
        ),

        leading: GestureDetector(
          onTap: () {
            Navigator.pop(context, 'back');
          },
          child: Icon(
            Icons.arrow_back_ios,
            size: 25,
          ),
        ),
      ),
      body: _postUserData == null
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              child: SingleChildScrollView(
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
                                    backgroundImage: _postUserData!
                                            .response!.profilePic!.isNotEmpty
                                        ? NetworkImage(
                                            '${AppStrings.profilePictureApi}/${_postUserData!.response!.profilePic}')
                                        : NetworkImage(
                                            '${AppStrings.noProfilePicture}'),
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
                                      child: Container(
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: _postUserData!
                                                      .response!.isActive ==
                                                  "1"
                                              ? Colors.green
                                              : Colors.grey,
                                        ),
                                      )),
                                ),
                              ),
                            ),
                          )
                        ],
                      )),
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
                                  _postUserData!.response!.name.toString(),
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Get.isDarkMode
                                          ? Colors.white
                                          : AppColors.PROFILE_TAB_NORMAL_TEXT,
                                      fontFamily: 'Gotham',
                                      fontWeight: FontWeight.w500),
                                )),
                          ],
                        ),
                      )),
                  Container(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 30, top: 10, right: 30, bottom: 30),
                        child: Column(
                          children: [
                            Container(
                                width: double.infinity,
                                child: Text(
                                  'User name',
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
                                  _postUserData!.response!.username.toString(),
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Get.isDarkMode
                                          ? Colors.white
                                          : AppColors.PROFILE_TAB_NORMAL_TEXT,
                                      fontFamily: 'Gotham',
                                      fontWeight: FontWeight.w500),
                                )),
                          ],
                        ),
                      )),
                  Container(
                      width: double.infinity,
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 30, top: 10, right: 30, bottom: 30),
                        child: Column(
                          children: [
                            Container(
                                width: double.infinity,
                                child: Text(
                                  'User Since',
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
                                  dateFormat.format(
                                      _postUserData!.response!.created!),
                                  style: TextStyle(
                                      fontSize: 14,
                                      color: Get.isDarkMode
                                          ? Colors.white
                                          : AppColors.PROFILE_TAB_NORMAL_TEXT,
                                      fontFamily: 'Gotham',
                                      fontWeight: FontWeight.w500),
                                )),
                          ],
                        ),
                      )),
                ],
              ),
            )),
    );
  }
}
