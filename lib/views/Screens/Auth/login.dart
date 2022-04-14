import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:penny_chats/controllers/Api/AuthServices/AuthServices.dart';
import 'package:penny_chats/controllers/colors/colors.dart';
import 'package:penny_chats/views/Screens/Auth/forgotpassword.dart';
import 'package:penny_chats/views/Screens/Auth/register.dart';

class Login extends StatefulWidget {
  Login({Key? key}) : super(key: key);

  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool _isLoading = false;
  TextEditingController _userName = TextEditingController();
  TextEditingController _password = TextEditingController();
  bool _isHidden = true;

  @override
  void dispose() {
    _userName.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _isLoading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : Form(
              child: Column(
                children: [
                  Image.asset(
                    'assets/images/login-cropped.png',
                  ),
                  Expanded(
                    child: Container(
                      height: double.infinity,
                      //  color: AppColors.LOGIN_PAGE_INPUTBOX_INPUTTEXT,
                      child: Center(
                        child: SingleChildScrollView(
                          scrollDirection: Axis.vertical,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 60, right: 60),
                            child: Column(
                              children: [
                                TextField(
                                  textInputAction: TextInputAction.next,
                                  onSubmitted: (value) async {
                                    FocusScope.of(context).unfocus();
                                    if (_userName.text == '') {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  'Username can\'t be empty')));
                                    } else if (_userName.text.length < 5) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content:
                                                  Text('Invalid user name')));
                                    } else if (_password.text == '') {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content: Text(
                                                  'Password can\'t be empty')));
                                    } else if (_password.text.length <= 7) {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(SnackBar(
                                              content:
                                                  Text('Invalid password')));
                                    } else {
                                      setState(() {
                                        _isLoading = true;
                                      });
                                      await AuthServices.login(context,
                                              userName: _userName.text.trim(),
                                              password: _password.text.trim())
                                          .whenComplete(() {
                                        setState(() {
                                          _isLoading = false;
                                        });
                                      }).onError((error, stackTrace) {
                                        setState(() {
                                          _isLoading = false;
                                        });
                                      });
                                    }
                                  },
                                  controller: _userName,
                                  style: TextStyle(
                                      color: Get.isDarkMode
                                          ? Colors.white
                                          : AppColors.LOGIN_PAGE_INPUTBOX_INPUTTEXT,
                                      fontFamily: 'Gotham',
                                      fontSize: 16,
                                      fontWeight: FontWeight.w400),
                                  decoration: const InputDecoration(
                                    labelText: 'Username',
                                    labelStyle: TextStyle(
                                        fontSize: 13,
                                        color: AppColors
                                            .LOGIN_PAGE_INPUTBOX_LABELTEXT,
                                        fontFamily: 'Gotham',
                                        fontWeight: FontWeight.w400),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColors
                                                .LOGIN_PAGE_INPUTBOX_UNDERLINE)),
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width *
                                          0.6,
                                      child: TextField(
                                        textInputAction: TextInputAction.next,
                                        onSubmitted: (value) async {
                                          FocusScope.of(context).unfocus();
                                          if (_userName.text == '') {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                                        'Username can\'t be empty')));
                                          } else if (_userName.text.length <
                                              5) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                                        'Invalid user name')));
                                          } else if (_password.text == '') {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                                        'Password can\'t be empty')));
                                          } else if (_password.text.length <=
                                              7) {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(SnackBar(
                                                    content: Text(
                                                        'Invalid password')));
                                          } else {
                                            setState(() {
                                              _isLoading = true;
                                            });
                                            await AuthServices.login(context,
                                                    userName:
                                                        _userName.text.trim(),
                                                    password:
                                                        _password.text.trim())
                                                .whenComplete(() {
                                              setState(() {
                                                _isLoading = false;
                                              });
                                            }).onError((error, stackTrace) {
                                              setState(() {
                                                _isLoading = false;
                                              });
                                            });
                                          }
                                        },
                                        controller: _password,
                                        style: TextStyle(
                                            color: Get.isDarkMode
                                                ? Colors.white
                                                : AppColors.LOGIN_PAGE_INPUTBOX_INPUTTEXT,
                                            fontFamily: 'Gotham',
                                            fontSize: 16,
                                            fontWeight: FontWeight.w400),
                                        obscureText: _isHidden,
                                        decoration: const InputDecoration(
                                          labelText: 'Password',
                                          labelStyle: TextStyle(
                                              fontSize: 13,
                                              color: AppColors
                                                  .LOGIN_PAGE_INPUTBOX_LABELTEXT,
                                              fontFamily: 'Gotham',
                                              fontWeight: FontWeight.w400),
                                          focusedBorder: UnderlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: AppColors
                                                      .LOGIN_PAGE_INPUTBOX_UNDERLINE)),
                                        ),
                                      ),
                                    ),
                                    GestureDetector(
                                      onTap: () {
                                        setState(() {
                                          _isHidden = !_isHidden;
                                        });
                                      },
                                      child: _isHidden
                                          ? Icon(Icons.visibility)
                                          : Icon(Icons.visibility_off),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                ForgotPassword()));
                                  },
                                  child: Container(
                                    width: double.infinity,
                                    child: Text(
                                      'Forgot Password',
                                      textAlign: TextAlign.end,
                                      style: TextStyle(
                                        fontSize: 13,
                                        color: AppColors.LOGIN_PAGE_LOGINBOX,
                                        fontFamily: 'Gotham',
                                        fontWeight: FontWeight.w400,
                                        fontStyle: FontStyle.italic,
                                      ),
                                    ),
                                  ),
                                ),
                                SizedBox(height: 60),
                                // ignore: deprecated_member_use
                                Container(
                                  width: double.infinity,
                                  child: FlatButton(
                                      shape: RoundedRectangleBorder(
                                          borderRadius:
                                              BorderRadius.circular(50)),
                                      color: AppColors.LOGIN_PAGE_LOGINBOX,
                                      onPressed: () async {
                                        FocusScope.of(context).unfocus();
                                        if (_userName.text == '') {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(
                                                      'Username can\'t be empty')));
                                        } else if (_userName.text.length < 5) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(
                                                      'Invalid user name')));
                                        } else if (_password.text == '') {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(
                                                      'Password can\'t be empty')));
                                        } else if (_password.text.length <= 7) {
                                          ScaffoldMessenger.of(context)
                                              .showSnackBar(SnackBar(
                                                  content: Text(
                                                      'Invalid password')));
                                        } else {
                                          setState(() {
                                            _isLoading = true;
                                          });
                                          await AuthServices.login(context,
                                                  userName:
                                                      _userName.text.trim(),
                                                  password:
                                                      _password.text.trim())
                                              .whenComplete(() {
                                            setState(() {
                                              _isLoading = false;
                                              _userName.clear();
                                              _password.clear();
                                            });
                                          }).onError((error, stackTrace) {
                                            print(error.toString());
                                            setState(() {
                                              _isLoading = false;
                                            });
                                          });
                                        }
                                      },
                                      child: Text(
                                        'SIGN IN',
                                        style: TextStyle(
                                            color: AppColors.white,
                                            fontFamily: 'Gotham',
                                            fontWeight: FontWeight.bold),
                                      )),
                                ),
                                SizedBox(
                                  height: 40,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Register()));
                                  },
                                  child: Text(
                                    'SIGN UP FOR AN ACCOUNT',
                                    style: TextStyle(
                                      fontSize: 13,
                                      color: AppColors.LOGIN_PAGE_NEWACCOUNT,
                                      fontFamily: 'Gotham',
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
                ],
              ),
            ),
    );
  }
}
