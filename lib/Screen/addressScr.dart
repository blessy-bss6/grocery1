import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groce1/Elements/baseAppbar.dart';

import '../Backend/Bloc/address_Bloc.dart';
import '../common/button.dart';
import '../common/formfield.dart';
import '../common/validate.dart';

import '../utils/common.dart';
import '../utils/style.dart';
import 'cartScr.dart';
import 'order.dart';

class AddressScreen extends StatefulWidget {
  final dynamic orderData;
  AddressScreen({Key? key, this.orderData}) : super(key: key);

  @override
  State<AddressScreen> createState() => _AddressScreenState();
}

class _AddressScreenState extends State<AddressScreen> {
  dynamic groupValue = 0;
  dynamic addressId;
  AddressBloc addressB = AddressBloc();

  @override
  void initState() {
    super.initState();
    addressB = BlocProvider.of<AddressBloc>(context, listen: false);
    addressB.add(FetchAddressEvent());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Address Screen',
          style: appBarTS,
        ),
        // automaticallyImplyLeading: false,
        centerTitle: true,
        backgroundColor: offWhiteColor,
        leading: IconButton(
          color: blackColor,
          icon: const Icon(Icons.arrow_back),
          onPressed: () => navigationPush(context, CartScreen()),
        ),
      ),
      body: BlocConsumer<AddressBloc, AddressState>(listener: (context, state) {
        if (state is AddressSuccessState) {
          if (state.data['data'].length > 0) {
            setState(() {
              // addressId = state.data['data'][0]['id'];
              addressId = state.data['data'][0];
            });
          } else {
            setState(() {
              // addressId = state.data['data'][0]['id'];
              addressId = null;
            });
          }
        }
      }, builder: (context, state) {
        if (state is AddressSuccessState) {
          final lData = state.data['data'];

          return ListView(
            shrinkWrap: true,
            children: [
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Select Address',
                      style: labelTextStyle,
                    ),
                    Btn(
                        btnName: 'Add Address',
                        color: offgreenColor,
                        padding: EdgeInsets.all(2),
                        onTap: () =>
                            navigationPush(context, AddAddressScreen()))
                  ],
                ),
              ),
              Container(
                  child: lData.length > 0
                      ? ListView.builder(
                          itemCount: lData.length,
                          shrinkWrap: true,
                          itemBuilder: (context, index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: Card(
                                  child: Column(
                                children: [
                                  RadioBtn(
                                    value: index,
                                    groupValue: groupValue,
                                    onChanged: (val) => setState(() {
                                      groupValue = index;
                                      // addressId = lData[index]['id'];
                                      addressId = lData[index];
                                    }),
                                    title: '${lData[index]['fullname']}',
                                    subTitle: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                            '${lData[index]['email'] ?? ''} \n ${lData[index]['phone']}',
                                            style: labelTextStyle),
                                        Text(
                                            '${lData[index]['trade'] ?? ''} \n ${lData[index]['area'] ?? ''}',
                                            style: labelTextStyle),
                                        Text(
                                            '${lData[index]['city']}  ${lData[index]['town'] ?? ''}',
                                            style: labelTextStyle),
                                        Text(
                                            '${lData[index]['pinCode']}  ${lData[index]['state']}',
                                            style: labelTextStyle),
                                      ],
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Expanded(
                                        child: Btn(
                                            margin: EdgeInsets.all(3.0),
                                            // alignment: Alignment.bottomLeft,
                                            height: 20,
                                            // width: double.infinity,
                                            btnName: 'Update',
                                            txtColor: txtWhiteColor,
                                            color: textBlueColor,
                                            onTap: () {
                                              navigationPush(
                                                  context,
                                                  UpdateAddressScreen(
                                                      address: lData[index]));
                                            }),
                                      ),
                                      // SizedBox(width: 5.0),
                                      Expanded(
                                        child: Btn(
                                            margin: EdgeInsets.all(3.0),
                                            // alignment: Alignment.bottomLeft,
                                            height: 20,
                                            // width: double.infinity,
                                            btnName: 'Delete',
                                            txtColor: txtWhiteColor,
                                            color: redColor,
                                            onTap: () {
                                              BlocProvider.of<AddressBloc>(
                                                  context,
                                                  listen: false)
                                                ..add(AddressItemDelEvent(
                                                  id: lData[index]['id'],
                                                  context: context,
                                                ));
                                            }),
                                      ),
                                    ],
                                  )
                                ],
                              )),
                            );
                          })
                      : Center(
                          child: Text('No Data'),
                        )),
            ],
          );
        }
        return Center(child: CircularProgressIndicator());
      }),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
        child: Btn(
            // alignment: Alignment.bottomLeft,
            height: 35,
            width: double.infinity,
            btnName: 'Selected Address',
            txtColor: txtWhiteColor,
            color: offgreenColor,
            onTap: () {
              if (addressId != null && addressId.isNotEmpty) {
                navigationPush(context, OrderScreen(addressId: addressId));
              } else {
                snackBar(context, 'Selecet Address');
              }
            }),
      ),
    );
  }
}

