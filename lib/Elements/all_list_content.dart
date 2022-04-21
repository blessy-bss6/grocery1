import 'package:flutter/material.dart';
import '../common/button.dart';
import '../scrpart/imgslider.dart';
import '../utils/style.dart';

import '../Screen/cartScr.dart';
import '../Screen/wishlistScr.dart';

class ProdShowContent extends StatelessWidget {
  final String? src;
  final dynamic clBtn;
  final dynamic onTap;
  final String? btnName;
  const ProdShowContent(
      {Key? key, this.src, this.onTap, this.clBtn, this.btnName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    // print('  chuild class $clBtn');
    return Container(
      margin: const EdgeInsets.all(10.0),
      decoration: BoxDecoration(
          border:
              Border.all(width: 1, color: Color.fromARGB(255, 221, 214, 214))),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ImgIcon(
            src: 'assets/images/apple.png',
            width: 120,
            height: 100,
          ),
          ProdMidContent(),
          // lineRight()
          ProdLastContent(
            onTap: onTap,
            src: 'assets/icons/like-icon.png',
            child: clBtn == true ? Text('true') : Text('false'),
          )
        ],
      ),
    );
  }
}

// Btn(
//                       padding: EdgeInsets.all(3),

//                       onTap: (){},
//                       btnName: 'MOVE INTO BAG',
//                       style: TextStyle(color: offWhiteColor, fontSize: 10),
//                       // txtColor: offWhiteColor,
//                       color: Colors.green,
//                     )

// class ProdListContent extends StatelessWidget {
//   ProdListContent({
//     Key? key,
//     this.onTap,
//     this.height,
//     this.length,
//     this.cart,
//     this.cartItem,
//     this.childCart,
//     this.imgUrl,
//   }) : super(key: key);
//   final double? height;
//   final dynamic onTap;
//   final int? length;
//   final bool? cart;
//   final int? cartItem;
//   final Widget? childCart;
//   final String? imgUrl;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.all(8.0),
//       child: Container(
//           height: height ?? 90,
//           decoration: BoxDecoration(
//               border: Border.all(color: greyColor),
//               borderRadius: BorderRadius.circular(5)),
//           child: Row(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   // Container(
//                   //   margin: EdgeInsets.all(5),
//                   //   // alignment: Alignment.topLeft,
//                   //   child: Image.network(
//                   //     // imageUrl!,
//                   //     'assets/images/vegetables.png',
//                   //     // width: 120,
//                   //     // height: 120,
//                   //   ),
//                   // ),
//                   ImgIcon(
//                     margin: EdgeInsets.all(5),
//                     src: imgUrl!,
//                     width: 120,
//                     height: 120,
//                   ),

