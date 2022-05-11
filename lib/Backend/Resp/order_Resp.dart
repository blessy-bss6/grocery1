
import '../../utils/app_constants.dart';
import '/utils/http_services.dart';

class OrderRespo {
  Future<dynamic> orderResp() async {
    final response = await getDioRequest(
      URLConstants.orderUrl,
    );
    print(response);

    if (response != null) {
      return response;
    } else {
      // print(response);
      return response;
    }
  }

  Future<dynamic> orderAddResp({
  dynamic orderData
  }) async {

    // print(orderData);
    final response = await postDioRequest(URLConstants.orderUrl, data: orderData);
    
    // print(response);

    if (response != null) {
      return response;
    } else {
      // print(response);
      return response;
    }
  }

  // Future<dynamic> OrderUpdateResp({String? id, int? quantity}) async {
  //   final response = await putDioRequest(
  //     URLConstants.OrderUrl,
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

  Future<dynamic> orderDeleteResp({String? id, dynamic context}) async {
    final response = await delDioRequest(
      URLConstants.orderUrl,
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
