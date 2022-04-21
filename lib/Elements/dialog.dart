import 'package:flutter/material.dart';
import 'package:groce1/Screen/spalash.dart';
import 'package:groce1/Screen/welcome.dart';

import '../Backend/Resp/reg_login_resp.dart';
import '../utils/common.dart';
import '../utils/style.dart';

Future<dynamic> logOutDialog(context) {
  return showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        title: Text(
          'Are you sure you want to \n LogOut',
          textAlign: TextAlign.center,
          style: TextStyle(fontFamily: montserratMedium, fontSize: 16),
        ),
        actions: <Widget>[
          TextButton(
            child: Text('No', style: TextStyle(color: darkBlueColor)),
            onPressed: () {
              Navigator.pop(context);
            },
          ),
          TextButton(
            child: Text('Yes', style: TextStyle(color: Colors.red)),
            onPressed: () {
              logout().then((value) =>
                  navigationPushReplacement(context,WelcomeScreen()));
            },
          )
        ],
      );
    },
  );
}
