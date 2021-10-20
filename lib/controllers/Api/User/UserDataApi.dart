import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:penny_chats/controllers/Api/PostAPI/LatestPostApi.dart';
import 'package:penny_chats/models/PostUserDataModel.dart';
import 'package:shared_preferences/shared_preferences.dart';

class UserDataApi {
  static Future<PostUserDataModel?> getUserData(context, String api) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var token = _prefs.getString('token');
    PostUserDataModel? userData;
    var response = await http
        .get(Uri.parse(api), headers: {"authentication-token": "$token"});
    var responseBody = json.decode(response.body);
    print(responseBody);
    if (responseBody['status'] = true) {
      userData = postUserDataModelFromJson(response.body);
      return userData;
    } else {
      showAlertDialog(context);
    }
  }
}
