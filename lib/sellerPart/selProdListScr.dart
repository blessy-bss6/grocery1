import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groce1/Backend/Bloc/seller/selprod_bloc.dart';
import '../Screen/wishlistScr.dart';
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
      appBar: AppBar(backgroundColor: offWhiteColor,
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
                            ProdMidContent(prodNumber: state.data[i]),
                            ProdLastContent(
                              // src: 'assets/icons/delete-icon.png',
                              btnOnTap: () async {
                                await showDialog(
                                  context: context,
                                  builder: (BuildContext context) {
                                    return AlertBox(
                                      title: 'Product Price',
                                      child: Column(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          EditTextField(
                                            vertical: 15,
                                            textAlign: TextAlign.left,
                                            txtColor: txtBlackColor,
                                            headTxt: 'MRP',
                                            // fillColor: borderColor,
                                            hintText: 'Enter MRP Price',
                                            controller: mrpPriceController,
                                          ),
                                          heightSizedBox(10),
                                          EditTextField(
                                            vertical: 15,
                                            textAlign: TextAlign.left,
                                            txtColor: txtBlackColor,
                                            headTxt: 'Offer Price',
                                            // fillColor: borderColor,
                                            hintText: 'Enter Offer Price',
                                            controller: offerPriceController,
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                );
                              },
                              btnName: ' Edit   ',
                              removeBtn: false,
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