class AddAddressScreen extends StatelessWidget {
  AddAddressScreen({Key? key}) : super(key: key);
  final TextEditingController fNameController = TextEditingController();
  final TextEditingController lNameController = TextEditingController();

  final TextEditingController companyController = TextEditingController();
  final TextEditingController countryController = TextEditingController();

  final TextEditingController street1Controller = TextEditingController();
  final TextEditingController street2Controller = TextEditingController();

  final TextEditingController townController = TextEditingController();
  final TextEditingController stateController = TextEditingController();
  final TextEditingController pinCodeController = TextEditingController();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController mobileController = TextEditingController();
  final TextEditingController delTimeController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    //  ! save method data
    _saveMethod() async {
      var isvalid = _formKey.currentState!.validate();

      if (!isvalid) {
        return 'Please Enter Valid Data';
      }
      _formKey.currentState!.save();
      if (isvalid == true) {
        FormData addressData = FormData.fromMap({
          "fullname": fNameController.text,
          "phone": mobileController.text,
          "email": emailController.text,
          "house": street1Controller.text,
          "trade": street2Controller.text,
          "area": '',
          "city": townController.text,
          "pinCode": pinCodeController.text,
          "delTime": delTimeController.text,
          "state": stateController.text,
        });

        print("condtion is true");
        BlocProvider.of<AddressBloc>(context, listen: false)
          ..add(AddressItemAddEvent(
            addressItem: addressData,
            context: context,
          ));
        navigationPush(context, AddressScreen());
      }
    }

