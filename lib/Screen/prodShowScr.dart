import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groce1/Backend/Bloc/prod_home_Bloc.dart';
import '../Backend/Bloc/cart_Bloc.dart';
import '../Elements/baseAppbar.dart';
import '../Screen/prodDetails.dart';
import '../Screen/wishlistScr.dart';
import '../utils/common.dart';
import '../utils/style.dart';

import '../common/button.dart';
import '../scrpart/imgslider.dart';

class ProductShowScreen extends StatefulWidget {
  ProductShowScreen({Key? key}) : super(key: key);

  @override
  State<ProductShowScreen> createState() => _ProductShowScreenState();
}

class _ProductShowScreenState extends State<ProductShowScreen> {
  final List<String> item = [
    'All',
    'Banana',
    'Orange',
    'Mango',
    'All2',
    'All3',
    'Banana1',
    'Orange1',
    'Mango1',
    'All4',
    'All5',
    'Banana2',
    'Orange2',
    'Mango2',
    'All6',
  ];
  dynamic menuItem = 'All';
  menuCallback(String value) {
    setState(() {
      menuItem = value;
    });
  }

  ProdHomeBloc prodBloc = ProdHomeBloc();

  @override
  void initState() {
    prodBloc = BlocProvider.of<ProdHomeBloc>(context, listen: false);
    prodBloc.add(FetchProdEvent());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocConsumer<ProdHomeBloc, ProdHomeState>(
          listener: (context, state) {},
          builder: (context, state) {
            // print(state);
            if (state is ProdSuccessState) {
              return CustomScrollView(
                slivers: [
                  SliverAppBars(
                    elevation: 4,
                    title: 'Product List',
                  ),

                  SliverAppBar(
                    toolbarHeight: 30,
                    elevation: 0.0,
                    automaticallyImplyLeading: false,
                    pinned: true,
                    floating: false,
                    flexibleSpace: SafeArea(
                      child: Padding(
                        padding: const EdgeInsets.only(top: 8.0),
                        child: Container(
                          alignment: Alignment.center,
                          height: 30,
                          child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: item.length,
                            itemBuilder: (context, i) {
                              return MenuItem(
                                i: item[i],
                                selecItem: menuItem,
                                menuCallBack: menuCallback,
                              );
                            },
                          ),
                        ),
                      ),
                    ),
                  ),

                  //  ! SLIVER PRODUCT CONTENT
                  SliverList(
                      delegate: SliverChildBuilderDelegate((context, i) {
                    return InkWell(
                        onTap: () => navigationPush(
                            context, ProductDetailScr(prodNum: state.data[i])),
                        child: CheckProd1(
                          prodNum: state.data[i],
                          // cartData: state.cartData["data"],
                        ));
                  }, childCount: state.data.length))
                ],
              );
            }
            return Center(child: CircularProgressIndicator());
          }),
    );
  }
}

// ! Menu Item
class MenuItem extends StatefulWidget {
  final dynamic i;
  final dynamic selecItem;
  dynamic menuCallBack;
  MenuItem({Key? key, this.i, this.selecItem, this.menuCallBack})
      : super(key: key);

  @override
  State<MenuItem> createState() => _MenuItemState();
}

class _MenuItemState extends State<MenuItem> {
  dynamic item = false;
  @override
  Widget build(BuildContext context) {
    // print(widget.selecItem);
    return InkWell(
      onTap: () => widget.menuCallBack(widget.i),
      child: Container(
        margin: const EdgeInsets.only(right: 5.0, left: 5),
        child: Text(
          '${widget.i}',
          style: TextStyle(
              color:
                  widget.selecItem == widget.i ? orangeColor : txtBlackColor),
        ),
      ),
    );
  }
}

// 1 Product
class CheckProd1 extends StatefulWidget {
  final dynamic prodNum;
  final List? cartData;
  CheckProd1({Key? key, this.prodNum, this.cartData}) : super(key: key);

  @override
  State<CheckProd1> createState() => _CheckProd1State();
}

class _CheckProd1State extends State<CheckProd1> {
  // dynamic chWid = false;
  // dynamic data = false;
  // chnageCallBack(dynamic clBtn) {
  //   setState(() {
  //     data = clBtn;
  //   });
  //   // print('OutSide $clBtn');
  // }

