import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groce1/Backend/Bloc/seller/selprod_bloc.dart';
import 'package:groce1/sellerPart/selProdEditScr.dart';
import '../Screen/wishlistScr.dart';
import '../common/button.dart';
import '../common/dialogBoxS.dart';
import '../common/formfield.dart';
import '../scrpart/imgslider.dart';
import '../sellerPart/selProdAddScr.dart';
import '../utils/common.dart';
import '../utils/style.dart';
import '../Elements/baseAppbar.dart';

class SelProdListScreen extends StatelessWidget {
  SelProdListScreen({Key? key}) : super(key: key);
  final TextEditingController mrpPriceController = TextEditingController();
  final TextEditingController offerPriceController = TextEditingController();

  SelProductBloc prodBloc = SelProductBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: offWhiteColor,
        centerTitle: true,
        title: Text(
          'Seller Product List',
        ),
        automaticallyImplyLeading: false,
      ),
      floatingActionButton: InkWell(
        onTap: () => navigationPush(context, SelProdAddScreen()),
        child: ImgIcon(
          src: 'assets/icons/add-icon.png',
          // color: offgreenColor,
          height: 60,
          width: 60,
        ),
      ),
      body: BlocProvider(
        create: (BuildContext context) =>
            SelProductBloc()..add(FetchSelProductEvent()),
        child: BlocConsumer<SelProductBloc, SelProductState>(
            listener: (context, state) {},
            builder: (context, state) {
              if (state is SelProdSuccessState) {
                if (state.data.length > 0) {
                  return Container(
                      child: ListView.builder(
                    shrinkWrap: true,
                    itemBuilder: ((context, i) {
                      return Container(
                        // padding: const EdgeInsets.all(10.0),
                        margin: const EdgeInsets.all(10.0),
                        decoration: BoxDecoration(
                            border: Border.all(
                                width: 1,
                                color: Color.fromARGB(255, 221, 214, 214))),
                        child: Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            ImgIcon(
                              src: 'assets/images/apple.png',
                              width: 120,
                              height: 100,
                            ),
                            SelProdContent(
                                prodNumber: state.data[i],),
                            ProdLastContent(
                              src: 'assets/icons/delete-icon.png',
                        
                              btnOnTap: () {
                                navigationPush(
                                    context,
                                    SelProdEditScreen(
                                      prodNumber: state.data[i],
                                    ));
                              },
                              
                              btnName: ' Edit   ',
                              removeBtn: true,
                              onTap: (){
                                 BlocProvider.of<SelProductBloc>(context,
                                        listen: false)
                                    .add(SelProdDelEvent(
                                  id: '${state.data[i]['id']}',
                                  context: context,
                                ));
                              },
                            ),
                          ],
                        ),
                      );
                    }),
                    itemCount: state.data.length,
                  ));
                } else {
                  return Center(
                    child: Text('No Data'),
                  );
                }
              }

              return Center(
                child: CircularProgressIndicator(),
              );
            }),
      ),
    );
  }
}





class SelProdContent extends StatelessWidget {
  final dynamic prodNumber;


  const SelProdContent(
      {Key? key, this.prodNumber, })
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          children: [
            Txt(
              t: '4.6',
              fontSize: 13,
              color: greyColor,
            ),
            
          ],
        ),

        // ! Title
        Container(
          child: Txt(
            t: '${prodNumber['title'].toString()}',
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          alignment: Alignment.topLeft,
          child: Txt(
            t: 'stock ${prodNumber['stock'].toString()}',
            fontSize: 13,
            color: greyColor,
          ),
        ),

        Container(
          alignment: Alignment.topLeft,
          child: Txt(
            t: 'MRP:-${prodNumber['salesPrice']}',
            fontSize: 13,
            decoration: TextDecoration.lineThrough,
            color: greyColor,
          ),
        ),

        Container(
          alignment: Alignment.topLeft,
          child: Txt(
            t: 'Rs ${prodNumber['discountPrice']}',
            fontSize: 13,
            style: labelTextStyle,
            color: greyColor,
          ),
        ),
      ],
    );
  }
}

// // ! Product  last content
// class ProdLastContent extends StatelessWidget {
//   final dynamic onTap;

//   final String? src;
//   final Widget? child;
//   final dynamic btnOnTap;
//   final String? btnName;
//   final bool? removeBtn;

//   ProdLastContent(
//       {Key? key,
//       this.onTap,
//       this.src,
//       this.removeBtn,
//       this.child,
//       this.btnOnTap,
//       this.btnName})
//       : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.only(top: 5.0, right: 8.0),
//       child: Column(
//         // mainAxisAlignment: MainAxisAlignment.spaceAround,
//         children: [
//           Container(
//               child: removeBtn == true
//                   ? InkWell(
//                       onTap: onTap,
//                       child: ImgIcon(
//                         color: redColor,
//                         src: 'assets/icons/delete-icon.png',
//                         width: 15,
//                         height: 15,
//                       ),
//                     )
//                   : null),
//           heightSizedBox(20.0),
//           Padding(
//             padding: const EdgeInsets.all(20),
//             child: Btn(
//               padding: EdgeInsets.all(3),
//               onTap: btnOnTap,
//               btnName: btnName ?? 'MOVE INTO BAG',
//               style: TextStyle(color: txtWhiteColor, fontSize: 10),
//               color: offgreenColor,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }
