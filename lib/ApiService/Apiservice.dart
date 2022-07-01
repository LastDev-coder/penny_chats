
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:penny_chats/controllers/AppStrings.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart' as clint;
import 'package:http/http.dart' as http;


class Apiservice {
  Dio dio = new Dio();

  Future postfpassword(String name) async {

    Dio dio = new Dio();
    clint.Response response;
    var _data = new Map<String, dynamic>();
    _data['username'] = '$name';


    try {
      response = await dio.post(
          "${AppStrings.baseUrl}/login/forgot",
          data: _data,
          options: Options(headers: {
            "Accept": "application/json",
            "Content-Type": "application/x-www-form-urlencoded",
          }));

      print('response : ${response.data}');
      return response.data;
    } catch (e) {
      print('Error : $e');
    }

  }

  Future getfaqs() async {
    late String url = "${AppStrings.baseUrl}/cms/faq";
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    Dio dio = new Dio();
    dio.options.headers["authentication-token"] = token;
    clint.Response response = await dio.get(url);
    return response.data;
  }

  Future getTrading() async {
    late String url = "${AppStrings.baseUrl}/cms/trading";
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    Dio dio = new Dio();
    dio.options.headers["authentication-token"] = token;
    clint.Response response = await dio.get(url);
    return response.data;
  }

  Future getStocktoWatch(String id) async {
    late String url =
        "${AppStrings.baseUrl}/pennystocks/lists/$id";
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    Dio dio = new Dio();
    dio.options.headers["authentication-token"] = token;
    clint.Response response = await dio.get(url);
    return response.data;
  }

  Future StockAlert() async {
    late String url =
        "${AppStrings.baseUrl}/dashboard/stocktrade";
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    Dio dio = new Dio();
    dio.options.headers["authentication-token"] = token;
    clint.Response response = await dio.get(url);
    return response.data;
  }

  Future getTestimonial() async {
    // https://pennychats.com/pennychatapi/testimonial/lists/$userid – get
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    final id = prefs.getString('id') ?? '';
    print('my id -> $id');
    print('my token -> $token');

    late String url = "${AppStrings.baseUrl}/testimonial/lists/$id";

    Dio dio = new Dio();
    dio.options.headers["authentication-token"] = token;
    clint.Response response = await dio.get(url);
    return response.data;
  }

