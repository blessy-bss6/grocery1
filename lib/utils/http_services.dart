import 'dart:convert';

import 'package:groce1/utils/common.dart';

import '../Backend/Resp/reg_login_resp.dart';
import '../main.dart';
import '../utils/shared_preferences.dart';

import '../Backend/Model/user.dart';

import 'package:dio/dio.dart';
import 'package:flutter/cupertino.dart';

// 1 Get Request Again
Future getDioRequest(String url,
    {dynamic data, Map<String, dynamic>? heads}) async {
  dynamic usertoken = await getCurrentUser();
  // print(usertoken);

  Map<String, dynamic> header = Map<String, dynamic>();
  header['Authorization'] = "Bearer " + usertoken;
  header['Content-Type'] = 'application/json';

  // print(header);
  try {
    Response response = await Dio().get(url, options: Options(headers: header));

    return response.data;
    

    // return response;
  } on DioError catch (e) {
    print(e);
    navigatorKey.currentState?.pushNamed('/login');
    return e.response!.data;
  }
}

// 2 Post Request Again
Future postDioRequest(
  String url, {
  dynamic data,
}) async {
  dynamic usertoken = await getCurrentUser();
  // print(usertoken);

  Map<String, dynamic> header = Map<String, dynamic>();
  header['Authorization'] = "Bearer " + usertoken;
  header['Content-Type'] = 'application/json';

  try {
    Response response =
        await Dio().post(url, data: data, options: Options(headers: header));
    print(response.data);

    return response.data;
  } on DioError catch (e) {
    return e.response!.data;
  }
}

Future putDioRequest(String url, var body, {String? header}) async {
  dynamic usertoken = await getCurrentUser();
  // print(usertoken);

  Map<String, dynamic> headers = Map<String, dynamic>();
  headers['Authorization'] = "Bearer " + usertoken;
  headers['Content-Type'] = 'application/json';

  try {
    Response response =
        await Dio().put(url, data: body, options: Options(headers: headers));

    return response.data;
  } on DioError catch (e) {
    // print('Response' + e.response!.statusCode.toString());
    // print('Response' + e.response!.data.toString());
    return e.response!.data;
  }
}

// ! Delete Request
Future delDioRequest(String url, Map<String, dynamic> body) async {
  dynamic usertoken = await getCurrentUser();
  // print(usertoken);

  Map<String, dynamic> header = Map<String, dynamic>();
  header['Authorization'] = "Bearer " + usertoken;
  header['Content-Type'] = 'application/json';

  try {
    Response response =
        await Dio().delete(url, data: body, options: Options(headers: header));
    return response.data;
  } on DioError catch (e) {
    // print('Response' + e.response!.data.toString());
    return e.response!.data;
  }
  // print('Response' + response.data.toString());
}
