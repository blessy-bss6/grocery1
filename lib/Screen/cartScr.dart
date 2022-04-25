import 'dart:ui';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groce1/Backend/Bloc/cart_Bloc.dart';
import '../common/cart_order_item.dart';
import '../Elements/baseAppbar.dart';
import '../Screen/home.dart';
import '../scrpart/imgslider.dart';
import '../utils/common.dart';

import '../Elements/all_list_content.dart';
import '../common/button.dart';
import '../common/formfield.dart';
import '../utils/style.dart';
import 'orderDetScr.dart';

class CartScreen extends StatefulWidget {
  CartScreen({Key? key}) : super(key: key);

  @override
  State<CartScreen> createState() => _CartScreenState();
}

class _CartScreenState extends State<CartScreen> {
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
        if (state is CartSuccessState) {
      
          if (state.data['data'].length > 0) {
            setState(() {
              bottmBtn = true;
              priceBtn = state.data['priceData'][0];
            });
          }else{
            setState(() {
              bottmBtn = false;
            //  priceBtn = state.data['priceData'][0];
            });
          }

        }
      }, builder: (context, state) {
        print(state);
        if (state is CartSuccessState) {
          if (state.data['data'].length <= 0) {
            return Center(
              child: Text('Cart Data Empty'),
            );
          }

          return CustomScrollView(
            slivers: [
              // ! Sliver app Bar

              SliverAppBars(
                title: 'Cart Screen',
                // boolLeading: false,
              ),

              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(3.0),
                      child: AddressPart(
                        trailing: IconBtn(icon: null),
                      ),
                    ),
                    Divider(),
                  ],
                ),
              ),

              SliverList(
                delegate: SliverChildBuilderDelegate(
                  (BuildContext context, int i) {
                    return Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10),
                      child: Container(
                        decoration: BoxDecoration(
                            border: Border.all(width: 1, color: borderColor)),
                        child: Row(
                          // crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            // ImgIcon(
                            //   src: state.data[i]['product']['pic'],
                            //   width: 120,
                            //   height: 100,
                            // ),
                            Column(
                              children: [
                                BasicProdDetail(prodNum: state.data['data'][i]),
                                heightSizedBox(2.0),
                                Container(
                                  child: CartBtn(
                                    cartItem: state.data['data'][i]['quantity'],
                                    onPressedPlus: () {
                                      BlocProvider.of<CartBloc>(context,
                                              listen: false)
                                          .add(CartItemPutEvent(
                                        id: '${state.data['data'][i]['id']}',
                                        quantity: state.data['data'][i]
                                                ['quantity'] +
                                            1,
                                        context: context,
                                      ));
                                    },
                                    onPressedMinus:
                                        state.data['data'][i]['quantity'] > 1
                                            ? () {
                                                BlocProvider.of<CartBloc>(
                                                        context,
                                                        listen: false)
                                                    .add(CartItemPutEvent(
                                                  id: '${state.data['data'][i]['id']}',
                                                  quantity: state.data['data']
                                                          [i]['quantity'] -
                                                      1,
                                                  context: context,
                                                ));
                                              }
                                            : null,
                                    // plusCallBack: plusCallBack,
                                    // minusCallBack: minusCallBack,
                                  ),
                                )
                              ],
                            ),
                            IconBtn(
                              icon: Icons.delete,
                              size: 20,
                              onPressed: () {
                                BlocProvider.of<CartBloc>(context,
                                        listen: false)
                                    .add(CartItemDelEvent(
                                  id: '${state.data['data'][i]['id']}',
                                  context: context,
                                ));
                              },
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  childCount: state.data['data'].length,
                ),
                //   )
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    Divider(),
                    // PriceList(prodNum: state.data['priceData'][0])
                  ],
                ),
              ),

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
                   child:PriceList(prodNum: priceBtn)),
                  Padding(
                    padding:
                        const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    child: Btn(
                      // alignment: Alignment.bottomLeft,
                      height: 35,
                      width: double.infinity,
                      btnName: 'PROCEED TO PAYMENT',
                      txtColor: txtWhiteColor,
                      color: offgreenColor,
                      onTap: () =>
                          navigationPush(context, OrderDeatilsScreen()),
                    ),
                  ),
                ],
              ),
            ),
    );
  }
}
