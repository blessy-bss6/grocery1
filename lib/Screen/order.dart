// import 'dart:async';

// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:groce1/scrpart/imgslider.dart';
// import 'package:razorpay_flutter/razorpay_flutter.dart';

// import '../Backend/Bloc/order_Bloc.dart';

// import '../Elements/baseAppbar.dart';

// import '../common/button.dart';
// import '../common/cart_order_item.dart';

// import '../utils/common.dart';
// import '../utils/style.dart';

// class OrderScreen extends StatefulWidget {
//   final dynamic addressId;
//   final dynamic orderData;
//   OrderScreen({Key? key, this.addressId, this.orderData}) : super(key: key);

//   @override
//   State<OrderScreen> createState() => _OrderScreenState();
// }

// class _OrderScreenState extends State<OrderScreen> {
//   dynamic priceData = 0;
//   dynamic bottomBtn = true;
//   dynamic cartData;

//   OrderBloc orderB = OrderBloc();
//   late Razorpay _razorpay;

//   @override
//   void initState() {
//     // TODO: implement initState

//     _razorpay = new Razorpay();
//     _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
//     _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
//     _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);

//     super.initState();
//   }

//   void _handlePaymentSuccess(PaymentSuccessResponse response) {
//     // BlocProvider.of<OrderBloc>(context, listen: false)
//     //   ..add(OrderItemAddEvent(
//     //       userId: widget.userId,
//     //       orderData: priceData['orderData'],
//     //       billing: widget.billing,
//     //       shipping: widget.shipping,
//     //       transcationId: response.paymentId,
//     //       payMode: response.signature,
//     //       // ammount: priceData['subPrice'] + priceData['shipPrice'],

//     //       context: context));
//     setState(() {
//       bottomBtn = false;
//     });
//   }

//   void _handlePaymentError(PaymentFailureResponse response) {
//     print('Error Response: $response');
//     snackBar(context, 'Error Payment Not Successs', bgColor: redColor);
//   }

//   void _handleExternalWallet(ExternalWalletResponse response) {
//     print('External SDK Response: $response');
//   }

//   void openCheckout() async {
//     var options = {
//       'key': 'rzp_test_Bsl88j2I6mxRJt',
//       'amount': ' ${(priceData['subPrice'] + priceData['shipPrice']) * 100}',
//       'name': '',
//       'description': '',
//       'retry': {'enabled': true, 'max_count': 1},
//       'send_sms_hash': true,
//       "currency": "INR",
//       'prefill': {'contact': '', 'email': ''},
//       'external': {
//         'wallets': ['paytm']
//       }
//     };

//     try {
//       _razorpay.open(options);
//     } catch (e) {
//       debugPrint('Error: e');
//     }
//   }

//   @override
//   void dispose() {
//     super.dispose();
//     _razorpay.clear();
//   }

//   dynamic loadMore = true;

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       body:
//           // widget.orderData
//           //     ?
//           CustomScrollView(
//         slivers: [
//           SliverAppBars(
//             title: 'Order Screen',
//           ),

//           SliverList(
//             delegate: SliverChildBuilderDelegate(
//               (BuildContext context, int i) => Padding(
//                 padding: EdgeInsets.symmetric(horizontal: 10),
//                 child: Container(
//                   decoration: BoxDecoration(
//                       border: Border.all(width: 1, color: borderColor)),
//                   child: Row(
//                     // crossAxisAlignment: CrossAxisAlignment.start,
//                     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                     children: [
//                       // ImgIcon(
//                       //   imgType: true,
//                       //   src: orderData[i]['pic'],
//                       //   width: 120,
//                       //   height: 100,
//                       // ),
//                       BasicProdDetail(
//                         prodNum: widget.orderData[i],
//                       ),
//                     ],
//                   ),
//                 ),
//               ),
//               childCount: widget.orderData.length,
//             ),
//           )

//           //  ! Sliver Product Content
//         ],
//       ),
//       // : CustomScrollView(slivers: [
//       //     // ! Sliver app Bar

//       //     SliverAppBars(
//       //       title: 'Order Screen',
//       //     ),
//       //     SliverToBoxAdapter(
//       //         child: Center(
//       //       child: Text('No Data'),
//       //     )),
//       // ]
//       // ),
//       bottomNavigationBar: bottomBtn == false
//           ? null
//           : Padding(
//               padding: const EdgeInsets.all(3),
//               child: Container(
//                 height: 180,
//                 child: Column(
//                   children: [
//                     // Expanded(child: Container(child: PriceList())),
//                     PriceList(),
//                     Btn(
//                         height: 35,
//                         width: double.infinity,
//                         btnName: 'Order',
//                         txtColor: txtWhiteColor,
//                         color: offgreenColor,
//                         onTap: () {
//                           openCheckout();

