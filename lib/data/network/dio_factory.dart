import 'package:advanced_course_udemy/app/app_prefs.dart';
import 'package:advanced_course_udemy/app/constant.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:pretty_dio_logger/pretty_dio_logger.dart';

const String applicationJson = 'application/json';
const String contentType = 'Content-Type';
const String accept = 'Accept';
const String authorization = 'Authorization';
const String defaultLanguage = 'language';

class DioFactory {
  final AppPrefs _appPrefs;

  DioFactory(this._appPrefs);

  Future<Dio> getDio() async {
    Dio dio = Dio();
    int timeOut = 60 * 1000; // 1 minute
    String language = await _appPrefs.getAppLanguage();
    Map<String, dynamic> headers = {
      contentType: applicationJson,
      accept: applicationJson,
      authorization: Constant.token,
      defaultLanguage: language
    };

    dio.options = BaseOptions(
      baseUrl: Constant.baseUrl,
      connectTimeout: Duration(milliseconds: timeOut),
      receiveTimeout: Duration(milliseconds: timeOut),
      headers: headers,
    );

    if (kReleaseMode) {
      print('Release Mode no logs');
    } else {
      dio.interceptors.add(PrettyDioLogger(
        requestHeader: true,
        requestBody: true,
        responseHeader: true,
      ));
    }
    return dio;
  }
}
