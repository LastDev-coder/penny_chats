import 'dart:convert';
import 'dart:io';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:penny_chats/models/LatestPostModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class LatestPostApi {
  static Future<LatestPostModel?> getLatestPost(context, String api) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var token = _prefs.getString('token');
    final prefs = await SharedPreferences.getInstance();
    final id = prefs.getString('id') ?? '';
    final id = _prefs.getString('id') ?? '';

    LatestPostModel? latestPostData;
    var response = await http
        .get(Uri.parse("$api/$id"), headers: {"authentication-token": "$token"});
        .get(Uri.parse('${api}/${id}'), headers: {"authentication-token": "$token"});
    var responseBody = json.decode(response.body);
    print("--------------latest post-------------");
    print(responseBody);
    print("--------------------------------------");

    if (responseBody['status'] = true) {
      latestPostData = latestPostModelFromJson(response.body);
      return latestPostData;
    } else {
      showAlertDialog(context);
    }
  }
}

showAlertDialog(BuildContext context) {
  // set up the button
  Widget okButton = TextButton(
    child: Text("OK"),
    onPressed: () {
      exit(1);
    },
  );

  // set up the AlertDialog
  AlertDialog alert = AlertDialog(
    title: Text("Something went wrong"),
    content: Text("Please try again later."),
    actions: [
      okButton,
    ],
  );

  // show the dialog
  showDialog(
    context: context,
    builder: (BuildContext context) {
      return alert;
    },
  );
}
