import 'dart:convert';
import 'package:penny_chats/controllers/Api/PostAPI/LatestPostApi.dart';
import 'package:penny_chats/models/WeeklyWatchModel.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;

class WeeklyWatchApi {
  static Future<WeeklyWatchModel?> getWeeklyWatch(context, String api) async {
    SharedPreferences _prefs = await SharedPreferences.getInstance();
    var token = _prefs.getString('token');
    WeeklyWatchModel? weeklyWatchList;

    var response = await http
        .get(Uri.parse(api), headers: {"authentication-token": "$token"});
    var responseBody = json.decode(response.body);
    print(responseBody);
    if (responseBody['status'] = true) {
      weeklyWatchList = weeklyWatchModelFromJson(response.body);
      return weeklyWatchList;
    } else {
      showAlertDialog(context);
    }
  }
}
