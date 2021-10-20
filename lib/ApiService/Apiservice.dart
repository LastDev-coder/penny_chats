
import 'package:dio/dio.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:dio/dio.dart' as clint;

class Apiservice{
  
  Dio dio = new Dio();

  Future getfaqs() async{
  late String url="https://pennychats.com/pennychatapi/cms/faq";
  final prefs = await SharedPreferences.getInstance();
  final token = prefs.getString('token') ?? '';
  
     
    Dio dio = new Dio();
    dio.options.headers["authentication-token"] = token;
    clint.Response response = await dio.get(url);
    return response.data;

  }
  Future getTrading() async{
    late String url="https://pennychats.com/pennychatapi/cms/trading";
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';


    Dio dio = new Dio();
    dio.options.headers["authentication-token"] = token;
    clint.Response response = await dio.get(url);
    return response.data;

  }

  Future getStocktoWatch(String id) async{
    late String url="https://pennychats.com/pennychatapi/pennystocks/lists/$id";
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';


    Dio dio = new Dio();
    dio.options.headers["authentication-token"] = token;
    clint.Response response = await dio.get(url);
    return response.data;

  }

  Future StockAlert() async{
    late String url="https://pennychats.com/pennychatapi/dashboard/stocktrade";
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';


    Dio dio = new Dio();
    dio.options.headers["authentication-token"] = token;
    clint.Response response = await dio.get(url);
    return response.data;

  }

  Future getTestimonial() async{
    late String url="https://pennychats.com/pennychatapi/cms/testimonial";
    final prefs = await SharedPreferences.getInstance();
    final token = prefs.getString('token') ?? '';


    Dio dio = new Dio();
    dio.options.headers["authentication-token"] = token;
    clint.Response response = await dio.get(url);
    print(response.data);
    return response.data;

  }


  }