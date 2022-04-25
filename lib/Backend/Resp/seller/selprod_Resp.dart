import 'package:dio/dio.dart';

import '/utils/app_constants.dart';
import '/utils/http_services.dart';

class SelProdRespo {
  Future<dynamic> selProdResp() async {
    final response = await getDioRequest(
      URLConstants.selProdUrl,
    );
    // print(response);

    if (response['success'] == 1) {
      return response;
    } else {
      // print(response);
      return response;
    }
  }

  Future<dynamic> selProdAddResp({
    FormData? product,
  }) async {
    final response =
        await postDioRequest(URLConstants.selProdUrl, data: product);
    // print(response['data']);

    if (response['success'] == 1) {
      // for (var i in response['data']) {
      //   print(i);
      // }
      return response;
    } else {
      // print(response);
      return response;
    }
  }
  
  // 1 Update Product Screen 
  Future<dynamic> selProdUpdateResp({FormData? product}) async {
    final response = await putDioRequest(
      URLConstants.selProdUrl,
      product,
    );
    // print(response);
    if (response['success'] == 1) {
      return response;
    } else {
      // print(response);
      return response;
    }
  }

  Future<dynamic> selProdDeleteResp({String? id}) async {
    final response = await delDioRequest(
      URLConstants.selProdUrl,
      {
        "id": id,
      },
    );
    print(response);
    if (response['success'] == 1) {
      return response;
    } else {
      print(response);
      return response;
    }
  }
}
