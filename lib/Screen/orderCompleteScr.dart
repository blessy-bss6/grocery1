import 'package:flutter/material.dart';
import '../Elements/baseAppbar.dart';
import '../Screen/dashBoard.dart';
import '../Screen/home.dart';
import '../common/button.dart';
import '../utils/common.dart';
import '../utils/style.dart';

class OrderCompleteScreen extends StatelessWidget {
  const OrderCompleteScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => willPopCallback(context, true),
      child: Scaffold(
        appBar: BaseAppBar(
          centerTitle: true,
          title: 'Order Complete',
        ),
        body: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          // crossAxisAlignment: ,
          children: [
            Center(
              child: Txt(
                t: 'Your Order has been                               \n        accepted',
                style: labelTextStyle,
              ),
            ),
            heightSizedBox(5.0),
            Center(
              child: Txt(
                t: "Your Items has been placed and is on \n It's way to being processed",
                style: smallTextStyle,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
