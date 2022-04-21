import 'package:dio/dio.dart';

import '/utils/app_constants.dart';
import '/utils/http_services.dart';

class ProdHomeRespo {
  Future<dynamic> homeResp() async {
    final response = await getDioRequest(
      URLConstants.homeUrl,
    );
    print(response);
    if (response != null) {
      return response;
    } else {
      print(response);
      return response;
    }
  }

  Future<dynamic> prodResp() async {
    try {
      Response response = await Dio().get(URLConstants.prodUrl);
      // Response response = await Dio().get("https://reqres.in/api/users?page=2");
      print('response $response');
      // print(response.statusCode);
      if (response.statusCode == 200) {
        return response.data;
      }

      return false;
    } on DioError catch (e) {
      print(e.response!.data.toString());
      return e.response!.data;
    }
  }
}



// final blocA = BlocName();
// if (state is LoadingState) {
//   blocA.add(Fetch());
//   return CircularProgressBar();
// }