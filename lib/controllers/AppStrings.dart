import 'package:html/parser.dart';
import 'package:intl/intl.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../ApiService/Apiservice.dart';

class AppStrings {



  static const String baseUrl = 'https://pennychats.com/pennychatapi';
  static const String loginApi = '/login/index';
  static const String regApi = '/pennychatapi/login/registration';
  static const String firebaseProjectId = 'PennyChats1';
  static const String disclaimerApi =
      '$baseUrl/cms/disclaimer';
  static const String getUserDataApi =
      '$baseUrl/post/userdetails/';

  static const String getLatestPostApi =
      '$baseUrl/dashboard/latestpost';
  static const String getPopularPostApi =
      '$baseUrl/dashboard/popularpost';

  static const getFavouritePostApi =
      '$baseUrl/dashboard/favouritepost';

  static const getNotificationApi =
      '$baseUrl/users/notification_list';

  static const getMainNotificationApi =
      '$baseUrl/dashboard/notification';

  static const getWeeklyWatchApi =
      '$baseUrl/dashboard/weeklywatch';

  static const getUserPostApi =
      '$baseUrl/post/user_post/';
  static const profilePictureApi =
      'https://www.pennychats.com/uploads/profile_pictures';
  static const noProfilePicture =
      'https://static.wikia.nocookie.net/itstabletoptime/images/b/b5/Default.jpg/revision/latest?cb=20210606184459';
  static const stockNewsPicture =
      'https://www.pennychats.com/beta/uploads/stocknews';

  static DateFormat dateFormat = DateFormat('yyyy-MM-dd – kk:mm');

  static String parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString =
        parse(document.body!.text).documentElement!.text;

    return parsedString;
  }
}
