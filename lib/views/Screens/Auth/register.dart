import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:penny_chats/controllers/Api/AuthServices/AuthServices.dart';
import 'package:penny_chats/controllers/colors/colors.dart';
import 'package:penny_chats/views/Screen_Helper/Captcha/Captcha.dart';
import 'package:penny_chats/views/Screens/Auth/login.dart';
import 'package:penny_chats/views/Screens/ExtraScreens/terms&condition.dart';

class Register extends StatefulWidget {
  Register({Key? key}) : super(key: key);

  @override
  _RegisterState createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  bool _isChecked = false;
  bool _isLoading = false;
  bool _isHidden = true;

  TextEditingController _userName = TextEditingController();
  TextEditingController _pass = TextEditingController();
  TextEditingController _conPass = TextEditingController();

  TextEditingController _fullName = TextEditingController();
  TextEditingController _email = TextEditingController();

  @override
  void dispose() {
    _userName.dispose();
    _pass.dispose();
    _fullName.dispose();
    _email.dispose();
    _conPass.dispose();
    super.dispose();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
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
        title: Text(
          'Register',
          style: TextStyle(
              fontSize: 23.3,
              color: AppColors.white,
              fontFamily: 'Gotham',
              fontWeight: FontWeight.bold),
        ),
      ),
      body: _isLoading == true
          ? Center(
        child: CircularProgressIndicator(),
      )
          : Form(
        child: Column(
          children: [
            Container(
              height: 30,
            ),
            Expanded(
              child: Container(
                height: double.infinity,
                child: Center(
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    child: Padding(
                      padding: const EdgeInsets.only(left: 60, right: 60),
                      child: Column(
                        children: [
                          TextFormField(
                            controller: _fullName,
                            keyboardType: TextInputType.name,
                          inputFormatters: [ FilteringTextInputFormatter.allow(RegExp("[a-zA-Z]")), ],
                            style: TextStyle(
                                color: AppColors.REGISTER_PAGE_INPUT_TEXT,
                                fontFamily: 'Gotham',
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                            decoration: const InputDecoration(
                              labelText: 'Full Name',
                              labelStyle: TextStyle(
                                  fontSize: 13,
                                  color:
                                  AppColors.REGISTER_PAGE_LABEL_TEXT,
                                  fontFamily: 'Gotham',
                                  fontWeight: FontWeight.w500),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors
                                          .REGISTER_PAGE_LABEL_TEXT)),
                            ),
                            validator: (value) {},
                          ),
                          SizedBox(
                            height: 34,
                          ),
                          TextFormField(
                            controller: _userName,
                            style: TextStyle(
                                color: AppColors.REGISTER_PAGE_INPUT_TEXT,
                                fontFamily: 'Gotham',
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                            decoration: const InputDecoration(
                              labelText: 'Username',
                              labelStyle: TextStyle(
                                  fontSize: 13,
                                  color:
                                  AppColors.REGISTER_PAGE_LABEL_TEXT,
                                  fontFamily: 'Gotham',
                                  fontWeight: FontWeight.w500),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors
                                          .REGISTER_PAGE_LABEL_TEXT)),
                            ),
                            validator: (value) {},
                          ),
                          SizedBox(
                            height: 34,
                          ),
                          TextFormField(
                            keyboardType: TextInputType.emailAddress,
                            controller: _email,
                            style: TextStyle(
                                color: AppColors.REGISTER_PAGE_INPUT_TEXT,
                                fontFamily: 'Gotham',
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                            decoration: const InputDecoration(
                              labelText: 'Email',
                              labelStyle: TextStyle(
                                  fontSize: 13,
                                  color:
                                  AppColors.REGISTER_PAGE_LABEL_TEXT,
                                  fontFamily: 'Gotham',
                                  fontWeight: FontWeight.w500),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors
                                          .REGISTER_PAGE_LABEL_TEXT)),
                            ),
                            validator: (value) {},
                          ),
                          SizedBox(
                            height: 34,
                          ),
                          Row(
                            children: [
                              Container(
                                width: MediaQuery.of(context).size.width *
                                    0.6,
                                child: TextFormField(
                                  controller: _pass,
                                  obscureText: _isHidden,
                                  style: TextStyle(
                                      color: AppColors
                                          .REGISTER_PAGE_INPUT_TEXT,
                                      fontFamily: 'Gotham',
                                      fontSize: 16,
                                      fontWeight: FontWeight.bold),
                                  decoration: const InputDecoration(
                                    labelText: 'Password',
                                    labelStyle: TextStyle(
                                        fontSize: 13,
                                        color: AppColors
                                            .REGISTER_PAGE_LABEL_TEXT,
                                        fontFamily: 'Gotham',
                                        fontWeight: FontWeight.w500),
                                    focusedBorder: UnderlineInputBorder(
                                        borderSide: BorderSide(
                                            color: AppColors
                                                .REGISTER_PAGE_LABEL_TEXT)),
                                  ),
                                  validator: (value) {},
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
                            height: 34,
                          ),
                          TextFormField(
                            controller: _conPass,
                            obscureText: true,
                            style: TextStyle(
                                color: AppColors.REGISTER_PAGE_INPUT_TEXT,
                                fontFamily: 'Gotham',
                                fontSize: 16,
                                fontWeight: FontWeight.bold),
                            decoration: const InputDecoration(
                              labelText: 'Confirm Password',
                              labelStyle: TextStyle(
                                  fontSize: 13,
                                  color:
                                  AppColors.REGISTER_PAGE_LABEL_TEXT,
                                  fontFamily: 'Gotham',
                                  fontWeight: FontWeight.w500),
                              focusedBorder: UnderlineInputBorder(
                                  borderSide: BorderSide(
                                      color: AppColors
                                          .REGISTER_PAGE_LABEL_TEXT)),
                            ),
                            validator: (value) {},
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          Row(
                            // mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Checkbox(
                                  shape: RoundedRectangleBorder(
                                      borderRadius:
                                      BorderRadius.circular(5)),
                                  checkColor: AppColors.white,
                                  // fillColor: AppColors.FADE_TEXT_COLOR,
                                  activeColor:
                                  AppColors.LOGIN_PAGE_LOGINBOX,
                                  value: _isChecked,
                                  onChanged: (bool? value) {
                                    setState(() {
                                      _isChecked = value!;
                                    });
                                  }),
                              Flexible(
                                  child: GestureDetector(
                                    onTap: () {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (context) => Terms()));
                                    },
                                    child: Text(
                                      'I agree to the T&C',
                                      style: TextStyle(
                                          decoration:
                                          TextDecoration.underline,
                                          fontSize: 12.5,
                                          color:
                                          AppColors.LOGIN_PAGE_LOGINBOX,
                                          fontFamily: 'Gotham',
                                          fontWeight: FontWeight.w500),
                                    ),
                                  )),
                            ],
                          ),
                          SizedBox(
                            height: 90,
                          ),
                          Container(
                            width: double.infinity,
                            child: FlatButton(
                                shape: RoundedRectangleBorder(
                                    borderRadius:
                                    BorderRadius.circular(50)),
                                color: AppColors.LOGIN_PAGE_LOGINBOX,
                                onPressed: () async {
                                  FocusScope.of(context).unfocus();
                                  if (_fullName.text.trim() == '') {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                        content: Text(
                                            'Name can\'t be empty')));
                                  }else if (_userName.text.trim() == '') {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                        content: Text(
                                            'Username can\'t be empty')));
                                  } else if (_userName.text
                                      .trim()
                                      .length <
                                      5) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                        content: Text(
                                            'Atleast 5 characters username')));
                                  } else if (_email.text.trim() == '') {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                        content: Text(
                                            'Email can\'t be empty')));
                                  } else if (!_email.text.trim().contains(
                                    '@',
                                  ) ||
                                      !_email.text.trim().contains(
                                        '.',
                                      )) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                        content:
                                        Text('Invalid email')));
                                  } else if (_pass.text.trim() == '') {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                        content: Text(
                                            'Password can\'t be empty')));
                                  } else if (_pass.text.trim().length <
                                      8) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                        content: Text(
                                            'Atleast 8 characters password')));
                                  } else if (_pass.text.trim() !=
                                      _conPass.text.trim()) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                        content: Text(
                                            'Password not matched')));
                                  } else if (_isChecked != true) {
                                    ScaffoldMessenger.of(context)
                                        .showSnackBar(SnackBar(
                                        content:
                                        Text('Agree to T&C')));
                                  } else {
                                    setState(() {
                                      _isLoading = true;
                                    });
                                 await   Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => Captcha()));
                                    AuthServices.createAccount(context,
                                        userName:
                                        _userName.text.trim(),
                                        password: _pass.text.trim(),
                                        email: _email.text.trim(),
                                        fullName: _fullName.text)
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
                                child:  Text(
                                  'REGISTER',
                                  style: TextStyle(
                                    color: AppColors.white,
                                    fontFamily: 'Gotham',
                                    fontWeight: FontWeight.bold,
                                  ),
                                )),
                          ),
                          SizedBox(
                            height: 40,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                'ALREADY HAVE ACCOUNT?',
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
              ),
            ),
          ],
        ),
      ),
    );
  }
}