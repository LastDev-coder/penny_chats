import 'package:html/parser.dart';
import 'package:intl/intl.dart';

class AppStrings {
  static const String baseUrl = 'pennychats.com';
  static const String loginApi = '/pennychatapi/login/index';
  static const String regApi = '/pennychatapi/login/registration';
  static const String disclaimerApi =
      'https://pennychats.com/pennychatapi/cms/disclaimer';
  static const String getUserDataApi =
      'https://pennychats.com/pennychatapi/post/userdetails/';

  static const String getLatestPostApi =
      'https://pennychats.com/pennychatapi/dashboard/latestpost';
  static const String getPopularPostApi =
      'https://pennychats.com/pennychatapi/dashboard/popularpost';

  static const getFavouritePostApi =
      'https://pennychats.com/pennychatapi/dashboard/favouritepost';

  static const getNotificationApi =
      'https://pennychats.com/pennychatapi/dashboard/notification';

  static const getWeeklyWatchApi =
      'https://pennychats.com/pennychatapi/dashboard/weeklywatch';

  static DateFormat dateFormat = DateFormat('yyyy-MM-dd – kk:mm');

  static String parseHtmlString(String htmlString) {
    final document = parse(htmlString);
    final String parsedString =
        parse(document.body!.text).documentElement!.text;

    return parsedString;
  }
}
