import 'package:dio/dio.dart';
import 'package:groce1/Backend/Resp/reg_login_resp.dart';
import 'package:groce1/utils/common.dart';

import '../../utils/shared_preferences.dart';
import '/utils/app_constants.dart';
import '/utils/http_services.dart';

class WishListRespo {
  Future<dynamic> wishListResp() async {
    final response = await getDioRequest(
      URLConstants.wishListUrl,
    );
    print(response);

    if (response != null) {
      return response;
    } else {
      // print(response);
      return response;
    }
  }

  Future<dynamic> wishListAddResp({
    String? product,
  }) async {
    final response = await postDioRequest(URLConstants.wishListUrl, data: {
      "product": product,
    });
    print(product);
    print(response);

    if (response != null) {
      return response;
    } else {
      // print(response);
      return response;
    }
  }

  // Future<dynamic> wishListUpdateResp({String? id, int? quantity}) async {
  //   final response = await putDioRequest(
  //     URLConstants.wishListUrl,
  //     {"id": id, "quantity": quantity},
  //   );
  //   // print(response);
  //   if (response['success'] == 1) {
  //     return response;
  //   } else {
  //     // print(response);
  //     return response;
  //   }
  // }

  Future<dynamic> wishListDeleteResp({String? id, dynamic context}) async {
    final response = await delDioRequest(
      URLConstants.wishListUrl,
      {
        "id": id,
      },
    );
    print(response);
    if (response['success'] == 1) {
      print("success");
      //  snackBar(context, response['msg'] ?? '');
      return response;
    } else {
      print(response);
      // snackBar(context, response['msg'] ?? '');
      return response;
    }
  }
}