  // dynamic price;
  // dynamic quantity;
  // dynamic fullPrice;

  // plusCallBack(dynamic cartItem) {
  //   setState(() {
  //     price = cartItem * 150;
  //     quantity = cartItem;
  //     fullPrice = cartItem * 300;
  //     // print(' plus $cartItem');
  //   });
  // }

  // minusCallBack(dynamic cartItem) {
  //   setState(() {
  //     // print('minus $cartItem');
  //     price = cartItem * 150;
  //     quantity = cartItem;
  //     fullPrice = cartItem * 300;
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    // print("runtipme type ${widget.cartData.runtimeType}");
    print('${widget.cartData}');
    // print(widget.prodNum);
    return Container(
      margin: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          border:
              Border.all(width: 1, color: Color.fromARGB(255, 221, 214, 214))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.center,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          // ImgIcon(
          //   imgType:true,
          //   src: widget.prodNum['pic'].toString() ,
          //   width: 120,
          //   height: 100,
          // ),
          ProdMidContent(
            prodNumber: widget.prodNum,
          ),
          Container(
              child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                InkWell(
                  onTap: () {},
                  child: ImgIcon(
                    src: 'assets/icons/like-icon.png',
                    width: 15,
                    height: 15,
                  ),
                ),
                heightSizedBox(20.0),
                // CheckProd2(
                //   i: widget.prodNum,
                //   chnageCallBack: chnageCallBack,
                //   data: data,
                //   plusCallBack: plusCallBack,
                //   minusCallBack: minusCallBack,
                // )

                InkWell(
                    onTap: ()  {
                      // widget.cartData!.any((e) {
                      //   print(e);
                      //   return e;
                      // });

                      // print('${widget.prodNum['id']}');
                      //   widget.cartData!.any((e) => e['data'].product.id
                      //         .contains(widget.prodNum['id'].toString())) ==
                      //     false
                      // ? 'acart'
                      // : 'gcart'

                         BlocProvider.of<CartBloc>(context, listen: false)
                          .add(CartItemAddEvent(
                        prodNumber: '${widget.prodNum['id']}',
                        context: context,
                      ));

                      // dynamic cartState = context.read<CartWishListBloc>()..add(CartItemAddEvent(
                      //   prodNumber: '${widget.prodNum['id']}',
                      //   context: context,
                      // ));
                      // print(cartState);
                    },
                    child: Padding(
                      padding: const EdgeInsets.all(20),
                      child: Btn(
                        width: 50,
                        padding: EdgeInsets.all(3),
                        btnName: 'Add',
                        style: TextStyle(color: txtWhiteColor, fontSize: 10),
                        // txtColor: offWhiteColor,
                        color: Colors.green,
                      ),
                    ))
              ]))
        ],
      ),
    );
  }
}

class CheckProd2 extends StatefulWidget {
  final dynamic i;
  final dynamic data;
  dynamic chnageCallBack;
  dynamic plusCallBack;
  dynamic minusCallBack;
  CheckProd2(
      {Key? key,
      this.i,
      this.data,
      this.minusCallBack,
      this.plusCallBack,
      this.chnageCallBack})
      : super(key: key);

  @override
  State<CheckProd2> createState() => _CheckProd2State();
}

class _CheckProd2State extends State<CheckProd2> {
  @override
  Widget build(BuildContext context) {
    if (widget.data == true) {
      return InkWell(
          onTap: () {
            setState(() {
              // chWid = false;
              setState(() {
                widget.chnageCallBack(false);
              });
            });
          },
          child: Container(
              margin: EdgeInsets.all(5),
              child: CartBtn(
                color: Colors.green,
                // plusCallBack: widget.plusCallBack,
                // minusCallBack: widget.minusCallBack,
              )));
    }
    return InkWell(
      onTap: () {
        //    setState(() {
        //   widget.chnageCallBack(true);
        // });
      },
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Btn(
          width: 50,
          padding: EdgeInsets.all(3),

          btnName: 'ADD',
          style: TextStyle(color: txtWhiteColor, fontSize: 10),
          // txtColor: offWhiteColor,
          color: Colors.green,
        ),
      ),
    );
  }
}