    return Scaffold(
        appBar: BaseAppBar(title: 'Add Address'),
        body:
            BlocConsumer<AddressBloc, AddressState>(listener: (context, state) {
          // if (state is AddressSuccessState) {

          // }
        }, builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  EditTextField(
                    textAlign: TextAlign.left,
                    txtColor: txtBlackColor,
                    formBox: true,
                    // fillColor: borderColor,
                    headTxt: 'FirstName',
                    // hintText: 'Enter First Name',
                    controller: fNameController,
                    vertical: 15,

                    validator: (v) => validateField(v!),
                  ),
                  heightSizedBox(10.0),
                  // EditTextField(
                  //   textAlign: TextAlign.left,
                  //   txtColor: txtBlackColor,
                  //   formBox: true,
                  //   // fillColor: borderColor,
                  //   headTxt: 'Last Name',
                  //   // hintText: 'Enter Last Name',
                  //   controller: lNameController,
                  //   vertical: 15,

                  //   validator: (v) => validateField(v!),
                  // ),
                  // heightSizedBox(10.0),

                  EditTextField(
                    textAlign: TextAlign.left,
                    txtColor: txtBlackColor,
                    formBox: true,
                    // fillColor: borderColor,
                    headTxt: 'Street address',
                    hintText: 'House Number and street number',
                    controller: street1Controller,
                    vertical: 15,

                    validator: (v) => validateField(v!),
                  ),

                  heightSizedBox(10.0),
                  EditTextField(
                    textAlign: TextAlign.left,
                    txtColor: txtBlackColor,
                    formBox: true,
                    // fillColor: borderColor,
                    hintText: 'Apartment , suite ,etc',
                    controller: street2Controller,
                    vertical: 15,

                    validator: (v) => validateField(v!),
                  ),

                  heightSizedBox(10.0),
                  EditTextField(
                    textAlign: TextAlign.left,
                    txtColor: txtBlackColor,
                    formBox: true,
                    // fillColor: borderColor,
                    headTxt: 'Town/City',
                    controller: townController,
                    vertical: 15,

                    validator: (v) => validateField(v!),
                  ),
                  heightSizedBox(10.0),
                  EditTextField(
                    textAlign: TextAlign.left,
                    txtColor: txtBlackColor,
                    formBox: true,
                    // fillColor: borderColor,
                    headTxt: 'State',
                    controller: stateController,
                    vertical: 15,

                    validator: (v) => validateField(v!),
                  ),

                  heightSizedBox(10.0),
                  EditTextField(
                    textAlign: TextAlign.left,
                    txtColor: txtBlackColor,
                    formBox: true,
                    // fillColor: borderColor,
                    headTxt: 'PIN',
                    keyboardType: TextInputType.number,
                    controller: pinCodeController,
                    vertical: 15,

                    validator: (v) => validateField(v!),
                  ),

                  // ! Email and Phonen
                  heightSizedBox(10.0),
                  EditTextField(
                    textAlign: TextAlign.left,
                    txtColor: txtBlackColor,
                    formBox: true,
                    // fillColor: borderColor,
                    headTxt: 'Email',

                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    vertical: 15,

                    validator: (v) => validateEmail(v!),
                  ),
                  heightSizedBox(10.0),
                  EditTextField(
                    textAlign: TextAlign.left,
                    txtColor: txtBlackColor,
                    // formBox: true,
                    // fillColor: borderColor,
                    headTxt: 'Mobile',
                    // hintText: 'Enter Username',
                    maxLength: 10,
                    controller: mobileController,
                    keyboardType: TextInputType.phone,
                    validator: (v) => validateField(v!),
                    vertical: 15,
                  ),
                  heightSizedBox(10.0),
                  EditTextField(
                    textAlign: TextAlign.left,
                    txtColor: txtBlackColor,
                    // formBox: true,
                    // fillColor: borderColor,
                    headTxt: 'Delivery Time',
                    // hintText: 'Enter Username',
                    maxLength: 10,
                    controller: delTimeController,
                    keyboardType: TextInputType.text,
                    validator: (v) => validateField(v!),
                    vertical: 15,
                  ),
                ],
              ),
            ),
          );
        }),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Btn(
              // alignment: Alignment.bottomLeft,
              height: 35,
              width: double.infinity,
              btnName: 'Add Address',
              // txtColor: txtWhiteColor,
              color: offgreenColor,
              onTap: _saveMethod),
        ));
  }
}

// ! Address Upadate Scrreen

class UpdateAddressScreen extends StatefulWidget {
  final dynamic address;
  UpdateAddressScreen({Key? key, this.address}) : super(key: key);

  @override
  State<UpdateAddressScreen> createState() => _UpdateAddressScreenState();
}

class _UpdateAddressScreenState extends State<UpdateAddressScreen> {
  final TextEditingController fNameController = TextEditingController();

  final TextEditingController lNameController = TextEditingController();

  final TextEditingController companyController = TextEditingController();

  final TextEditingController countryController = TextEditingController();

  final TextEditingController street1Controller = TextEditingController();

  final TextEditingController street2Controller = TextEditingController();

  final TextEditingController townController = TextEditingController();

  final TextEditingController stateController = TextEditingController();

  final TextEditingController pinCodeController = TextEditingController();

  final TextEditingController emailController = TextEditingController();

  final TextEditingController mobileController = TextEditingController();

  final TextEditingController delTimeController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  @override
  void initState() {
    setDefultData();

    super.initState();
  }

