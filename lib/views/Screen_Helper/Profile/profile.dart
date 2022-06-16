import 'dart:io';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_image_compress/flutter_image_compress.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:penny_chats/ApiService/Apiservice.dart';
import 'package:penny_chats/controllers/colors/colors.dart';
import 'package:penny_chats/models/ProfileModel.dart';
import 'package:penny_chats/views/Screen_Helper/Notification/notification_setting.dart';
import 'package:penny_chats/views/Screens/mydashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../../controllers/AppStrings.dart';
import '../../Screens/Auth/splash.dart';

class ProfileScreen extends StatefulWidget {
  ProfileScreen({Key? key}) : super(key: key);

  @override
  _ProfileScreenState createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  Dio dio = new Dio();
  File? imageFile;
  bool isLoading = false;

  ImageUpload(image) async {
    Directory tempDir = await getApplicationDocumentsDirectory();
    String tempPath = tempDir.path;

    File? result = await FlutterImageCompress.compressAndGetFile(
      image!.path,
      tempPath + "/" + _basename(image.path),
      minWidth: 100,
      minHeight: 100,
      autoCorrectionAngle: true,
    );
    ScaffoldMessenger.of(context)
        .showSnackBar(SnackBar(content: Text('Uploading your photo')));
    print("---------------------------$result");

    // print("XXXXXXXXXXXXXXXXXXXXXXXXXXX -- File name --" + image);
    var data = await Apiservice().uploadImage(result!.path);
    if (data["status"].toString() == "true") {
      ScaffoldMessenger.of(context).showSnackBar(new SnackBar(
        content: new Text(
          'Image upload complete.',
          style: TextStyle(color: Colors.white),
        ),
        backgroundColor: Colors.green,
      ));
      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => Mydashboard(
                    number: 4,
                  )));
    }
  }

  String _basename(String path) {
    return path.substring(path.lastIndexOf("/") + 1, path.length);
  }

  /// Get from gallery

  _getFromGallery() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.gallery,
      maxWidth: 1000,
      maxHeight: 1000,
    );

    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        ImageUpload(imageFile);
      });
    }
  }

  /// Get from Camera

  _getFromCamera() async {
    PickedFile? pickedFile = await ImagePicker().getImage(
      source: ImageSource.camera,
      maxWidth: 1800,
      maxHeight: 1800,
    );

    if (pickedFile != null) {
      setState(() {
        imageFile = File(pickedFile.path);
        ImageUpload(imageFile);
      });
    }
  }

  DisplaychooseImage() {
    return imageFile == null
        ? null
        : showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                title: Text('Profile Picture',
                    style: TextStyle(
                        fontSize: 18,
                        // color: Colors.black12,
                        fontFamily: 'Gotham',
                        fontWeight: FontWeight.bold)),
                content: StatefulBuilder(
                    builder: (BuildContext context, StateSetter setState) {
                  return Container(
                    height: 260,
                    child: Column(
                      children: [
                        Container(
                          height: 200,
                          width: 200,
                          child: Image.file(
                            imageFile!,
                            fit: BoxFit.cover,
                          ),
                        ),
                        SizedBox(
                          height: 10,
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
                                Navigator.of(context).pop();
                              },
                              child: Text('Cancle',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontFamily: 'Gotham',
                                      fontSize: 15,
                                      fontWeight: FontWeight.normal)),
                            ),
                            SizedBox(
                              width: 10,
                            ),
                            FlatButton(
                              color: AppColors.RESULT_TEXT,
                              shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(50)),
                              onPressed: () async {
                                setState(() {
                                  isLoading = true;
                                });

                                setState(() {
                                  isLoading = false;
                                });
                                Navigator.of(context).pop();


                              },
                              child: isLoading
                                  ? Container(
                                      height: 20,
                                      width: 20,
                                      child: CircularProgressIndicator(
                                        color: Colors.white,
                                        strokeWidth: 2,
                                      ),
                                    )
                                  : Text('Upload',
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontFamily: 'Gotham',
                                          fontSize: 15,
                                          fontWeight: FontWeight.normal)),
                            ),
                          ],
                        ),
                      ],
                    ),
                  );
                }),
              );
            });
  }

  Future<bool> AddName() async {
    TextEditingController nameController = TextEditingController();

    final shouldPop = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Update Name'),
          content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Container(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 0, right: 0),
                      child: Container(
                        decoration: new BoxDecoration(
                            color: Get.isDarkMode ? Colors.black38 :AppColors.INPUT_BOX,
                            borderRadius: new BorderRadius.only(
                              topLeft: const Radius.circular(5.0),
                              topRight: const Radius.circular(5.0),
                              bottomLeft: const Radius.circular(5.0),
                              bottomRight: const Radius.circular(5.0),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: TextFormField(
                            controller: nameController,
                            keyboardType: TextInputType.name,
                            style: TextStyle(color: Get.isDarkMode ? Colors.white :AppColors.FROMTO_TEXT),
                            decoration: new InputDecoration.collapsed(
                              hintText: 'Enter your name',
                              hintStyle:
                                  TextStyle(color:Get.isDarkMode ? Colors.white : AppColors.FROMTO_TEXT),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FlatButton(
                          // onPressed: () => exit(0),
                          color: AppColors.RESULT_TEXT,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          onPressed: () async {
                            Navigator.of(context).pop();
                          },
                          child: Text('Close',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Gotham',
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal)),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        FlatButton(
                          color: AppColors.RESULT_TEXT,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          onPressed: () async {
                            if (nameController.text.toString() == null ||
                                nameController.text.toString().isEmpty ||
                                nameController.text.toString() == '') {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      'Name field should be fill up. Please try again.')));
                            } else {
                              var _data = new Map<String, dynamic>();
                              _data['name'] = nameController.text.toString();

                              print(_data);

                              var data = await Apiservice().postUsername(_data);
                              Navigator.of(context).pop();

                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text(data["response"].toString())));
                              nameController.clear();
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Mydashboard(
                                            number: 4,
                                          )));
                            }
                          },
                          child: Text('Update',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Gotham',
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal)),
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

  Future<bool> ChangePassword() async {
    TextEditingController pController = TextEditingController();
    TextEditingController confirmpController = TextEditingController();

    final shouldPop = await showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Change Password'),
          content: StatefulBuilder(
              builder: (BuildContext context, StateSetter setState) {
            return Container(
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(left: 0, right: 0),
                      child: Container(
                        decoration: new BoxDecoration(
                            color: Get.isDarkMode ? Colors.black38 :AppColors.INPUT_BOX,
                            borderRadius: new BorderRadius.only(
                              topLeft: const Radius.circular(5.0),
                              topRight: const Radius.circular(5.0),
                              bottomLeft: const Radius.circular(5.0),
                              bottomRight: const Radius.circular(5.0),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: TextFormField(
                            controller: pController,
                            keyboardType: TextInputType.name,
                            style: TextStyle(color:Get.isDarkMode ? Colors.white : AppColors.FROMTO_TEXT),
                            decoration: new InputDecoration.collapsed(
                              hintText: 'Enter your new password',
                              hintStyle:
                                  TextStyle(color:Get.isDarkMode ? Colors.white : AppColors.FROMTO_TEXT),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 0, right: 0),
                      child: Container(
                        decoration: new BoxDecoration(
                            color:Get.isDarkMode ? Colors.black38 : AppColors.INPUT_BOX,
                            borderRadius: new BorderRadius.only(
                              topLeft: const Radius.circular(5.0),
                              topRight: const Radius.circular(5.0),
                              bottomLeft: const Radius.circular(5.0),
                              bottomRight: const Radius.circular(5.0),
                            )),
                        child: Padding(
                          padding: const EdgeInsets.all(15.0),
                          child: TextFormField(
                            controller: confirmpController,
                            keyboardType: TextInputType.name,
                            style: TextStyle(color:Get.isDarkMode ? Colors.white : AppColors.FROMTO_TEXT),
                            decoration: new InputDecoration.collapsed(
                              hintText: 'Confirm your new password',
                              hintStyle:
                                  TextStyle(color:Get.isDarkMode ? Colors.white : AppColors.FROMTO_TEXT),
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        FlatButton(
                          // onPressed: () => exit(0),
                          color: AppColors.RESULT_TEXT,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          onPressed: () async {
                            Navigator.of(context).pop();
                          },
                          child: Text('Close',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Gotham',
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal)),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        FlatButton(
                          color: AppColors.RESULT_TEXT,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(50)),
                          onPressed: () async {
                            if (pController.text.toString() == null ||
                                pController.text.toString().isEmpty ||
                                pController.text.toString() == '' ||
                                confirmpController.text.toString() == null ||
                                confirmpController.text.toString().isEmpty ||
                                confirmpController.text.toString() == '') {
                              ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                                  content: Text(
                                      'All field should be fill up. Please try again.')));
                            } else {
                              var data = await Apiservice().PostChangePassword(
                                  pController.text.toString(),
                                  confirmpController.text.toString());
                              Navigator.of(context).pop();

                              ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                      content:
                                          Text(data["response"].toString())));
                              pController.clear();
                              confirmpController.clear();
                              Navigator.pushReplacement(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Mydashboard(
                                            number: 4,
                                          )));
                            }
                          },
                          child: Text('Update',
                              style: TextStyle(
                                  color: Colors.white,
                                  fontFamily: 'Gotham',
                                  fontSize: 15,
                                  fontWeight: FontWeight.normal)),
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
    print(dataresponse["profile_pic"].toString());
    return profilemodel;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Get.isDarkMode ? Colors.transparent : AppColors.white,
        body: Container(
            child: FutureBuilder(
          future: getprofile(),
          // initialData: InitialData,
          builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
            if (snapshot.data == null) {
              return Container(
                child: Center(
                    child: CupertinoActivityIndicator(
                        animating: true, radius: 15)),
              );
            } else {
              return ListView.builder(
                  scrollDirection: Axis.vertical,
                  shrinkWrap: true,
                  itemCount: snapshot.data.length,
                  itemBuilder: (BuildContext context, int i) {
                    return SingleChildScrollView(
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
                                          borderRadius:
                                              BorderRadius.circular(100),
                                        ),
                                        child: Padding(
                                          padding: const EdgeInsets.all(3.0),
                                          child: CircleAvatar(
                                            radius: 65,
                                            backgroundImage: NetworkImage(snapshot
                                                        .data[i].profile_pic ==
                                                    ''
                                                ? '${AppStrings.noProfilePicture}'
                                                : '${AppStrings.profilePictureApi}/${snapshot.data[i].profile_pic}'),
                                          ),
                                        ),
                                      ),
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () {
                                      showModalBottomSheet(
                                          context: context,
                                          builder: (BuildContext context) {
                                            return Container(
                                              height: 200,
                                              width: double.infinity,
                                              color:Get.isDarkMode ? Colors.black38 : Colors.white,
                                              child: Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.all(
                                                            20.0),
                                                    child: Text(
                                                        'Choose an option',
                                                        style: TextStyle(
                                                            fontSize: 18,
                                                            color:Get.isDarkMode ? Colors.white : AppColors
                                                                .POST_TAB_COMMENTS_COLOR,
                                                            fontFamily:
                                                                'Gotham',
                                                            fontWeight:
                                                                FontWeight
                                                                    .bold)),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                      _getFromCamera();
                                                      // DisplaychooseImage();
                                                    },
                                                    child: Container(
                                                      height: 40,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 40,
                                                                right: 40),
                                                        child: Row(
                                                          children: [
                                                            Icon(
                                                              Icons.camera,
                                                              color: Get.isDarkMode ? Colors.white :AppColors
                                                                  .CHAT_ROOM_DATEOFMESSAGE,
                                                              size: 25,
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Text('Camera',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                    color:Get.isDarkMode ? Colors.white : AppColors
                                                                        .CHAT_ROOM_DATEOFMESSAGE,
                                                                    fontFamily:
                                                                        'Gotham',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal)),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  TextButton(
                                                    onPressed: () {
                                                      Navigator.pop(context);
                                                      _getFromGallery();
                                                      // DisplaychooseImage();
                                                    },
                                                    child: Container(
                                                      height: 40,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                    .only(
                                                                left: 40,
                                                                right: 40),
                                                        child: Row(
                                                          children: [
                                                            Icon(
                                                              Icons.photo_album,
                                                              color: Get.isDarkMode ? Colors.white :AppColors
                                                                  .CHAT_ROOM_DATEOFMESSAGE,
                                                              size: 25,
                                                            ),
                                                            SizedBox(
                                                              width: 10,
                                                            ),
                                                            Text('Gallery',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        15,
                                                                    color:Get.isDarkMode ? Colors.white : AppColors
                                                                        .CHAT_ROOM_DATEOFMESSAGE,
                                                                    fontFamily:
                                                                        'Gotham',
                                                                    fontWeight:
                                                                        FontWeight
                                                                            .normal)),
                                                          ],
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            );
                                          });
                                    },
                                    child: Container(
                                      child: Center(
                                        child: Padding(
                                          padding: const EdgeInsets.only(
                                              left: 120, bottom: 80),
                                          child: Container(
                                            height: 40,
                                            width: 40,
                                            decoration: BoxDecoration(
                                              color: AppColors.white,
                                              borderRadius:
                                                  BorderRadius.circular(100),
                                            ),
                                            child: Padding(
                                              padding:
                                                  const EdgeInsets.all(3.0),
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
                                    ),
                                  )
                                ],
                              )),
                          Container(
                            height: 100,
                            color: Get.isDarkMode
                                ? Colors.black12
                                : AppColors.PROFILE_TAB_CONTAINER1_COLOR,
                            child: Center(
                              child: Padding(
                                padding:
                                    const EdgeInsets.only(left: 30, right: 30),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text('GENERAL',
                                        style: TextStyle(
                                            fontSize: 13,
                                            color: AppColors
                                                .PROFILE_TAB_GENERALTEXT_COLOR,
                                            fontFamily: 'Gotham',
                                            fontWeight: FontWeight.bold)),
                                    TextButton(
                                      onPressed: () => {AddName()},

                                      // padding: EdgeInsets.all(10.0),
                                      child: Row(
                                        // Replace with a Row for horizontal icon + text
                                        children: <Widget>[
                                          Icon(
                                            Icons.edit,
                                            size: 20,
                                            color:
                                                AppColors.LOGIN_PAGE_LOGINBOX,
                                          ),
                                          Padding(
                                            padding:
                                                const EdgeInsets.only(left: 5),
                                            child: Text("Edit",
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: AppColors
                                                        .LOGIN_PAGE_LOGINBOX,
                                                    fontFamily: 'Gotham',
                                                    fontWeight:
                                                        FontWeight.bold)),
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
                                              color: AppColors
                                                  .PROFILE_TAB_LABEL_TEXT,
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
                                              color: Get.isDarkMode
                                                  ? Colors.white
                                                  : AppColors
                                                      .PROFILE_TAB_NORMAL_TEXT,
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
                                              color: AppColors
                                                  .PROFILE_TAB_LABEL_TEXT,
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
                                              color: Get.isDarkMode
                                                  ? Colors.white
                                                  : AppColors
                                                      .PROFILE_TAB_NORMAL_TEXT,
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
                                                  color: AppColors
                                                      .PROFILE_TAB_LABEL_TEXT,
                                                  fontFamily: 'Gotham',
                                                  fontWeight: FontWeight.w500),
                                            ),
                                            GestureDetector(
                                              onTap: () {
                                                ChangePassword();
                                              },
                                              child: Text(
                                                'Change password',
                                                style: TextStyle(
                                                    fontSize: 13,
                                                    color: AppColors
                                                        .LOGIN_PAGE_LOGINBOX,
                                                    fontFamily: 'Gotham',
                                                    fontWeight:
                                                        FontWeight.w500),
                                              ),
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
                                              color: Get.isDarkMode
                                                  ? Colors.white
                                                  : AppColors
                                                      .PROFILE_TAB_NORMAL_TEXT,
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
                            color: Get.isDarkMode
                                ? Colors.black12
                                : AppColors.PROFILE_TAB_CONTAINER1_COLOR,
                            child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 30, right: 30, top: 30, bottom: 30),
                              child: Text('SETTINGS',
                                  textAlign: TextAlign.start,
                                  style: TextStyle(
                                      fontSize: 13,
                                      color: AppColors
                                          .PROFILE_TAB_GENERALTEXT_COLOR,
                                      fontFamily: 'Gotham',
                                      fontWeight: FontWeight.bold)),
                            ),
                          ),
                          InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) =>
                                          NotificationSetting()));
                            },
                            splashColor: Colors.black38,
                            child: Container(
                                child: Padding(
                              padding: const EdgeInsets.only(
                                  left: 30, top: 40, right: 30, bottom: 30),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    'Notification Settings',
                                    style: TextStyle(
                                        fontSize: 14,
                                        color: Get.isDarkMode
                                            ? Colors.white
                                            : AppColors.PROFILE_TAB_NORMAL_TEXT,
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

                          Divider(
                            thickness: 1,
                            color: AppColors.PROFILE_TAB_DIVIDER,
                          ),
                          Container(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 30, top: 40, right: 30, bottom: 10),
                                child: Row(
                                  mainAxisAlignment:
                                  MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      'Delete Account',
                                      style: TextStyle(
                                          fontSize: 14,
                                          color: Get.isDarkMode
                                              ? Colors.white
                                              : AppColors.PROFILE_TAB_NORMAL_TEXT,
                                          fontFamily: 'Gotham',
                                          fontWeight: FontWeight.w500),
                                    ),
                                    ElevatedButton(
                                      child: Text("Delete"),
                                      onPressed: () => DeleteMyAccount(),
                                      style: ElevatedButton.styleFrom(
                                        primary: Colors.red,
                                        onPrimary: Colors.white,
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(32.0),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                              )),
                          Padding(
                            padding: const EdgeInsets.only(top: 0,left: 20,right: 20,bottom: 20),
                            child: Text(
                              '* If you delete your account you will permanently lose your account from everywhere. After delete your account, you will be able to create new account with the same email address.',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                  color: Colors.red,
                                  fontFamily: 'Gotham',
                                  fontSize: 12,
                                  fontWeight: FontWeight.normal),
                            ),
                          ),


                        ],
                      ),
                    );
                  });
            }
          },
        )));
  }

  Future<bool> DeleteMyAccount() async {
    bool _loading = false;

    final shouldPop = await showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(
              builder: (context, setState) => AlertDialog(
                title: Text('Warning',
                    style: TextStyle(color: Colors.red)

                ),
                content: Text('Account will be permanently delete and cannot be recovered, Are you sure ?'),
                actions: <Widget>[
                  FlatButton(
                    onPressed: () => Navigator.of(context).pop(false),
                    child: Text('No'),
                  ),
                  _loading
                      ? CupertinoActivityIndicator(
                      animating: true, radius: 10)
                      : ElevatedButton(
                    child: Text("Delete",

                    ),
                    onPressed: () async {
                      setState(() {
                        _loading = true;
                      });
                      await Apiservice().getLogout();
                      await Apiservice().getUserDelete();

                      SharedPreferences _prefs =
                      await SharedPreferences.getInstance();
                      _prefs.clear();
                      Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                              builder: (context) => Splash()));
                      Navigator.of(context).pop(false);

                    },
                    style: ElevatedButton.styleFrom(
                      primary: Colors.red,
                      onPrimary: Colors.white,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                    ),
                  ),

                ],
              ));
        });

    return shouldPop ?? false;
  }

}
