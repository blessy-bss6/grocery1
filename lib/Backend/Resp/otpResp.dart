import 'dart:convert';

import 'package:dio/dio.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Bloc/otpsBloc.dart';
import '../Bloc/reg_Login_Bloc.dart';
import '/utils/app_constants.dart';
import 'package:http/http.dart' as http;

class OtpResp {
  Dio _dio = Dio();
  Future<dynamic> sendOtpResp({
    String? phone,
  }) async {
    print('RESP PHONE    $phone ');
    
    try {
      Response response = await _dio.post(
        URLConstants.sendOtpUrl,
        data: {"phone": phone},
      );


        
      // var response = await http.post(Uri.parse(URLConstants.sendOtpUrl),
      //     headers: {
      //       "Content-Type": "application/json; charset=UTF-8",
      //     },
      //     body: json.encode({"phone": phone, }));

      // var data = json.decode(response.body);
      print(response);
      if (response.data['success']==1) {
        return response.data;
      } else {
        return response.data;
      }
    } on DioError catch (e) {
      print('Response' + e.response!.data.toString());
      return e.response!.data;
    }
  }

// ! Login Respositry
  Future<dynamic> verifyOtpResp({
    String? phone,
    String? otp,
  }) async {
    try {
      Response response = await _dio.post(
        URLConstants.verifyOtpUrl,
        data: {"phone": phone, "otp": otp},
      );
      print(response);
      if (response.data['success'] == 1) {
        return response.data;
      } else {
        return response.data;
      }
    } on DioError catch (e) {
      // print('Response' + e.response!.data.toString());
      return e.response!.data;
    }
  }
}
