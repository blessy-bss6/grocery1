import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Backend/Bloc/cart_Bloc.dart';
import '../Elements/baseAppbar.dart';
import '../Screen/cartScr.dart';
import '../common/button.dart';
import '../scrpart/imgslider.dart';
import '../utils/common.dart';
import '../utils/style.dart';

class ProductDetailScr extends StatefulWidget {
  dynamic prodNum;
  ProductDetailScr({Key? key, this.prodNum}) : super(key: key);

  @override
  State<ProductDetailScr> createState() => _ProductDetailScrState();
}

class _ProductDetailScrState extends State<ProductDetailScr> {
  final List img = [
    'assets/images/pulse.png',
    'assets/images/onion.png',
    // 'assets/images/snacks.png',
    'assets/images/potato.png',
    'assets/images/pulse.png',
    'assets/images/watermelon.png',
  ];

  dynamic listImgSrc;

  imgcallBack(dynamic imgSrc) {
    // print('callBack $imgSrc');
    setState(() {
      listImgSrc = imgSrc;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: 'Product Details',
        centerTitle: true,
      ),
      body:
          // SingleChildScrollView(
          // child:
          ListView(
        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        // crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(
            alignment: Alignment.topRight,
            child: ImgIcon(
              margin: EdgeInsets.all(8),
              src: 'assets/icons/like-icon.png',
              width: 25,
              height: 25,
            ),
          ),

          // ! Image Section
          // Container(
          //   alignment: Alignment.center,
          //   // color: Colors.red,
          //   child: ImgIcon(
          //     src: widget.prodNum['pic'].toString(),
          //     width: 300,
          //     height: 200,
          //     imgType: true,
          //   ),
          // ),
          heightSizedBox(5.0),
          //  Image List Section
          ImgHorizontalList(
            cheight: 80,
            prodList: img,
            callBack: imgcallBack,
            itemBorder: listImgSrc != null ? listImgSrc.toString() : null,
          ),
          // !  Product Content
          ProdDetailsContent(
            prodNum: widget.prodNum,
          ),

          Padding(
            padding: const EdgeInsets.all(8.0),
            child: Container(
              alignment: Alignment.bottomCenter,
              child: Txt(
                t: widget.prodNum['description'],
                style: smallTextStyle,
              ),
            ),
          )

          // ! Btn  for Cart
        ],
      ),
      // ),
      bottomSheet: Padding(
        padding: const EdgeInsets.all(20),
        child: Btn(
            // alignment: Alignment.bottomLeft,
            height: 45,
            width: double.infinity,
            btnName: 'Add to Cart',
            txtColor: txtWhiteColor,
            color: offgreenColor,
            onTap: () {
              BlocProvider.of<CartBloc>(context, listen: false)
                  .add(CartItemAddEvent(
                prodNumber: '${widget.prodNum['id']}',
                context: context,
              ));
              navigationPush(context, CartScreen());
            }),
      ),
    );
  }
}

class ProdDetailsContent extends StatefulWidget {
  final dynamic prodNum;
  const ProdDetailsContent({Key? key, this.prodNum}) : super(key: key);

  @override
  State<ProdDetailsContent> createState() => _ProdDetailsContentState();
}

class _ProdDetailsContentState extends State<ProdDetailsContent> {
  dynamic price;
  dynamic quantity;
  dynamic fullPrice;

  plusCallBack(dynamic cartItem) {
    setState(() {
      price = cartItem * 150;
      quantity = cartItem;
      fullPrice = cartItem * 300;
      // print(' plus $cartItem');
    });
  }

  minusCallBack(dynamic cartItem) {
    setState(() {
      // print('minus $cartItem');
      price = cartItem * 150;
      quantity = cartItem;
      fullPrice = cartItem * 300;
    });
  }

  @override
  Widget build(BuildContext context) {
    print('prodContent  ${widget.prodNum}');
    return Container(
      child: Column(
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [lineLeft(), lineRight()],
          ),
        ],
      ),
    );
  }

  Widget lineLeft() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // ! Title
        Container(
          margin: EdgeInsets.only(top: 5, left: 10),
          // alignment: Alignment.topLeft,
          child: Txt(
            t: widget.prodNum['title'],
            fontSize: 15,
            style: labelTextStyle,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          margin: EdgeInsets.only(top: 5, left: 10),
          alignment: Alignment.topLeft,
          child: Txt(
            // textAlign: TextAlign.left,
            t: '${widget.prodNum['quantity']} KG',
            fontSize: 20,
            color: greyColor,
          ),
        ),

        Container(
          margin: EdgeInsets.only(top: 5, left: 10),
          child: CartBtn(),
        ),
      ],
    );
  }

  Widget lineRight() {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, right: 8.0),
      child: Column(
        children: [
          Txt(
            t: 'MRP : Rs${widget.prodNum['salesPrice']}',
            decoration: TextDecoration.lineThrough,
            fontSize: 13,
            color: greyColor,
          ),
          Txt(
            t: 'Rs ${widget.prodNum['discountPrice']}',
            fontSize: 17,
            color: offgreenColor,
          ),
        ],
      ),
    );
  }
}
