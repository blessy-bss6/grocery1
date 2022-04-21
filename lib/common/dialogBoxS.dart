import 'package:flutter/material.dart';
import '../utils/style.dart';

import 'button.dart';

// ! Alert Dialog Box
class AlertBox extends StatelessWidget {
  final String? title;
  final Widget? child;
  const AlertBox({Key? key, this.title, this.child}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Container(
      child: AlertDialog(
        title: Center(
            child: Text(
          title!,
        )),
        content: child,
        actions: <Widget>[
          // show == 1
          // ?
          Btn(
              color: redColor,
              height: 30,
              width: 60,
              btnName: 'Cancel',
              onTap: () => Navigator.pop(context)),
          Btn(
              color: offgreenColor,
              height: 30,
              width: 60,
              btnName: 'Submit',
              onTap: () => Navigator.pop(context)),
          // TextButton(
          //     child: Text('Submit', style: TextStyle(color: txtWhiteColor)),
          //     onPressed: () => Navigator.pop(context))
        ],
      ),
    ));
  }
}
