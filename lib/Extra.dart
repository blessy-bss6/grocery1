import 'package:flutter/material.dart';
import 'package:groce1/Backend/Resp/prod_home_Resp.dart';

class ProdData extends StatelessWidget {
  ProdData({Key? key}) : super(key: key);
  ProdHomeRespo resp = ProdHomeRespo();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
          future: resp.prodResp(),
          builder: (context, state) {
            print(state);
            print(state.data);

            if (state.data != null) {
              print(state.data);
            }
            return Center(child: Text('home data'));
          }),
    );
  }
}
