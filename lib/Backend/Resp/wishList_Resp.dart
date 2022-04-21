import 'package:dio/dio.dart';

import '/utils/app_constants.dart';
import '/utils/http_services.dart';

class WishListRespo {
  // !  ================================ WISHLIST ======================================================================================
  Future<dynamic> wishlistResp() async {
    try {
      Response response = await Dio().get(URLConstants.wishListUrl);
      // print(response);
      // print(response.statusCode);
      if (response.data['success'] == 1) {
        return response.data;
      }

      return false;
    } on DioError catch (e) {
      return e.response!.data;
    }
  }

  Future<dynamic> wishlistAddResp() async {
    try {
      Response response = await Dio().post(URLConstants.wishListUrl);
      // print(response);
      // print(response.statusCode);
      if (response.data['success'] == 1) {
        return response.data;
      }

      return response.data;
    } on DioError catch (e) {
      return e.response!.data;
    }
  }

  Future<dynamic> wishlistUpdateResp(
      {String? email, String? phone, String? name, String? password}) async {
    final response = await putDioRequest(
      URLConstants.signUpApiUrl,
      {"email": email, "password": password},
    );
    print(response);
    if (response) {
      return response;
    } else {
      print(response);
      return response;
    }
  }

  Future<dynamic> wishlistDeleteResp(
      {String? email, String? phone, String? name, String? password}) async {
    final response = await delDioRequest(
      URLConstants.signUpApiUrl,
      {"email": email, "password": password},
    );
    print(response);
    if (response) {
      return response;
    } else {
      print(response);
      return response;
    }
  }
}
