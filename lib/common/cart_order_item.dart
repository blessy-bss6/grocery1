import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../utils/common.dart';
import '../utils/style.dart';
import 'button.dart';

class PriceList extends StatelessWidget {
  final dynamic prodNum;
  final dynamic productData;
  const PriceList({Key? key, this.prodNum, this.productData}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          datas(
            t1: 'Subtotal',
            t2: 'Rs ${prodNum['ammount']}',
          ),
          datas(
            t1: 'Delivery Charge',
            t2: 'Rs ${prodNum['shipPrice']}',
          ),
          datas(
              t1: 'Total Discount',
              t2: '- Rs ${5}',
              style: TextStyle(color: offgreenColor, fontSize: 15)),
          datas(
            t1: 'Tax Charge',
            t2: 'Rs 00.00',
          ),
          datas(
              t1: 'Promo Code',
              t2: '- Rs 500',
              style: TextStyle(color: offgreenColor, fontSize: 15)),
          heightSizedBox(5.0),
          Container(
              margin: EdgeInsets.all(15),
              decoration: BoxDecoration(color: brownWhiteColor),
              padding: EdgeInsets.all(5),
              child: datas(
                t1: 'Total Pay',
                t2: 'Rs ${prodNum['totalAmmount']}',
              ))
        ],
      ),
    );
  }

  Widget datas({String? t1, String? t2, TextStyle? style}) {
    return Padding(
      padding:
          const EdgeInsets.only(left: 15.0, right: 15.0, top: 3, bottom: 3),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            t1 ?? '',
            style: style ?? labelTextStyle,
          ),
          Text(
            t2 ?? '',
            style: style ?? labelTextStyle,
          )
        ],
      ),
    );
  }
}

// ! Basic Order ITEM

class BasicProdDetail extends StatelessWidget {
  final bool? cartBtn, mrpTxt;
  final dynamic prodNum;
  const BasicProdDetail({Key? key, this.prodNum, this.cartBtn, this.mrpTxt})
      : super(key: key);

//   @override
//   State<BasicProdDetail> createState() => _BasicProdDetailState();
// }

// class _BasicProdDetailState extends State<BasicProdDetail> {
  // dynamic price;
  // dynamic quantity;
  // dynamic fullPrice;

  // plusCallBack(dynamic cartItem) {
  //   setState(() {
  //     price = cartItem * 50;
  //     quantity = cartItem;
  //     fullPrice = cartItem * 90;
  //     // print(' plus $cartItem');
  //   });
  // }

  // minusCallBack(dynamic cartItem) {
  //   setState(() {
  //     // print('minus $cartItem');
  //     price = cartItem * 50;
  //     quantity = cartItem;
  //     fullPrice = cartItem * 90;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // print(widget.prodNum);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Txt(
          t: prodNum['product']['title'],
          fontSize: 15,
          fontWeight: FontWeight.bold,
        ),
        Txt(
          t: '${prodNum['quantity']}',
          fontSize: 17,
          color: greyColor,
        ),
        Row(
          children: [
            Container(
              child:
                  Txt(
                      t: 'MRP : Rs${prodNum['salesPrice']} ',
                      decoration: TextDecoration.lineThrough,
                      fontSize: 13,
                      color: greyColor,
                    ),
            ),

            // widthSizedBox(2.0),
            Txt(
              t: 'Rs ${prodNum['discountPrice']}',
              style: labelTextStyle,
            ),
          ],
        ),
        // heightSizedBox(2.0),
        // Container(
        //   child: widget.cartBtn == false
        //       ? null
        //       : CartBtn(
        //         cartItem: widget.prodNum['quantity'],
        //           onPressedPlus: (){
        //             // BlocProvider()
        //           },
        //           // plusCallBack: plusCallBack,
        //           // minusCallBack: minusCallBack,
        //           ),
        // )
      ],
    );
  }
}
