import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:penny_chats/controllers/AppStrings.dart';
import 'package:penny_chats/views/Screens/Auth/login.dart';
import 'package:penny_chats/views/Screens/mydashboard.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AuthServices {
  static Future login(context,
      {required String userName, required String password}) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();

    var _data = new Map<String, dynamic>();
    _data['username'] = '$userName';
    _data['password'] = '$password';
print("-------------------");
    var response = await http.post(
      Uri.parse(
        'https://pennychats.com/pennychatapi/login/index',
      ),
      body: _data,
    );
    print("++++++++++++++++++");

    print("=========================>>${response.body}");
    var responseData = json.decode(response.body);
    if (responseData['status'] == true) {
      print(responseData['response']['token']);
      print(responseData['response']['pid']);

      _prefs.setString('token', responseData['response']['token']);
      _prefs.setString('id', responseData['response']['pid']);

      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Mydashboard(number: 0,)));
      print(response.body);
    } else {
      print(response.body);
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Username or Password wrong, try again')));
    }
  }

  static Future createAccount(context,
      {required String userName,
        required String password,
        required String email,
        required String fullName}) async {
    var _data = new Map<String, dynamic>();
    _data['full_name'] = '$fullName';
    _data['email'] = '$email';
    _data['username'] = '$userName';
    _data['password'] = '$password';

    var response = await http.post(
      Uri.parse(
        'https://pennychats.com/pennychatapi/login/registration',

      ),
      body: _data,
    );
    var responseData = json.decode(response.body);
    if (responseData['status'] == true) {
      Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => Login()));
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('User already exist')));
    }
  }
}