//                   // \! Content Part
//                   Container(
//                     margin: EdgeInsets.only(top: 3, left: 10),
//                     child: Column(
//                       children: [
//                         Row(
//                           // mainAxisSize: MainAxisSize.min,
//                           children: [
//                             Txt(
//                               t: '4.6',
//                               color: greyColor,
//                               fontSize: 13,
//                             ),
//                             Icon(
//                               Icons.star,
//                               size: 10,
//                               color: yellowColor,
//                             ),
//                           ],
//                         ),
//                         Txt(
//                           t: 'titlename',
//                           fontSize: 15,
//                           fontWeight: FontWeight.w600,
//                         ),
//                         Txt(
//                           t: 'subtitel',
//                           fontSize: 13,
//                           color: greyColor,
//                         ),
//                         Txt(
//                           t: 'mrp',
//                           fontSize: 13,
//                           color: greyColor,
//                         ),
//                         Txt(
//                           t: ' Rs. 500',
//                           fontSize: 15,
//                           fontWeight: FontWeight.w600,
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               Container(
//                 padding: EdgeInsets.all(5),
//                 child: Column(
//                   mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                   children: [
//                     IconBtn(
//                       icon: Icons.favorite_border,
//                     ),
//                     Container(
//                       color: Colors.green,
//                       padding: EdgeInsets.all(5),
//                       child: InkWell(
//                         onTap: onTap,
//                         // child: Txt(t: '\u{2795} Add'),
//                         child: cart == true
//                             ? Row(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   Icon(
//                                     Icons.add,
//                                     size: 15,
//                                   ),
//                                   Txt(
//                                     t: '5',
//                                     style: smallTextStyle,
//                                   ),
//                                   Icon(
//                                     Icons.minimize_outlined,
//                                     size: 15,
//                                   ),
//                                 ],
//                               )
//                             : Row(
//                                 mainAxisSize: MainAxisSize.min,
//                                 children: [
//                                   Icon(
//                                     Icons.add,
//                                     size: 15,
//                                   ),
//                                   Txt(
//                                     t: 'Add',
//                                     style: smallTextStyle,
//                                   ),
//                                 ],
//                               ),
//                       ),
//                     )
//                   ],
//                 ),
//               )
//             ],
//           )),
//     );
//   }
// }

// ! Home Product Grid List
class HomeGridProdList extends StatelessWidget {
  final String? name;
  final String? imageUrl;
  final String? slug;
  final String? price;
  final String? desc;
  final dynamic onPressed;
  final bool? fromSubProducts;
  final dynamic onTap;

  HomeGridProdList(
      {Key? key,
      this.name,
      this.imageUrl,
      this.slug,
      this.desc,
      this.price,
      this.onPressed,
      this.onTap,
      this.fromSubProducts = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        // padding: EdgeInsets.only(top: 3),
        child: Card(
            color: Colors.white,
            shape: RoundedRectangleBorder(
              borderRadius: const BorderRadius.all(
                Radius.circular(8.0),
              ),
            ),
            elevation: 0,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                // ! Image Network
                // Container(
                //   margin: EdgeInsets.all(2),
                //   alignment: Alignment.center,
                //   child: Image.network(
                //     imageUrl!,
                //     width: 120,
                //     height: 120,
                //   ),
                // ),
                Center(
                  child: ImgIcon(
                    margin: EdgeInsets.all(3),
                    src: imageUrl!,
                    width: 120,
                    height: 120,
                  ),
                ),
                // ! title  and Subtitle for
                Container(
                  padding: EdgeInsets.only(left: 10, right: 10, top: 15),
                  child: Column(
                    children: [
                      Txt(
                        t: name!.length <= 40 ? name! : name!.substring(0, 40),
                        textAlign: TextAlign.left,
                        fontSize: 15,
                        fontWeight: FontWeight.w600,
                        color: blackColor,
                      ),
                      Txt(
                        t: desc!.length <= 40 ? desc! : desc!.substring(0, 40),
                        textAlign: TextAlign.left,
                        fontSize: 13,
                        color: greyColor,
                      ),
                    ],
                  ),
                ),
                // ! Buttton for and Price Details
                Container(
                  alignment: Alignment.bottomLeft,
                  padding: EdgeInsets.only(left: 10, right: 10, top: 3),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Txt(
                          t: "Rs. ${(price != null) ? price : 'Unavailable'}",
                          color:
                              (price != null) ? blackColor : Color(0xFF0dc2cd)),

                      // ! Button
                      Container(
                        child: Image.asset(
                          'assets/icons/add-icon.png',
                          width: 40,
                          height: 40,
                        ),
                        // decoration: BoxDecoration(
                        //     color: Colors.green,
                        //     borderRadius: BorderRadius.circular(25)),
                        // child: IconBtn(
                        //   onPressed: onPressed,
                        //   size: 18,
                        //   icon: Icons.add,
                        //   color2: offWhiteColor,
                        // ),
                      )
                    ],
                  ),
                )
              ],
            )),
      ),
    );
  }
}

// // ! Cart ProdList
// class CartProdVerList extends StatelessWidget {
//   dynamic plusCallBack;
//   dynamic minusCallBack;
//   dynamic price;
//   dynamic quantity;
//   dynamic fullPrice;
//   CartProdVerList(
//       {Key? key,
//       this.minusCallBack,
//       this.plusCallBack,
//       this.fullPrice,
//       this.price,
//       this.quantity})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       child: ListView.builder(
//         shrinkWrap: true,
//         itemBuilder: (contxt, i) {
//           return CartProdContent(
//             prodNumber: i,
//             // plusCallBack: plusCallBack,
//             // minusCallBack: minusCallBack,
//             // price: price,
//             // fullPrice: fullPrice,
//             // quantity: quantity,
//           );
//         },
//         itemCount: 3,
//       ),
//     );
//   }
// }
