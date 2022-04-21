import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groce1/Backend/Bloc/seller/selprod_bloc.dart';
import '../Elements/baseAppbar.dart';
import '../common/button.dart';
import '../common/formfield.dart';
import '../common/validate.dart';
import '../scrpart/imgslider.dart';
import '../utils/common.dart';
import '../utils/style.dart';

class SelProdAddScreen extends StatelessWidget {
  SelProdAddScreen({Key? key}) : super(key: key);

  final TextEditingController prodNameController = TextEditingController();
  final TextEditingController quantityController = TextEditingController();
  final TextEditingController mrpPriceController = TextEditingController();
  final TextEditingController offerPriceController = TextEditingController();
  final TextEditingController descriptionController = TextEditingController();

  dynamic img1;
  dynamic img2;
  dynamic img3;
  dynamic img4;

  // ! check imgSrc
  dynamic imgSrc1;
  dynamic imgSrc2;
  dynamic imgSrc3;
  dynamic imgSrc4;
  final _form = GlobalKey<FormState>();

  // List helpVal = ['1', '2', '3', '4'];
  // List prodList = [
  //   'assets/images/pulse.png',
  //   'assets/images/onion.png',
  //   // 'assets/images/snacks.png',
  //   'assets/images/potato.png',
  //   'assets/images/pulse.png',
  //   'assets/images/watermelon.png',
  // ];

  @override
  Widget build(BuildContext context) {
    _selProdMetod() async {
      var isvalid = _form.currentState!.validate();
      if (!isvalid) {
        return 'Please Enter Valid Data';
      }
      _form.currentState!.save();

      // ! new

      FormData prodItemM = new FormData.fromMap({
        "title": prodNameController.text,
        "description": descriptionController.text,
        "salesPrice": mrpPriceController.text,
        "discountPrice": offerPriceController.text,
        "stock": quantityController.text,
        "pic": img1,
        "pic1": img2,
        "pic2": img3,
        "pic3": img4,
      });
      var isregis =
          await BlocProvider.of<SelProductBloc>(context, listen: false)
            ..add(SelProdAddEvent(prodItemModel: prodItemM,context: context ));
    }

    // ! Method
    return Scaffold(
      appBar: BaseAppBar(
        title: 'Add Product',
        centerTitle: true,
      ),
      body: BlocConsumer<SelProductBloc, SelProductState>(
          listener: (context, state) {},
          builder: (context, state) {
            return Padding(
              padding:
                  const EdgeInsets.symmetric(horizontal: 15.0, vertical: 10),
              child: Form(
                key: _form,
                child: ListView(
                  children: [
                    EditTextField(
                      textAlign: TextAlign.left,
                      txtColor: txtBlackColor,
                      headTxt: 'Product Name',
                      // fillColor: borderColor,
                      hintText: 'Enter product name',
                      controller: prodNameController,
                      vertical: 15,
                      validator: validateField,
                    ),
                    heightSizedBox(10.0),
                    EditTextField(
                      textAlign: TextAlign.left,
                      txtColor: txtBlackColor,
                      headTxt: 'Stock or Quantity',
                      // fillColor: borderColor,
                      hintText: 'Enter Product  Stock or  Quantity ',
                      controller: quantityController,
                      vertical: 15, validator: validateField,
                    ),

                    // Container(
                    //   child: DropDownBtn(
                    //     vertical: 12,
                    //     labelText: 'Select Quantity',
                    //     listData: helpVal,
                    //     // fillColor: borderColor,
                    //     pageName: 'Select Quantity',
                    //     listController: QuantityController,
                    //   ),
                    // ),
                    heightSizedBox(10.0),
                    EditTextField(
                      vertical: 15,
                      textAlign: TextAlign.left,
                      txtColor: txtBlackColor,
                      headTxt: 'MRP',
                      // fillColor: borderColor,
                      hintText: 'Enter MRP Price',
                      controller: mrpPriceController,
                      validator: validateField,
                    ),
                    heightSizedBox(10.0),
                    EditTextField(
                      vertical: 15,
                      textAlign: TextAlign.left,
                      txtColor: txtBlackColor,
                      headTxt: 'Offer Price',
                      // fillColor: borderColor,
                      hintText: 'Enter Offer Price',
                      controller: offerPriceController,
                      validator: validateField,
                    ),
                    heightSizedBox(10.0),
                    Text(
                      'Upload Photo',
                      style: labelTextStyle,
                    ),
                    // UpdImgFile(
                    //   imgSrc1: 'assets/images/pulse.png',
                    //   imgSrc2: 'assets/images/onion.png',
                    //   imgSrc3: 'assets/images/potato.png',
                    // ),
                    heightSizedBox(10.0),
                    EditTextField(
                      // hoverColor: borderColor,
                      textAlign: TextAlign.left,
                      txtColor: txtBlackColor,
                      headTxt: 'Write Description',
                      // fillColor: borderColor,
                      hintText: 'Enter Description',
                      maxLines: 5,
                      controller: descriptionController,
                      validator: validateField,
                    )
                  ],
                ),
              ),
            );
          }),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: Btn(
          // alignment: Alignment.bottomLeft,
          height: 45,
          width: 100,
          btnName: 'Submit',
          txtColor: txtWhiteColor,
          color: offgreenColor,
          onTap: _selProdMetod,
        ),
      ),
    );
  }
}

// class UpdImgFile extends StatefulWidget {
//   final String? imgSrc1, imgSrc2, imgSrc3;
//   const UpdImgFile({Key? key, this.imgSrc1, this.imgSrc2, this.imgSrc3})
//       : super(key: key);

//   @override
//   State<UpdImgFile> createState() => _UpdImgFileState();
// }

// class _UpdImgFileState extends State<UpdImgFile> {
//   @override
//   Widget build(BuildContext context) {
//     return SizedBox(
//       height: 100,
//       width: 500,
//       child: ListView(
//           shrinkWrap: true,
//           scrollDirection: Axis.horizontal,
//           children: [
//             SelUpdMultiFile(
//                 cleanImg: () {
//                   setState(() {
//                     img1 = null;
//                     imgSrc1 = null;
//                   });
//                 },
//                 imgSrc: widget.imgSrc1,
//                 upDFile:
//                 () async {
//                   var image = await _picker.pickImage(
//                     source: ImageSource.gallery,
//                     imageQuality: 25,
//                   );

//                 setState(() {
//                   img1 = image;
//                   imgSrc1 = image!.path.toString();
//                   mimeTypeData1 =
//                       lookupMimeType(imgSrc1)!.split('/');
//                 });
//                 }
//                 ),
//             SelUpdMultiFile(
//               upDFile: () {},
//               cleanImg: () {
//                 // setState(() {
//                 //   img1 = null;
//                 //   imgSrc1 = null;
//                 // });
//               },
//               imgSrc: widget.imgSrc2,
//               // upDFile: () async {
//               //   var image = await _picker.pickImage(
//               //     source: ImageSource.gallery,
//               //     imageQuality: 25,
//               //   );

//               // setState(() {
//               //   img1 = image;
//               //   imgSrc1 = image!.path.toString();
//               //   mimeTypeData1 =
//               //       lookupMimeType(imgSrc1)!.split('/');
//               // });
//               // }
//             ),
//             SelUpdMultiFile(
//               upDFile: () {},
//               cleanImg: () {
//                 // setState(() {
//                 //   img1 = null;
//                 //   imgSrc1 = null;
//                 // });
//               },
//               imgSrc: widget.imgSrc3,
//               // upDFile: () async {
//               //   var image = await _picker.pickImage(
//               //     source: ImageSource.gallery,
//               //     imageQuality: 25,
//               //   );

//               // setState(() {
//               //   img3 = image;
//               //   imgSrc3 = image!.path.toString();
//               //   mimeTypeData1 =
//               //       lookupMimeType(imgSrc1)!.split('/');
//               // });
//               // }
//             ),
//           ]),
//     );
//   }
// }