  setDefultData() {
    fNameController.text = widget.address['fullname'];
    mobileController.text = widget.address['phone'].toString();
    emailController.text = widget.address['email'];
    street1Controller.text = widget.address['house'];
    street2Controller.text = widget.address['trade'];
    townController.text = widget.address['city'];
    pinCodeController.text = widget.address['pinCode'].toString();
    delTimeController.text = widget.address['delTime'];
    stateController.text = widget.address['state'];
  }

  @override
  Widget build(BuildContext context) {
    //  ! save method data
    _saveMethod() async {
      var isvalid = _formKey.currentState!.validate();

      if (!isvalid) {
        return 'Please Enter Valid Data';
      }
      _formKey.currentState!.save();
      if (isvalid == true) {
        FormData addressData = FormData.fromMap({
          "id": widget.address["id"],
          "fullname": fNameController.text,
          "phone": mobileController.text,
          "email": emailController.text,
          "house": street1Controller.text,
          "trade": street2Controller.text,
          "area": '',
          "city": townController.text,
          "pinCode": pinCodeController.text,
          "delTime": delTimeController.text,
          "state": stateController.text,
        });

        // print("condtion is true");
        BlocProvider.of<AddressBloc>(context, listen: false)
          ..add(AddressItemPutEvent(
            addressItem: addressData,
            context: context,
          ));
        navigationPush(context, AddressScreen());
      }
    }

    return Scaffold(
        appBar: BaseAppBar(title: 'Update Address'),
        body:
            BlocConsumer<AddressBloc, AddressState>(listener: (context, state) {
          // if (state is AddressSuccessState) {

          // }
        }, builder: (context, state) {
          return Padding(
            padding: const EdgeInsets.all(8.0),
            child: Form(
              key: _formKey,
              child: ListView(
                children: [
                  EditTextField(
                    textAlign: TextAlign.left,
                    txtColor: txtBlackColor,
                    formBox: true,
                    // fillColor: borderColor,
                    headTxt: 'FullName',
                    // hintText: 'Enter First Name',
                    controller: fNameController,
                    vertical: 15,

                    validator: (v) => validateField(v!),
                  ),
                  heightSizedBox(10.0),
                  // EditTextField(
                  //   textAlign: TextAlign.left,
                  //   txtColor: txtBlackColor,
                  //   formBox: true,
                  //   // fillColor: borderColor,
                  //   headTxt: 'Last Name',
                  //   // hintText: 'Enter Last Name',
                  //   controller: lNameController,
                  //   vertical: 15,

                  //   validator: (v) => validateField(v!),
                  // ),
                  // heightSizedBox(10.0),

                  EditTextField(
                    textAlign: TextAlign.left,
                    txtColor: txtBlackColor,
                    formBox: true,
                    // fillColor: borderColor,
                    headTxt: 'Street address',
                    hintText: 'House Number and street number',
                    controller: street1Controller,
                    vertical: 15,

                    validator: (v) => validateField(v!),
                  ),

                  heightSizedBox(10.0),
                  EditTextField(
                    textAlign: TextAlign.left,
                    txtColor: txtBlackColor,
                    formBox: true,
                    // fillColor: borderColor,
                    hintText: 'Apartment , suite ,etc',
                    controller: street2Controller,
                    vertical: 15,

                    validator: (v) => validateField(v!),
                  ),

                  heightSizedBox(10.0),
                  EditTextField(
                    textAlign: TextAlign.left,
                    txtColor: txtBlackColor,
                    formBox: true,
                    // fillColor: borderColor,
                    headTxt: 'Town/City',
                    controller: townController,
                    vertical: 15,

                    validator: (v) => validateField(v!),
                  ),
                  heightSizedBox(10.0),
                  EditTextField(
                    textAlign: TextAlign.left,
                    txtColor: txtBlackColor,
                    formBox: true,
                    // fillColor: borderColor,
                    headTxt: 'State',
                    controller: stateController,
                    vertical: 15,

                    validator: (v) => validateField(v!),
                  ),

                  heightSizedBox(10.0),
                  EditTextField(
                    textAlign: TextAlign.left,
                    txtColor: txtBlackColor,
                    formBox: true,
                    // fillColor: borderColor,
                    headTxt: 'PIN',
                    keyboardType: TextInputType.number,
                    controller: pinCodeController,
                    vertical: 15,

                    validator: (v) => validateField(v!),
                  ),

                  // ! Email and Phonen
                  heightSizedBox(10.0),
                  EditTextField(
                    textAlign: TextAlign.left,
                    txtColor: txtBlackColor,
                    formBox: true,
                    // fillColor: borderColor,
                    headTxt: 'Email',

                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    vertical: 15,

                    validator: (v) => validateEmail(v!),
                  ),
                  heightSizedBox(10.0),
                  EditTextField(
                    textAlign: TextAlign.left,
                    txtColor: txtBlackColor,
                    // formBox: true,
                    // fillColor: borderColor,
                    headTxt: 'Mobile',
                    // hintText: 'Enter Username',
                    maxLength: 10,
                    controller: mobileController,
                    keyboardType: TextInputType.phone,
                    validator: (v) => validateField(v!),
                    vertical: 15,
                  ),
                  heightSizedBox(10.0),
                  EditTextField(
                    textAlign: TextAlign.left,
                    txtColor: txtBlackColor,
                    // formBox: true,
                    // fillColor: borderColor,
                    headTxt: 'Delivery Time',
                    // hintText: 'Enter Username',
                    maxLength: 10,
                    controller: delTimeController,
                    keyboardType: TextInputType.text,
                    validator: (v) => validateField(v!),
                    vertical: 15,
                  ),
                ],
              ),
            ),
          );
        }),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
          child: Btn(
              // alignment: Alignment.bottomLeft,
              height: 35,
              width: double.infinity,
              btnName: 'Update Address',
              // txtColor: txtWhiteColor,
              color: offgreenColor,
              onTap: _saveMethod),
        ));
  }
}

