import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:razorpay_flutter/razorpay_flutter.dart';

import '../Backend/Bloc/order_Bloc.dart';

class PaymentMethod {
  late Razorpay _razorpay;
  late BuildContext _buildContext;
  dynamic addressId;

  initPaymentGateway(BuildContext buildContext, {dynamic addressId}) {
    this._buildContext = buildContext;
    this.addressId = addressId;
    _razorpay = new Razorpay();
    _razorpay.on(Razorpay.EVENT_PAYMENT_SUCCESS, _handlePaymentSuccess);
    _razorpay.on(Razorpay.EVENT_PAYMENT_ERROR, _handlePaymentError);
    _razorpay.on(Razorpay.EVENT_EXTERNAL_WALLET, _handleExternalWallet);
    print(addressId);
  }

  void _handlePaymentSuccess(PaymentSuccessResponse response) {
    print('Success Response: $response');

    FormData orderData = FormData.fromMap({"address": addressId});

    BlocProvider.of<OrderBloc>(_buildContext, listen: false)
      ..add(OrderItemAddEvent(orderData: orderData));
  }

  void _handlePaymentError(PaymentFailureResponse response) {
    print('Error Response: $response');
  }

  void _handleExternalWallet(ExternalWalletResponse response) {
    print('External SDK Response: $response');
  }

  getPayment(BuildContext context,
      {dynamic ammount, dynamic phone, dynamic email}) {
    var options = {
      'key': 'rzp_test_Bsl88j2I6mxRJt',
      'amount': '${ammount}',
      'name': '',
      'description': '',
      'retry': {'enabled': true, 'max_count': 1},
      'send_sms_hash': true,
      "currency": "INR",
      // 'prefill': {'contact': '$phone', 'email': '$email'},
      'prefill': {},
      'external': {
        'wallets': ['paytm']
      }
    };

    try {
      _razorpay.open(options);
    } catch (e) {
      debugPrint('Error: e');
    }
  }
}
