import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Backend/Bloc/wishlist_Bloc.dart';
import '../Elements/baseAppbar.dart';
import '../common/button.dart';
import '../scrpart/imgslider.dart';
import '../utils/common.dart';
import '../utils/style.dart';

class WishListScreen extends StatelessWidget {
  WishListScreen({Key? key}) : super(key: key);

  WishListBloc prodBloc = WishListBloc();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        centerTitle: true,
        title: 'Wishlist',
      ),
      body: BlocProvider(
        create: (BuildContext context) =>
            WishListBloc()..add(FetchWishListEvent()),
        child: BlocConsumer<WishListBloc, WishListState>(
            listener: (contetx, state) {
          if (state is WishListDeleteState) {}
        }, builder: (context, state) {
          print(state);
          if (state is WishListSuccessState) {
            // print(state.data.length);

            return state.data.length > 0
                ? Container(
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
                              ProdMidContent(
                                prodNumber: state.data[i],
                                wishList: true,
                              ),
                              // lineRight()

                              Padding(
                                padding: const EdgeInsets.all(20),
                                child: Btn(
                                  padding: EdgeInsets.all(3),
                                  onTap: () {
                                    BlocProvider.of<WishListBloc>(context,
                                            listen: false)
                                        .add(WishListItemDelEvent(
                                      id: '${state.data[i]['id']}',
                                      context: context,
                                    ));
                                  },
                                  btnName: 'MOVE INTO BAG',
                                  style: TextStyle(
                                      color: txtWhiteColor, fontSize: 10),
                                  color: offgreenColor,
                                ),
                              ),

                              // ProdLastContent(
                              //   // src: 'assets/icons/delete-icon.png',
                              //   btnOnTap: () {
                              //     BlocProvider.of<WishListBloc>(context,
                              //             listen: false)
                              //         .add(WishListItemDelEvent(
                              //       id: '${state.data[i]['id']}',
                              //       context: context,
                              //     ));
                              //   },
                              //   btnName: 'MOVE INTO BAG',
                              // ),
                            ],
                          ),
                        );
                      }),
                      itemCount: state.data.length,
                    ),
                  )
                : Center(
                    child: Text('No Data'),
                  );
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        }),
      ),
    );
  }
}

// ! Product Mid Cotent
class ProdMidContent extends StatelessWidget {
  final dynamic prodNumber;
  final bool? wishList;
  final bool? stock;

  const ProdMidContent({Key? key, this.prodNumber, this.wishList=false, this.stock=false})
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
            ImgIcon(
              src: 'assets/icons/Star-icon.png',
              width: 10,
              height: 10,
            )
          ],
        ),

        // ! Title
        Container(
          child: Txt(
            t: '${wishList == true ? prodNumber['product']['title'] : prodNumber['title']}',
            fontSize: 15,
            fontWeight: FontWeight.bold,
          ),
        ),
        Container(
          alignment: Alignment.topLeft,
          child: Txt(
            t: stock ==true ? 'stock ${prodNumber['stock'].toString()}'
                : 'Quantity ${prodNumber['quantity'] ?? 1} KG',
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

// ! Product  last content
class ProdLastContent extends StatelessWidget {
  final dynamic onTap;

  final String? src;
  final Widget? child;
  final dynamic btnOnTap;
  final String? btnName;
  final bool? removeBtn;

  ProdLastContent(
      {Key? key,
      this.onTap,
      this.src,
      this.removeBtn,
      this.child,
      this.btnOnTap,
      this.btnName})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(top: 5.0, right: 8.0),
      child: Column(
        // mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Container(
              child: removeBtn == true
                  ? InkWell(
                      onTap: onTap,
                      child: ImgIcon(
                        color: redColor,
                        src: 'assets/icons/delete-icon.png',
                        width: 15,
                        height: 15,
                      ),
                    )
                  : null),
          heightSizedBox(20.0),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Btn(
              padding: EdgeInsets.all(3),
              onTap: btnOnTap,
              btnName: btnName ?? 'MOVE INTO BAG',
              style: TextStyle(color: txtWhiteColor, fontSize: 10),
              color: offgreenColor,
            ),
          ),
        ],
      ),
    );
  }
}