// class BillingAddress extends StatelessWidget {
//   BillingAddress({Key? key}) : super(key: key);
//   final TextEditingController fNameController = TextEditingController();
//   final TextEditingController lNameController = TextEditingController();

//   final TextEditingController companyController = TextEditingController();
//   final TextEditingController countryController = TextEditingController();

//   final TextEditingController street1Controller = TextEditingController();
//   final TextEditingController street2Controller = TextEditingController();

//   final TextEditingController townController = TextEditingController();
//   final TextEditingController stateController = TextEditingController();
//   final TextEditingController pinCodeController = TextEditingController();

//   final TextEditingController emailController = TextEditingController();
//   final TextEditingController mobileController = TextEditingController();

//   final _formKey = GlobalKey<FormState>();

//   @override
//   Widget build(BuildContext context) {
//     _saveMethod() async {
//       var isvalid = _formKey.currentState!.validate();

//       if (!isvalid) {
//         return 'Please Enter Valid Data';
//       }
//       _formKey.currentState!.save();
//       // if (isvalid == true) {
//       //   print("condtion is true");
//       // navigationPush(
//       //     context,
//       //     UserNavigationBar(
//       //       currentTab: 0,
//       //     ));
//       // }
//     }

//     return Stack(
//       children: [
//         Form(
//           key: _formKey,
//           child: ListView(
//             shrinkWrap: true,
//             children: [
//               EditTextField(
//                 textAlign: TextAlign.left,
//                 txtColor: txtBlackColor,
//                 formBox: true,
//                 fillColor: borderColor,
//                 headTxt: 'FirstName',
//                 // hintText: 'Enter First Name',
//                 controller: fNameController,
//                 vertical: 15,
//                 // validator: validateField,
//                 validator: (v) => validateField(v!),
//               ),
//               heightSizedBox(10.0),
//               EditTextField(
//                 textAlign: TextAlign.left,
//                 txtColor: txtBlackColor,
//                 formBox: true,
//                 fillColor: borderColor,
//                 headTxt: 'Last Name',
//                 // hintText: 'Enter Last Name',
//                 controller: lNameController,
//                 vertical: 15,
//                 // validator: validateField,
//                 validator: (v) => validateField(v!),
//               ),
//               heightSizedBox(10.0),
//               EditTextField(
//                 textAlign: TextAlign.left,
//                 txtColor: txtBlackColor,
//                 formBox: true,
//                 fillColor: borderColor,
//                 headTxt: 'Country name (optional)',
//                 // hintText: 'Enter Email',
//                 controller: countryController,
//                 vertical: 15,
//                 // validator: validateField,
//               ),
//               heightSizedBox(10.0),
//               EditTextField(
//                 textAlign: TextAlign.left,
//                 txtColor: txtBlackColor,
//                 formBox: true,
//                 fillColor: borderColor,
//                 headTxt: 'Street address',
//                 hintText: 'House Number and street number',
//                 controller: street1Controller,
//                 vertical: 15,
//                 // validator: validateField,
//                 validator: (v) => validateField(v!),
//               ),

