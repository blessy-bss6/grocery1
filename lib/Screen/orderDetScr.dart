import 'package:flutter/material.dart';
import '../Elements/baseAppbar.dart';
import '../Screen/orderCompleteScr.dart';
import '../common/button.dart';
import '../common/cart_order_item.dart';
import '../utils/common.dart';
import '../utils/style.dart';

import '../scrpart/orderDetbody.dart';
import 'cartScr.dart';

class OrderDeatilsScreen extends StatelessWidget {
  const OrderDeatilsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        centerTitle: true,
        title: 'Order Deatils',
      ),
      body: ListView(
        shrinkWrap: true,
        children: [OrderDetailTop(), OrderDetProd(), PriceList()],
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: Btn(
          // alignment: Alignment.bottomLeft,
          height: 45,
          width: double.infinity,
          btnName: 'Re-order',
          txtColor: txtWhiteColor,
          color: redColor,
          onTap: () => navigationPush(context, OrderCompleteScreen()),
        ),
      ),
    );
  }
}

class OrderDetailTop extends StatefulWidget {
  const OrderDetailTop({Key? key}) : super(key: key);

  @override
  State<OrderDetailTop> createState() => _OrderDetailTopState();
}

class _OrderDetailTopState extends State<OrderDetailTop> {
  int? _groupValue;
  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(8.0),
      decoration: BoxDecoration(
          color: offWhiteColor,
          border: Border(
              bottom: BorderSide(
                  width: 1.0, color: Color.fromARGB(255, 221, 214, 214)))
          // border: Border.all(
          //     width: 1, color: Color.fromARGB(255, 221, 214, 214))
          ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          OrderIdContent(
            t1: '#52525522',
            t2: '24 Sep,2020',
            statTxt: 'in Progress',
          ),
          heightSizedBox(10.0),
          OrderIdAdrContent(
              t1: 'picked 24 Sep,2020',
              value: 0,
              groupVal: _groupValue,
              onChanged: (val) => setState(() {
                    _groupValue = 0;
                  }),
              t2: '48,jtm mall , jagatpura,jaipur '),
          heightSizedBox(10.0),
          OrderIdAdrContent(
            t1: 'delivery 24 Sep,2020',
            value: 1,
            groupVal: _groupValue,
            t2: '48,jtm mall , jagatpura,jaipur ',
            onChanged: (val) => setState(() {
              _groupValue = 1;
            }),
          ),
          heightSizedBox(10.0),
        ],
      ),
    );
  }
}

class OrderDetProd extends StatelessWidget {
  const OrderDetProd({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        decoration: BoxDecoration(
            color: offWhiteColor,
            border: Border(bottom: BorderSide(width: 1.0, color: borderColor))),
        child: ListView.builder(
            shrinkWrap: true,
            itemCount: 3,
            itemBuilder: (context, i) {
              return Padding(
                padding: const EdgeInsets.all(8.0),
                child: OrderIdContent(
                  t1: 'product name',
                  t2: '1 kilograme',
                  statTxt: 'Rs. 250.00',
                  color: offgreenColor,
                ),
              );
            }));
  }
}
