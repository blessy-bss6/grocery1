import 'package:dio/dio.dart';
import 'package:groce1/Backend/Resp/reg_login_resp.dart';

import '../../utils/shared_preferences.dart';
import '/utils/app_constants.dart';
import '/utils/http_services.dart';

class CartRespo {
  Future<dynamic> cartResp() async {
   

    final response = await getDioRequest(
      URLConstants.cartUrl,
    );
    
    if (response != null) {
      return response;
    } else {
      // print(response);
      return response;
    }

    // try {
    //   Response response = await Dio().get(URLConstants.cartUrl,
    //       options: Options(headers: header));

    //   // print(response.data);
    //   if (response.data['success'] == 1) {
    //         //  print(response.data);
    //     return response.data;
    //   }

    //   return response.data;
    // } on DioError catch (e) {
    //   return e.response!.data;
    // }
  }

  Future<dynamic> cartAddResp({
    String? product,
  }) async {
    final response =
        await postDioRequest(URLConstants.cartUrl, data: {"product": product});
    // print(response);

    if (response != null) {
      return response;
    } else {
      // print(response);
      return response;
    }

    // try {
    //   Response response = await Dio().post(URLConstants.cartUrl,
    //       data: {"product": product, "quantity": 1});
    //   // print(response);
    //   // print(response.statusCode);
    //   if (response.data['success'] == 1) {
    //     return response.data;
    //   }

    //   return response.data;
    // } on DioError catch (e) {
    //   return e.response!.data;
    // }
  }

  Future<dynamic> cartUpdateResp({String? id, int? quantity}) async {
    final response = await putDioRequest(
      URLConstants.cartUrl,
      {"id": id, "quantity": quantity},
    );
    // print(response);
    if (response['success'] == 1) {
      return response;
    } else {
      // print(response);
      return response;
    }
  }

  Future<dynamic> cartDeleteResp(
      {String ? id}) async {
    final response = await delDioRequest(
      URLConstants.cartUrl,
      {"id": id,},
    );
    print(response);
    if (response['success']==1) {
      return response;
    } else {
      print(response);
      return response;
    }
  }

  // // !  ================================ WISHLIST ======================================================================================
  // Future<dynamic> wishlistResp() async {
  //   try {
  //     Response response = await Dio().get(URLConstants.wishListUrl);
  //     // print(response);
  //     // print(response.statusCode);
  //     if (response.data['success'] == 1) {
  //       return response.data;
  //     }

  //     return false;
  //   } on DioError catch (e) {
  //     return e.response!.data;
  //   }
  // }

  // Future<dynamic> wishlistAddResp() async {
  //   try {
  //     Response response = await Dio().post(URLConstants.wishListUrl);
  //     // print(response);
  //     // print(response.statusCode);
  //     if (response.data['success'] == 1) {
  //       return response.data;
  //     }

  //     return response.data;
  //   } on DioError catch (e) {
  //     return e.response!.data;
  //   }
  // }

  // Future<dynamic> wishlistUpdateResp(
  //     {String? email, String? phone, String? name, String? password}) async {
  //   final response = await putDioRequest(
  //     URLConstants.signUpApiUrl,
  //     {"email": email, "password": password},
  //   );
  //   print(response);
  //   if (response) {
  //     return response;
  //   } else {
  //     print(response);
  //     return response;
  //   }
  // }

  // Future<dynamic> wishlistDeleteResp(
  //     {String? email, String? phone, String? name, String? password}) async {
  //   final response = await delDioRequest(
  //     URLConstants.signUpApiUrl,
  //     {"email": email, "password": password},
  //   );
  //   print(response);
  //   if (response) {
  //     return response;
  //   } else {
  //     print(response);
  //     return response;
  //   }
  // }
}
