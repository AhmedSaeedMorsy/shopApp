import 'package:dio/dio.dart';

class DioHelper {
  static late Dio dio;

  static init() {
    dio = Dio(
      BaseOptions(
        baseUrl: "https://student.valuxapps.com/api/",
        receiveDataWhenStatusError: true,
      ),
    );
  }

  static Future<Response> postData({
    required String url,
    Map<String,dynamic> ? query,
    String ? token ,
    required Map<String, dynamic> data,
  }) async {
    return dio.post(url, data: data,);
  }

  static Future<Response> getData({
    required String url,
    String lang ='en',
    Map<String,dynamic> ? query,
    String ? token,
  })async {
    dio.options.headers= {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token,
    };
    return await dio.get(
      url,
      queryParameters: query,
    );
  }
    static Future<Response> putData({
    required String url,
    Map<String,dynamic> ? query,
    String lang ='en',
    String ? token ,
    required Map<String, dynamic> data,
  }) async {
    dio.options.headers= {
      'Content-Type': 'application/json',
      'lang': lang,
      'Authorization': token,
    };
    return dio.put(url, data: data,);
  }
}
