import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:penny_chats/controllers/AppStrings.dart';
import 'package:penny_chats/controllers/Api/PostAPI/LatestPostApi.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DisclaimerApi {
  static Future<String?> getDisclaimer(context) async {
    String? _disclaimer;
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var token = _prefs.getString('token');
    var response = await http.get(Uri.parse(AppStrings.disclaimerApi),
        headers: {"authentication-token": "$token"});
    var responseBody = json.decode(response.body);

    if (responseBody['status'] == true) {
      _disclaimer = responseBody['response'][0]['content'];
    } else {
      showAlertDialog(context);
    }
    return _disclaimer;
  }
}
