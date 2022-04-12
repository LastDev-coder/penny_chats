import 'package:html/parser.dart';
import 'package:intl/intl.dart';

class AppStrings {
  static const String baseUrl = 'https://pennychats.com/pennychatapi';
  static const String loginApi = '/login/index';
  static const String regApi = '/pennychatapi/login/registration';
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
      '$baseUrl/dashboard/notification';

  static const getWeeklyWatchApi =
      '$baseUrl/dashboard/weeklywatch';

  static const profilePictureApi =
      'https://www.pennychats.com/beta/uploads/profile_pictures';

  static DateFormat dateFormat = DateFormat('yyyy-MM-dd – kk:mm');

  static String parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString =
        parse(document.body!.text).documentElement!.text;

    return parsedString;
  }
}