  Future getprofile() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    final id = prefs.getString('id') ?? '';
    print("id => $id ");
    late String url =
        "${AppStrings.baseUrl}/users/userdetails/$id";
    Dio dio = new Dio();
    dio.options.headers["authentication-token"] = token;
    clint.Response response = await dio.get(url);
    return response.data;
  }

  Future getlike(String postid) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    final id = prefs.getString('id') ?? '';
    print("id => $id ");
    late String url =
        "${AppStrings.baseUrl}/users/user_fav_posts/$id/$postid";
    Dio dio = new Dio();
    dio.options.headers["authentication-token"] = token;
    clint.Response response = await dio.get(url);
    return response.data;
  }


  Future getdislike(String postid) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    final id = prefs.getString('id') ?? '';
    print("id => $id ");
    late String url =
        "${AppStrings.baseUrl}/users/user_unfav_posts/$id/$postid";
    Dio dio = new Dio();
    dio.options.headers["authentication-token"] = token;
    clint.Response response = await dio.get(url);
    return response.data;
  }


  Future getOnlineUser() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    final id = prefs.getString('id') ?? '';
    late String url =
        "https://pennychats.com/pennychatapi/chat/Chat_online_user";
    Dio dio = new Dio();
    dio.options.headers["authentication-token"] = token;
    clint.Response response = await dio.get(url);
    return response.data;
  }


  Future  sendMessage(var text) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    final id = prefs.getString('id') ?? '';

    //  late String url = "https://pennychats.com/pennychatapi/chat/send_msg/$id";
    late String url = "https://pennychats.com/pennychatapi/chat/send_msg/  ";
    Dio dio = new Dio();

    var json = {"txt":text,"userid":id};
    dio.options.headers["authentication-token"] = token;
    clint.Response response = await dio.post(url,data: json);
    return response.data;
  }


  Future  getSearchData(String text) async {
    try {
      final prefs = await SharedPreferences.getInstance();
      final token = prefs.getString('token') ?? '';
      final id = prefs.getString('id') ?? '';
      late String url =
          "https://pennychats.com/pennychatapi/users/search/$id";
      Dio dio = new Dio();
      var json = {"srch":text};
      dio.options.headers["authentication-token"] = token;
      dio.options.headers["Content-Type"] =  "application/x-www-form-urlencoded";

      clint.Response response = await dio.post(url,data: json);
      return response.data;
    } catch (e) {
      print(e);

    }
  }


  getMessages(String messageId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    final id = prefs.getString('id') ?? '';
    late String url =
        "https://pennychats.com/pennychatapi/chat/chat_msg_all/$id";
    Dio dio = new Dio();
    dio.options.headers["authentication-token"] = token;


    clint.Response response = await dio.get(url);
    return response.data;
  }


  getCurrentMessages(String messageId) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    final id = prefs.getString('id') ?? '';
    late String url =
        "https://pennychats.com/pennychatapi/chat/next_chat_msg_all/$messageId";
    Dio dio = new Dio();
    dio.options.headers["authentication-token"] = token;


    clint.Response response = await dio.get(url);
    return response.data;
  }

  Future postTestimonial(String text) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    final id = prefs.getString('id') ?? '';
    print("id => $id ");
    Dio dio = new Dio();
    clint.Response response;
    var _data = new Map<String, dynamic>();
    _data['content'] = '$text';
    try {
      response = await dio.post(
          "${AppStrings.baseUrl}/testimonial/add_testimonial/$id",
          data: _data,
          options: Options(headers: {
            "Accept": "application/json",
            "Content-Type": "application/x-www-form-urlencoded",
            "authentication-token": token
          }));

      print('response : ${response.data}');
      return response.data;
    } catch (e) {
      print('Error : $e');
    }
  }

  Future postUsername(var _data) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    final id = prefs.getString('id') ?? '';
    print("id => $id ");
    Dio dio = new Dio();
    clint.Response response;
    try {
      response = await dio.post(
          "${AppStrings.baseUrl}/users/edit_profile/$id",
          data: _data,
          options: Options(headers: {
            "Accept": "application/json",
            "Content-Type": "application/x-www-form-urlencoded",
            "authentication-token": token
          }));

      print('response : ${response.data}');
      return response.data;
    } catch (e) {
      print('Error : $e');
    }
  }
  Future AddStock(var _data) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    final id = prefs.getString('id') ?? '';
    print("id => $id ");
    Dio dio = new Dio();
    clint.Response response;

    try {
      response = await dio.post(
          "${AppStrings.baseUrl}/users/add_stock/$id",
          data: _data,
          options: Options(headers: {
            "Accept": "application/json",
            "Content-Type": "application/x-www-form-urlencoded",
            "authentication-token": token
          }));

      print('response : ${response.data}');
      return response.data;
    } catch (e) {
      print('Error : $e');
    }
  }
  Future AddWatch(var _data) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    final id = prefs.getString('id') ?? '';
    print("id => $id ");
    Dio dio = new Dio();
    clint.Response response;

    try {
      response = await dio.post(
          "${AppStrings.baseUrl}/users/add_weekly_watch/$id",
          data: _data,
          options: Options(headers: {
            "Accept": "application/json",
            "Content-Type": "application/x-www-form-urlencoded",
            "authentication-token": token
          }));

      print('response : ${response.data}');
      return response.data;
    } catch (e) {
      print('Error : $e');
    }
  }

  Future ContactUs(var _data) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    final id = prefs.getString('id') ?? '';
    print("id => $id ");
    Dio dio = new Dio();
    clint.Response response;

    try {
      response = await dio.post(
          "${AppStrings.baseUrl}/contact/contact_us",
          data: _data,
          options: Options(headers: {
            "Accept": "application/json",
            "Content-Type": "application/x-www-form-urlencoded",
            "authentication-token": token
          }));

      print('response : ${response.data}');
      return response.data;
    } catch (e) {
      print('Error : $e');
    }
  }

  Future PostComment(var _data) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    final id = prefs.getString('id') ?? '';
    print("id => $id ");
    Dio dio = new Dio();
    clint.Response response;

    try {
      response = await dio.post(
          "${AppStrings.baseUrl}/post/add_comments/$id",
          data: _data,
          options: Options(headers: {
            "Accept": "application/json",
            "Content-Type": "application/x-www-form-urlencoded",
            "authentication-token": token
          }));

      print('response : ${response.data}');
      return response.data;
    } catch (e) {
      print('Error : $e');
    }
  }

  Future getPostDetails(String postid) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    final id = prefs.getString('id') ?? '';
    print("=============p==========");
    late String url =
        "${AppStrings.baseUrl}/post/details/$postid/$id";
    Dio dio = new Dio();
    dio.options.headers["authentication-token"] = token;
    clint.Response response = await dio.get(url);
    return response.data;
  }

  Future PostChangePassword(String password, String Cpassword) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    final id = prefs.getString('id') ?? '';
    print("id => $id ");
    Dio dio = new Dio();
    clint.Response response;

    var _data = new Map<String, dynamic>();
    _data['password'] = password;
    _data['confirm_password'] = Cpassword;
    _data['user_id'] = id;

    try {
      response = await dio.post(
          "${AppStrings.baseUrl}/login/change_password",
          data: _data,
          options: Options(headers: {
            "Accept": "application/json",
            "Content-Type": "application/x-www-form-urlencoded",
            "authentication-token": token
          }));

      print('response : ${response.data}');
      return response.data;
    } catch (e) {
      print('Error : $e');
    }
  }

  Future UploadPost(var _data) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    final id = prefs.getString('id') ?? '';
    print("id => $id ");
    Dio dio = new Dio();
    clint.Response response;

    try {
      response = await dio.post(
          "${AppStrings.baseUrl}/post/add_post/$id",
          data: _data,
          options: Options(headers: {
            "Accept": "application/json",
            "Content-Type": "application/x-www-form-urlencoded",
            "authentication-token": token
          }));

      print('response : ${response.data}');
      return response.data;
    } catch (e) {
      print('Error : $e');
    }
  }




  Future uploadImage(filepath) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    final id = prefs.getString('id') ?? '';
    print("id -> $id");
    var request =
    http.MultipartRequest('POST', Uri.parse('${AppStrings.baseUrl}/users/img_upload/$id'));
    request.files.add(http.MultipartFile('profile_pic',
        File(filepath).readAsBytes().asStream(), File(filepath).lengthSync(),
        filename: filepath.split("/").last));
    // request.fields.addAll(d);
    request.headers['authentication-token'] = "$token";
    // request.headers['user_id'] = "$id";

    var res = await request.send();
    var dataEnd = await res.stream.bytesToString();
    return json.decode(dataEnd);
  }

  Future getOthersprofile(String userid) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    late String url =
        "${AppStrings.baseUrl}/users/userdetails/$userid";
    Dio dio = new Dio();
    dio.options.headers["authentication-token"] = token;
    clint.Response response = await dio.get(url);
    return response.data;
  }
  Future getPostDetailsPennyPlay(String posttitle) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    final id = prefs.getString('id') ?? '';
    // print("id => $id ");
    late String url =
        "${AppStrings.baseUrl}/pennystocks/details/$posttitle";
    Dio dio = new Dio();
    dio.options.headers["authentication-token"] = token;
    clint.Response response = await dio.get(url);
    return response.data;
  }
  Future PostCommentPennyPlay(var _data) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    final id = prefs.getString('id') ?? '';
    print("id => $id ");
    Dio dio = new Dio();
    clint.Response response;

    try {
      response = await dio.post(
          "${AppStrings.baseUrl}/pennystocks/add_comments",
          data: _data,
          options: Options(headers: {
            "Accept": "application/json",
            "Content-Type": "application/x-www-form-urlencoded",
            "authentication-token": token
          }));

      print('response : ${response.data}');
      return response.data;
    } catch (e) {
      print('Error : $e');
    }
  }
  Future getDeleteNotification(String nid) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    final id = prefs.getString('id') ?? '';
    // print("id => $id ");
    late String url =
        "${AppStrings.baseUrl}/users/user_del_notification/$id/$nid";
    // https://pennychats.com/pennychatapi/users/user_del_notification/$userid/$notification_id
    Dio dio = new Dio();
    dio.options.headers["authentication-token"] = token;
    clint.Response response = await dio.get(url);
    return response.data;
  }
  Future getNotificationEnable() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    final id = prefs.getString('id') ?? '';
    // print("id => $id ");
    late String url =
        "${AppStrings.baseUrl}/users/user_notienabledisable/$id";
    Dio dio = new Dio();
    dio.options.headers["authentication-token"] = token;
    clint.Response response = await dio.get(url);
    return response.data;
  }
  Future postReportMessage(var _data) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    final id = prefs.getString('id') ?? '';
    print("id => $id ");
    Dio dio = new Dio();
    clint.Response response;

    try {
      response = await dio.post(
          "${AppStrings.baseUrl}/chat/report_msg/",
          data: _data,
          options: Options(headers: {
            "Accept": "application/json",
            "Content-Type": "application/x-www-form-urlencoded",
            "authentication-token": token
          }));

      print('response : ${response.data}');
      return response.data;
    } catch (e) {
      print('Error : $e');
    }
  }
  Future getLogout() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    final id = prefs.getString('id') ?? '';
    // print("id => $id ");
    late String url =
        "${AppStrings.baseUrl}/login/logout/$id";
    Dio dio = new Dio();
    dio.options.headers["authentication-token"] = token;
    clint.Response response = await dio.get(url);
    return response.data;
  }

  Future getCommentDelete(String mid) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    // print("id => $id ");
    late String url =
        "${AppStrings.baseUrl}/post/Delete_comment/$mid ";
    Dio dio = new Dio();
    dio.options.headers["authentication-token"] = token;
    clint.Response response = await dio.get(url);
    return response.data;
  }
  Future getPostdetails(String pid) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    final id = prefs.getString('id') ?? '';
    late String url =
        "https://pennychats.com/pennychatapi/chat/Chat_online_user";
    Dio dio = new Dio();
    dio.options.headers["authentication-token"] = token;
    clint.Response response = await dio.get(url);
    return response.data;
  }

  Future postDeleteMessage(var _data) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    final id = prefs.getString('id') ?? '';
    print("id => $id ");
    Dio dio = new Dio();
    clint.Response response;

    try {
      response = await dio.post(
          "${AppStrings.baseUrl}/chat/delete_msg",
          data: _data,
          options: Options(headers: {
            "Accept": "application/json",
            "Content-Type": "application/x-www-form-urlencoded",
            "authentication-token": token
          }));

      print('response : ${response.data}');
      return response.data;
    } catch (e) {
      print('Error : $e');
    }
  }
  Future getUserActivity(String status) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    final id = prefs.getString('id') ?? '';
    // print("id => $id ");
    // https://pennychats.com/pennychatapi/users/user_idletimeupdate/$user_id/$status(1 or 2) ----- get
    late String url =
        "${AppStrings.baseUrl}/users/user_idletimeupdate/$id/$status";
    Dio dio = new Dio();
    dio.options.headers["authentication-token"] = token;
    clint.Response response = await dio.get(url);
    return response.data;
  }

  Future getUserDelete() async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    final id = prefs.getString('id') ?? '';
        late String url =
        "${AppStrings.baseUrl}/users/user_del_profile/$id";
    Dio dio = new Dio();
    dio.options.headers["authentication-token"] = token;
    clint.Response response = await dio.get(url);
    return response.data;
  }
  Future getSearchUserDetails(String userid) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    late String url =
        "${AppStrings.baseUrl}/users/userprofile/$userid";
    Dio dio = new Dio();
    dio.options.headers["authentication-token"] = token;
    clint.Response response = await dio.get(url);
    return response.data;
  }
  Future getPostDelete(String postid) async {
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';
    late String url =
        "${AppStrings.baseUrl}/post/Delete_post/$postid";
    Dio dio = new Dio();
    dio.options.headers["authentication-token"] = token;
    clint.Response response = await dio.get(url);
    return response.data;
  }
}
