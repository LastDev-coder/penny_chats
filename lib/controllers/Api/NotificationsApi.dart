import 'dart:convert';
import 'package:penny_chats/models/NotificationsModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'PostAPI/LatestPostApi.dart';

class NotificationsApi {
  static Future<NotificationsModel?> getNotification(
      context, String api) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var token = _prefs.getString('token');
    NotificationsModel? notificationsList;
    var response = await http
        .get(Uri.parse(api), headers: {"authentication-token": "$token"});
    var responseBody = json.decode(response.body);
    print(responseBody);
    if (responseBody['status'] = true) {
      notificationsList = notificationsModelFromJson(response.body);
      return notificationsList;
    } else {
      showAlertDialog(context);
    }
  }
}
