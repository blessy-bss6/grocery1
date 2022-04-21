import '/utils/app_constants.dart';
import '/utils/http_services.dart';

class OrderRespo {
  Future<dynamic> orderGetDataResp() async {
    final response = await getDioRequest(
      URLConstants.signUpApiUrl,
    );

    if (response != null) {
      return response;
    } else {
      print(response);
      return response;
    }
  }

  Future<dynamic> orderPostResp(
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
}
