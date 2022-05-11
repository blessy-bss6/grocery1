import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import '../Backend/Bloc/order_Bloc.dart';
import '../Backend/Resp/paymentResp.dart';
import '../Elements/baseAppbar.dart';
import '../common/button.dart';
import '../scrpart/orderDetbody.dart';
import '../utils/common.dart';
import '../utils/style.dart';

class OrderScr2 extends StatefulWidget {
  const OrderScr2({
    Key? key,
  }) : super(key: key);

  @override
  State<OrderScr2> createState() => _OrderScr2State();
}

class _OrderScr2State extends State<OrderScr2> {
  OrderBloc orderB = OrderBloc();

  @override
  void initState() {
    // TODO: implement initState
    orderB = BlocProvider.of<OrderBloc>(context, listen: false);
    orderB.add(FetchOrderEvent());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BaseAppBar(
          centerTitle: true,
          title: 'Order',
          // leadingOnTap: ,
        ),
        body: BlocConsumer<OrderBloc, OrderState>(
            listener: (context, state) {},
            builder: (context, state) {
              // print(state);
              if (state is OrderSuccessState) {
                // print(state.data.length);
                final ldata = state.data['data'];
                final orderProd = state.data['orderProd'];

                // print(state);
                return Container(
                  child: ListView.builder(
                      itemCount: state.data['data'].length,
                      shrinkWrap: true,
                      itemBuilder: (context, i) {
                        // print(ldata[i]['start_date'].runtimeType);
                        // print(DateFormat.yMMMEd().format(
                        //     DateTime.parse(ldata[i]['start_date'].toString())));
                        return Container(
                          margin: EdgeInsets.all(8.0),
                          decoration: BoxDecoration(
                              color: offWhiteColor,
                              border: Border(
                                  bottom: BorderSide(
                                      width: 1.0,
                                      color:
                                          Color.fromARGB(255, 221, 214, 214)))
                              // border: Border.all(
                              //     width: 1, color: Color.fromARGB(255, 221, 214, 214))
                              ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              OrderIdContent(
                                t1: '${ldata[i]['id']}',
                                t2: '${DateFormat.yMMMEd().format(DateTime.parse(ldata[i]['start_date'].toString()))}',
                              ),
                              heightSizedBox(10.0),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Txt(
                                    t: 'items',
                                    style: labelTextStyle,
                                  ),
                                  Txt(
                                    t: 'Rs. ${ldata[i]['totalAmmount']}',
                                    fontSize: 15,
                                    color: Colors.green,
                                  )
                                ],
                              ),
                              OrderItemShowList(
                                  orderProd: orderProd,
                                  orderId: ldata[i]['id']),
                              heightSizedBox(5.0),
                              OrderItemStatus(
                                  orderData: ldata[i],
                                  status: '${ldata[i]['status']}',
                                  statusVal: '${ldata[i]['status']}')
                            ],
                          ),
                        );
                      }),
                );
              } else {
                return Center(
                  child: Text('data'),
                );
              }
            }));
  }
}

class OrderItemShowList extends StatefulWidget {
  List? orderProd;
  dynamic orderId;
  OrderItemShowList({Key? key, this.orderProd, this.orderId}) : super(key: key);

  @override
  State<OrderItemShowList> createState() => _OrderItemShowListState();
}

class _OrderItemShowListState extends State<OrderItemShowList> {
  dynamic b = [];

  int prodNumber = 10;

  @override
  void initState() {
    // TODO: implement initState
    addProdItem();
    super.initState();
  }

  addProdItem() {
    // print('id ${widget.orderId}');
    // print(
    //     "===================================================================================================================================== ${widget.orderProd}");

    setState(() {
      widget.orderProd!.forEach((e) {
        // print(e.runtimeType);
        //  print(e);
        if (e.containsValue(widget.orderId)) {
          b.add(e);
        }
      });
    });
    // print(b);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          ListView.builder(
              shrinkWrap: true,
              itemCount: b.length,
              itemBuilder: (context, i) =>
                  Txt(t: '${b[i]['product']['title']}', style: smallTextStyle)),
          Container(
              child: InkWell(
            // onTap: () => setState(() {
            //  b.length = prodNumber;
            // }),
            child: Txt(
              t: 'view more',
              fontSize: 10,
              color: textBlueColor,
            ),
          )
              // :b.length == prodNumber
              //     ? InkWell(
              //         // onTap: () => setState(() {
              //         //  b.length = 2;
              //         // }),
              //         child: Txt(
              //           t: 'view less',
              //           fontSize: 10,
              //           color: textBlueColor,
              //         ),
              //       )
              //     : null,
              )
        ],
      ),
    );
  }
}

// ! Order Status
class OrderItemStatus extends StatelessWidget {
  final String? statusVal;
  final String? status;
  final dynamic orderData;
  OrderItemStatus({Key? key, this.status, this.orderData, this.statusVal})
      : super(key: key);

  PaymentResp payresp = PaymentResp();
  @override
  Widget build(BuildContext context) {
    return Container(
      alignment: Alignment.bottomLeft,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Container(
            child: statusVal == 'Delivered' || statusVal == 'Complete'
                ? IconTxtWid(
                    icon: Icons.add_task_rounded,
                    txt: 'Delivered',
                    color: offgreenColor,
                    txtcolor: offgreenColor,
                  )
                : InkWell(
                    onTap: () {
                      print("transaction id ${orderData['transcationId']}");
                      BlocProvider.of<OrderBloc>(context, listen: false)
                        ..add(OrderItemDelEvent(
                            id: orderData['id'], context: context));
                      payresp.paymentRefundResp(
                          transcationId: "${orderData['transcationId']}",
                          ammount: double.parse(orderData['totalAmmount'].toString())
                          // ammount: orderData['totalAmmount'] * 100
                          );
                    },
                    child: IconTxtWid(
                      icon: Icons.cancel,
                      txt: 'Cancel',
                      color: redColor,
                      txtcolor: redColor,
                    ),
                  ),
          ),
          IconTxtWid(
            txt: status ?? '',
            txtcolor: statusVal == 'Delivered' || statusVal == 'Complete'
                ? offgreenColor
                : redColor,
            color: statusVal == 'Delivered' || statusVal == 'Complete'
                ? offgreenColor
                : redColor,
            // icon:
          )
        ],
      ),
    );
  }

  Widget statsBox() {
    if (statusVal == 'Delivered') {
      return IconTxtWid(
        icon: Icons.add_task_rounded,
        txt: 'Delivered',
        color: offgreenColor,
      );
    }
    if (statusVal == 'Cancel') {
      return IconTxtWid(
        icon: Icons.cancel,
        txt: 'Cancel',
        color: redColor,
      );
    }

    return Container(
      child: Btn(
        height: 25,
        width: 80,
        btnName: 'TrackOrder',
        txtColor: txtWhiteColor,
        color: offgreenColor,
      ),
    );
  }
}

class IconTxtWid extends StatelessWidget {
  final String? txt;
  final IconData? icon;
  final Color? color;
  final Color? txtcolor;
  const IconTxtWid({Key? key, this.txt, this.color, this.txtcolor, this.icon})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(mainAxisAlignment: MainAxisAlignment.start, children: [
      IconBtn(
        icon: icon,
        color2: color,
        size: 18,
      ),
      Txt(
        t: txt ?? '',
        color: txtcolor ?? blackColor,
      ),
    ]));
  }
}