//               heightSizedBox(10.0),
//               EditTextField(
//                 textAlign: TextAlign.left,
//                 txtColor: txtBlackColor,
//                 formBox: true,
//                 fillColor: borderColor,
//                 hintText: 'Apartment , suit ,etc',
//                 controller: street2Controller,
//                 vertical: 15,
//                 // validator: validateField,
//                 validator: (v) => validateField(v!),
//               ),

//               heightSizedBox(10.0),
//               EditTextField(
//                 textAlign: TextAlign.left,
//                 txtColor: txtBlackColor,
//                 formBox: true,
//                 fillColor: borderColor,
//                 headTxt: 'Town/City',
//                 controller: townController,
//                 vertical: 15,
//                 // validator: validateField,
//                 validator: (v) => validateField(v!),
//               ),
//               heightSizedBox(10.0),
//               EditTextField(
//                 textAlign: TextAlign.left,
//                 txtColor: txtBlackColor,
//                 formBox: true,
//                 fillColor: borderColor,
//                 headTxt: 'State',
//                 controller: stateController,
//                 vertical: 15,
//                 // validator: validateField,
//                 validator: (v) => validateField(v!),
//               ),

//               heightSizedBox(10.0),
//               EditTextField(
//                 textAlign: TextAlign.left,
//                 txtColor: txtBlackColor,
//                 formBox: true,
//                 fillColor: borderColor,
//                 headTxt: 'PIN',
//                 keyboardType: TextInputType.number,
//                 controller: pinCodeController,
//                 vertical: 15,
//                 // validator: validateField,
//                 validator: (v) => validateField(v!),
//               ),

//               // ! Email and Phonen
//               heightSizedBox(10.0),
//               EditTextField(
//                 textAlign: TextAlign.left,
//                 txtColor: txtBlackColor,
//                 formBox: true,
//                 fillColor: borderColor,
//                 headTxt: 'Email',
//                 // hintText: 'Enter Email',
//                 controller: emailController,
//                 keyboardType: TextInputType.emailAddress,
//                 vertical: 15,
//                 // validator: validateField,
//                 validator: (v) => validateEmail(v!),
//               ),
//               heightSizedBox(10.0),
//               EditTextField(
//                 textAlign: TextAlign.left,
//                 txtColor: txtBlackColor,
//                 formBox: true,
//                 fillColor: borderColor,
//                 headTxt: 'Mobile',
//                 // hintText: 'Enter Username',
//                 maxLength: 10,
//                 controller: mobileController,
//                 keyboardType: TextInputType.phone,
//                 validator: (v) => validateField(v!),
//                 vertical: 15,
//                 // validator: validateField,
//               ),
//               heightSizedBox(50.0)
//             ],
//           ),
//         ),

//         // ! Button
//         Positioned(
//           left: 50.0,
//           bottom: 0.0,
//           width: getWidth(context) / 1.3,
//           child: Container(
//             height: 50,
//             decoration: BoxDecoration(
//               color: offWhiteColor,
//               borderRadius: BorderRadius.only(
//                 topLeft: Radius.circular(25),
//                 topRight: Radius.circular(25),
//               ),
//             ),
//             child: Btn(
//               onTap: _saveMethod,
//               height: 40,
//               btnName: ' Save',
//               color: redColor,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }
