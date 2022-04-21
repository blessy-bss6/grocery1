import 'package:dio/dio.dart';

import 'package:http/http.dart' as http;
import '../../Screen/home.dart';
import '../../utils/common.dart';
import '/utils/app_constants.dart';
import '/utils/http_services.dart';
import '/utils/shared_preferences.dart';

class RegLoginResp {
  Future<dynamic> registerResp(
      {String? email,
      String? phone,
      String? name,
      String? password,
      bool? isSeller,
      String? fullname,
      dynamic context}) async {
    try {
      Response response = await Dio().post(
        URLConstants.signUpApiUrl,
        data: {
          "email": email,
          "password": password,
          "phone": phone,
          "fullname": fullname,
          "isIdType": isSeller
        },
      );
      // print(response.statusCode);

      // print(response.data);

      // print(response.statusCode);
      // print(response);

      // print(response.data);

      if (response.data['success'] == 1) {
        setCurrentUser(response.data['token']['access']);
        setUserType(response.data['isIdType']);

        return response.data;
      }
      return response.data;

    } on DioError catch (e) {
      return e.response!.data;
    }
  }

// ! Login Respositry
  Future<dynamic> loginResp(
      {String? phone,
      String? password,
      bool? isSeller,
      dynamic context}) async {
    try {
      print(phone);

      Response response = await Dio().post(
        URLConstants.loginApiUrl,
        data: {"phone": phone, "isIdType": isSeller, "password": password},
      );

      // Response response = await Dio().post(
      //   "https://reqres.in/api/login",
      //   data: {"email": phone, "password": "cityslicka"},
      // );
     
      // print(response);

      // print(response.data);

      if (response.statusCode == 200) {
        setCurrentUser(response.data['token']['access']);
        setUserType(response.data['isIdType']);

        return response.data;
      }
  
      return response.data;
    } on DioError catch (e) {
      return e.response!.data;
    }
  }
}

// ! User Token
void setCurrentUser(response) async {
  if (response != null) {
    var v = SharedHelper().setString('current_user', response);
  }
}

Future<String> getCurrentUser() async {
  SharedHelper shared = SharedHelper();
  dynamic tokn = await shared.getString('current_user');

  // print('getCureent user ${tokn}');
  return tokn;
}

// ! LOGOUT METHOD
Future<void> logout() async {
  // currentUser.value = User();
  await SharedHelper().remove('current_user');
  await SharedHelper().remove('userIdType');
}

// ! CURRENT Screen
void setUserType(idType) async {
  if (idType != null) {
    var v = SharedHelper().setUserTypeScr('userIdType', idType);
  }
}

Future<bool> getUserType() async {
  SharedHelper shared = SharedHelper();
  dynamic idType = await shared.getUserTypeScr('userIdType');

  // print('getCureent user ${idType}');
  return idType;
}
