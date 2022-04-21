import 'package:flutter/material.dart';
import '../common/cart_order_item.dart';
import '../Screen/cartScr.dart';
import '../common/button.dart';
import '../utils/common.dart';
import '../Elements/baseAppbar.dart';
import '../utils/style.dart';

class SelOrderConfScreen extends StatelessWidget {
  const SelOrderConfScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        centerTitle: true,
        title: 'Order Details',
      ),
      body: Column(
        children: [
          Text(
            'Seller Order',
            style: labelTextStyle,
          ),
          PriceList()
        ],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 3.0),
        child: Container(
          height: 80,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            children: [
              Btn(
                onTap: () {},
                height: 35,
                // width: 100,
                btnName: 'Accept',
                color: Colors.green,
                txtColor: offWhiteColor,
              ),
              heightSizedBox(5.0),
              Btn(
                onTap: () {},
                height: 35,
                // width: 100,
                btnName: 'Cancel',
                color: redColor,
                txtColor: offWhiteColor,
              )
            ],
          ),
        ),
      ),
    );
  }
}
