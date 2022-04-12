
import 'dart:convert';
import 'dart:io';

import 'package:dio/dio.dart';
import 'package:http_parser/http_parser.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart' as clint;
import 'package:http/http.dart' as http;


class Apiservice {
  Dio dio = new Dio();

  Future getfaqs() async {
    late String url = "https://pennychats.com/pennychatapi/cms/faq";
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    Dio dio = new Dio();
    dio.options.headers["authentication-token"] = token;
    clint.Response response = await dio.get(url);
    return response.data;
  }

  Future getTrading() async {
    late String url = "https://pennychats.com/pennychatapi/cms/trading";
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    Dio dio = new Dio();
    dio.options.headers["authentication-token"] = token;
    clint.Response response = await dio.get(url);
    return response.data;
  }

  Future getStocktoWatch(String id) async {
    late String url =
        "https://pennychats.com/pennychatapi/pennystocks/lists/$id";
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    Dio dio = new Dio();
    dio.options.headers["authentication-token"] = token;
    clint.Response response = await dio.get(url);
    return response.data;
  }

  Future StockAlert() async {
    late String url =
        "https://pennychats.com/pennychatapi/dashboard/stocktrade";
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

    Dio dio = new Dio();
    dio.options.headers["authentication-token"] = token;
    clint.Response response = await dio.get(url);
    return response.data;
  }

  Future getTestimonial() async {
    late String url = "https://pennychats.com/pennychatapi/cms/testimonial";
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';

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
        "https://pennychats.com/pennychatapi/users/userdetails/$id";
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
        "https://pennychats.com/pennychatapi/users/user_fav_posts/$id/$postid";
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
        "https://pennychats.com/pennychatapi/users/user_unfav_posts/$id/$postid";
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
          "https://pennychats.com/pennychatapi/testimonial/add_testimonial/$id",
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
        "https://pennychats.com/pennychatapi/users/edit_profile/$id",
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
          "https://pennychats.com/pennychatapi/users/add_stock/$id",
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
          "https://pennychats.com/pennychatapi/users/add_weekly_watch/$id",
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
          "https://pennychats.com/pennychatapi/contact/contact_us",
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
          "https://pennychats.com/pennychatapi/post/add_comments/$id",
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
    // print("id => $id ");
    late String url =
        "https://pennychats.com/pennychatapi/post/details/$postid/$id";
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
          "https://pennychats.com/pennychatapi/login/change_password",
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
          "https://pennychats.com/pennychatapi/post/add_post/$id",
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
    http.MultipartRequest('POST', Uri.parse('https://pennychats.com/pennychatapi/users/img_upload/$id'));
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
        "https://pennychats.com/pennychatapi/users/userdetails/$userid";
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
        "https://pennychats.com/pennychatapi/pennystocks/details/$posttitle";
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
          "https://pennychats.com/pennychatapi/pennystocks/add_comments",
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

}
