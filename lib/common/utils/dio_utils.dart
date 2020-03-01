import 'dart:math';

import 'package:dio/dio.dart';
import 'dart:convert';
import 'package:cookie_jar/cookie_jar.dart';
import 'package:dio_cookie_manager/dio_cookie_manager.dart';
import 'package:flutter/cupertino.dart';

import '../app.dart';

class DioUtils {
  static DioUtils _instance;

  static DioUtils getInstance() {
    if (_instance == null) {
      _instance = DioUtils();
    }
    return _instance;
  }

  Dio dio = Dio();

  DioUtils() {
    // set default configs
    dio.options.headers = {
      "version": '2.0.9',
      "Authorization": '_token',
    };
    dio.options.baseUrl = "https://jsonplaceholder.typicode.com";
    dio.options.connectTimeout = 5000;
    dio.options.receiveTimeout = 3000;
    // whether enable request log
    dio.interceptors.add(LogInterceptor(responseBody: GlobalConfig.isDebug));
    // cache related classes
    dio.interceptors.add(CookieManager(CookieJar()));
  }

  /// get request
  get({
    @required String endPoint,
    @required Map params,
    @required Function onResponse,
    @required Function onFailure,
  }) async {
    _requestHttp(endPoint, onResponse, 'get', params, onFailure);
  }

  /// post request
  /// not tested because it has not been used yet
  /// if anyone needs to use it, can notify me
  post(String url, params, Function successCallBack,
      Function errorCallBack) async {
    _requestHttp(url, successCallBack, "post", params, errorCallBack);
  }

  _requestHttp(String url, Function successCallBack,
      [String method, Map params, Function errorCallBack]) async {
    Response response;
    try {
      if (method == 'get') {
        if (params != null && params.isNotEmpty) {
          response = await dio.get(url, queryParameters: params);
        } else {
          response = await dio.get(url);
        }
      } else if (method == 'post') {
        if (params != null && params.isNotEmpty) {
          response = await dio.post(url, data: params);
        } else {
          response = await dio.post(url);
        }
      }
    } on DioError catch (error) {
      _error(errorCallBack, error.message);
      return '';
    }
    String dataStr = json.encode(response.data);
    successCallBack(dataStr);
  }

  _error(Function errorCallBack, String error) {
    if (errorCallBack != null) {
      errorCallBack(error);
    }
  }
}