//                           // if (widget.billing != null) {
//                           //   BlocProvider.of<OrderBloc>(context, listen: false)
//                           //     ..add(OrderItemAddEvent(
//                           //         userId: widget.userId,
//                           //         orderData: priceData['orderData'],
//                           //         billing: widget.billing,
//                           //         shipping: widget.shipping,
//                           //         context: context));
//                           //   setState(() {
//                           //     bottomBtn = false;
//                           //   });
//                           // }
//                         }),
//                   ],
//                 ),
//               )),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groce1/Backend/Bloc/cart_Bloc.dart';
import 'package:groce1/Screen/paymentScr.dart';

import '../common/cart_order_item.dart';

import '../utils/common.dart';

import '../common/button.dart';

import '../utils/style.dart';
import 'addressScr.dart';

class OrderScreen extends StatefulWidget {
  final dynamic addressId;
  OrderScreen({Key? key, this.addressId}) : super(key: key);

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  CartBloc cartBloc = CartBloc();

  @override
  void initState() {
    cartBloc = BlocProvider.of<CartBloc>(context, listen: false);
    cartBloc.add(FetchCartEvent());
    super.initState();
  }

  dynamic bottmBtn = false;
  dynamic priceBtn;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<CartBloc, CartState>(listener: (context, state) {
        // print(state);
        if (state is CartSuccessState) {
          if (state.data['data'].length > 0) {
            setState(() {
              bottmBtn = true;
              priceBtn = state.data;
            });
          } else {
            setState(() {
              bottmBtn = false;
              //  priceBtn = state.data['priceData'][0];
            });
          }
        }
      }, builder: (context, state) {
        // print(state);
        if (state is CartSuccessState) {
          if (state.data['data'].length <= 0) {
            return Center(
              child: Text('Order Data Empty'),
            );
          }

          return CustomScrollView(
            slivers: [
              // ! Sliver app Bar

              SliverAppBar(
                title: Text(
                  'Order Screen',
                  style: appBarTS,
                ),
                centerTitle: true,

                backgroundColor: offWhiteColor,
                leading: IconButton(
                  color: blackColor,
                  icon: Icon(Icons.arrow_back),
                  onPressed: () => navigationPush(context, AddressScreen()),
                ),

                // boolLeading: false,
              ),

              SliverToBoxAdapter(
                child: Container(
                  width: double.infinity,
                  child: Card(
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Delivery Address',
                            style: labelTextStyle,
                          ),
                          Text(
                              '${widget.addressId['email'] ?? ''} \n ${widget.addressId['phone']}',
                              style: labelTextStyle),
                          Text(
                              '${widget.addressId['trade'] ?? ''} \n ${widget.addressId['area'] ?? ''}',
                              style: labelTextStyle),
                          Text(
                              '${widget.addressId['city']}  ${widget.addressId['town'] ?? ''}',
                              style: labelTextStyle),
                          Text(
                              '${widget.addressId['pinCode']}  ${widget.addressId['state']}',
                              style: labelTextStyle),
                        ],
                      ),
                    ),
                  ),
                ),
              ),

              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int i) {
                    return Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 5),
                      child: Card(
                        child: Container(
                          decoration: BoxDecoration(
                              border: Border.all(width: 1, color: borderColor)),
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Row(
                              // crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                // ImgIcon(imgType: true,
                                //   // src: state.data[i]['product']['pic'],
                                //   width: 120,
                                //   height: 100,
                                // ),r

                                BasicProdDetail(prodNum: state.data['data'][i]),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  },
                  childCount: state.data['data'].length,
                ),
                //   )
              ),
              // SliverToBoxAdapter(
              //   child: Column(
              //     children: [
              //       Divider(),
              //       // PriceList(prodNum: state.data['priceData'][0])
              //     ],
              //   ),
              // ),

              //  ! Sliver Product Content
            ],
          );
        }
        return Center(
          child: CircularProgressIndicator(),
        );
      }),
      bottomNavigationBar: bottmBtn == false
          ? null
          : Container(
              height: 250,
              child: Column(
                children: [
                  Container(
                      child: PriceList(prodNum: priceBtn['priceData'][0])),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Btn(
                        // alignment: Alignment.bottomLeft,
                        height: 35,
                        width: double.infinity,
                        btnName: 'Order',
                        // btnName: 'PROCEED TO PAYMENT',
                        txtColor: txtWhiteColor,
                        color: offgreenColor,
                        onTap: () {
                          print(priceBtn['priceData'][0]['totalAmmount']
                              .runtimeType);
                          print(priceBtn['priceData'][0]['totalAmmount'] * 100);
                          PaymentMethod payMet = PaymentMethod();
                          payMet.initPaymentGateway(context,
                              addressId: widget.addressId ,totalAmmount:  priceBtn['priceData'][0]
                                      ['totalAmmount'] *
                                  100 );
                          payMet.getPayment(context,
                              ammount: priceBtn['priceData'][0]
                                      ['totalAmmount'] *
                                  100);
                        }
                        // if (widget.addressId != null &&
                        //     widget.addressId.isNotEmpty) {
                        //   navigationPush(context, OrderDeatilsScreen());
                        // } else {
                        //   snackBar(context, 'Please Select Address');
                        // }
                        ),
                  ),
                ],
              ),
            ),
    );
  }
}
