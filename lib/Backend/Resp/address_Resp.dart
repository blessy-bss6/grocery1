import '/utils/app_constants.dart';
import '/utils/http_services.dart';

class AddressRespo {
  Future<dynamic> addressResp() async {
    final response = await getDioRequest(
      URLConstants.addressUrl,
    );
    // print(response);

    if (response != null) {
      return response;
    } else {
      // print(response);
      return response;
    }
  }

  Future<dynamic> addressAddResp({
    dynamic addressItem,
  }) async {
    final response = await postDioRequest(URLConstants.addressUrl,
        data: addressItem);
    // print(response);

    if (response != null) {
      return response;
    } else {
      print(response);
      return response;
    }
  }

  Future<dynamic> addressUpdateResp({dynamic addressItem}) async {
    final response = await putDioRequest(
      URLConstants.addressUrl,
     addressItem
    );
    print(response);
    if (response['success'] == 1) {
      return response;
    } else {
      // print(response);
      return response;
    }
  }

  Future<dynamic> addressDeleteResp({String? id}) async {
    final response = await delDioRequest(
      URLConstants.addressUrl,
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
