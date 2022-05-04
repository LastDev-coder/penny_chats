import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:penny_chats/controllers/colors/colors.dart';
import 'package:penny_chats/views/Screens/Auth/login.dart';

import '../../../ApiService/Apiservice.dart';

class ForgotPassword extends StatefulWidget {
  ForgotPassword({Key? key}) : super(key: key);

  @override
  _ForgotPasswordState createState() => _ForgotPasswordState();
}

class _ForgotPasswordState extends State<ForgotPassword> {
  TextEditingController textController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Form(
          child: Column(
        children: [
          Image.asset(
            'assets/images/forgot-image.jpg',
          ),
          Expanded(
              child: Container(
            width: double.infinity,
            color: Colors.white,
            child: Center(
              child: SingleChildScrollView(
                scrollDirection: Axis.vertical,
                child: Padding(
                  padding: const EdgeInsets.only(right: 60, left: 60),
                  child: Column(
                    children: [
                      Text(
                        'Need help with your password?',
                        style: TextStyle(
                            color: AppColors.LOGIN_PAGE_LOGINBOX,
                            fontFamily: 'Gotham',
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Text(
                        'Enter the username you use for PennyChat, and we’ll help you creat a new password',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                            color: AppColors.FORGOT_PAGE_BLACK_TEXT,
                            fontFamily: 'Gotham',
                            fontSize: 14,
                            fontWeight: FontWeight.bold),
                      ),
                      SizedBox(
                        height: 90,
                      ),
                      TextFormField(
                        controller: textController,
                        style: TextStyle(
                            color: Get.isDarkMode
                                ? Colors.white
                                : AppColors.FORGOT_PAGE_INPUT_TEXT,
                            fontFamily: 'Gotham',
                            fontSize: 16,
                            fontWeight: FontWeight.bold),
                        decoration: const InputDecoration(
                          labelText: 'YOUR USERNAME',
                          labelStyle: TextStyle(
                              fontSize: 13,
                              color: AppColors.FORGOT_PAGE_INPUT_LABLE_TEXT,
                              fontFamily: 'Gotham',
                              fontWeight: FontWeight.w400),
                          focusedBorder: UnderlineInputBorder(
                              borderSide: BorderSide(
                                  color:
                                      AppColors.FORGOT_PAGE_INPUT_LABLE_TEXT)),
                        ),
                        validator: (value) {},
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        width: double.infinity,
                        child: FlatButton(
                            shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(50)),
                            color: AppColors.LOGIN_PAGE_LOGINBOX,
                            onPressed: () async {
                              if (textController.text.toString() == null ||
                                  textController.text.toString().isEmpty ||
                                  textController.text.toString() == '') {
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content: Text(
                                            'Username should not be blanked.')));
                              } else {
                                print("not null --------> " +
                                    textController.text.toString());
                                var data = await Apiservice().postfpassword(
                                    textController.text.toString());
                                ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                        content:
                                            Text(data["response"].toString())));
                                textController.clear();
                                Navigator.of(context).pop();

                              }
                            },


                            child: Text(
                              'RESET PASSWORD',
                              style: TextStyle(
                                  color: AppColors.white,
                                  fontFamily: 'Gotham',
                                  fontWeight: FontWeight.bold),
                            )),
                      ),
                      SizedBox(
                        height: 40,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'LOGIN YOUR ACCOUNT ?',
                            style: TextStyle(
                                fontSize: 13,
                                color: AppColors
                                    .REGISTER_PAGE_ALREADY_TEXT,
                                fontFamily: 'Gotham',
                                fontWeight: FontWeight.w500),
                          ),
                          SizedBox(width: 10),
                          GestureDetector(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => Login()));
                            },
                            child: Text(
                              'SIGN IN',
                              style: TextStyle(
                                  decoration:
                                  TextDecoration.underline,
                                  fontSize: 13,
                                  color:
                                  AppColors.LOGIN_PAGE_LOGINBOX,
                                  fontFamily: 'Gotham',
                                  fontWeight: FontWeight.w500),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ))
        ],
      )),
    );
  }
}
