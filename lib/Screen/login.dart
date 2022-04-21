import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:groce1/Backend/Model/category.dart';
import '../Backend/Bloc/otpsBloc.dart';
import '../Screen/Regsiter.dart';
import '../Screen/authconfrim.dart';
import '../Screen/otpscreen.dart';
import '../common/validate.dart';
import '../utils/app_constants.dart';
import '../utils/http_services.dart';
import '../utils/style.dart';

import '../Backend/Bloc/reg_Login_Bloc.dart';
import '../common/button.dart';
import '../common/formfield.dart';
import '../utils/common.dart';

class LoginScr extends StatefulWidget {
  final bool? seller;
  const LoginScr({Key? key, this.seller}) : super(key: key);

  @override
  _LoginScrState createState() => _LoginScrState();
}

class _LoginScrState extends State<LoginScr> {
  int activeIndex = 0;
  int totalIndex = 2;

  final mobileController = TextEditingController();
  final passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _fieldOne = TextEditingController();
  final TextEditingController _fieldTwo = TextEditingController();
  final TextEditingController _fieldThree = TextEditingController();
  final TextEditingController _fieldFour = TextEditingController();

  String? otpData;

  Dio _dio = Dio();

  _loginMethod() {
    var isvalid = _formKey.currentState!.validate();
    // print('valid $isvalid');
    if (!isvalid) {
      return 'Please Enter Valid Data';
    }
    _formKey.currentState!.save();
    if (isvalid == true) {
      BlocProvider.of<OtpBloc>(context, listen: false).add(SendOtpBtnEvent(
        phone: mobileController.text, context: context,
      ));

      setState(() {
        activeIndex++;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      // appBar: AppBar(
      //   title: const Text(
      //     "Using Provider",
      //   ),
      // ),
      bottomNavigationBar: activeIndex == 0
          ? Container(
              height: 85,
              decoration: BoxDecoration(
                color: offWhiteColor,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: Padding(
                padding: const EdgeInsets.only(
                    top: 18.0, left: 25, right: 25, bottom: 5),
                child: Column(
                  children: [
                    Txt(
                      t: 'Don\'t have account ?',
                      color: greyColor,
                    ),
                    heightSizedBox(5.0),
                    Btn(
                      onTap: () => navigationPush(
                          context,
                          RegisterScr(
                            seller: widget.seller,
                          )),
                      height: 40,
                      btnName: 'Create an account',
                      color: redColor,
                    ),
                  ],
                ),
              ),
            )
          : null,
      body: BlocConsumer<OtpBloc, OtpState>(
        listener: (context, state) {
          if (state is OtpSuccess2State) {
            BlocProvider.of<AuthBloc>(context, listen: false).add(LoginBtnEvent(
                phone: mobileController.text,
                isSeller: widget.seller,
                context: context));
          }
        },
        builder: (context, state) {
          switch (activeIndex) {
            case 0:
              return loginForm();
            case 1:
              return otpScreen();

            default:
              return loginForm();
          }
        },
      ),
    );
  }

  Widget loginForm() {
    return Form(
      key: _formKey,
      child: Container(
        width: double.infinity,
        height: double.infinity,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(6),
          image: DecorationImage(
              image: AssetImage('assets/images/bg02.png'), fit: BoxFit.fill),
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            WelcomeTxt(
              msg: 'Welcome to Login Page ',
            ),
            //  TEXTFORMFIELD
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  Txt(
                    t: 'Enter Mobile Number',
                    fontSize: 12,
                    color: txtWhiteColor,
                  ),
                  EditTextField(
                    controller: mobileController,
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    validator: validateMobile,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Btn(
                      onTap: _loginMethod,
                      width: double.maxFinite,
                      height: 40,
                      btnName: 'LOGIN',
                      color: marronColor,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget otpScreen() {
    return Container(
      width: double.infinity,
      height: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(3),
        image: DecorationImage(
            image: AssetImage('assets/images/bg02.png'), fit: BoxFit.fill),
      ),
      child: Padding(
        padding: const EdgeInsets.only(top: 30.0),
        child: Column(
          // mainAxisAlignment: MainAxisAlignment.center,
          children: [
            WelcomeTxt(
              title: 'Enter Verfication Code',
              msg: 'We have sent OTP on your number ',
            ),
            heightSizedBox(50.0),
            // Implement 4 input fields
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                OtpInput(_fieldOne, true),
                OtpInput(_fieldTwo, false),
                OtpInput(_fieldThree, false),
                OtpInput(_fieldFour, false)
              ],
            ),
            heightSizedBox(
              30.0,
            ),
            // ! BUTTON OF VERIFY
            Padding(
              padding: const EdgeInsets.all(25.0),
              child: Btn(
                onTap: () {
                  setState(() {
                    otpData = _fieldOne.text +
                        _fieldTwo.text +
                        _fieldThree.text +
                        _fieldFour.text;
                  });
                  if (otpData!.length == 4) {
                    BlocProvider.of<OtpBloc>(context, listen: false).add(
                        VerifyOtpBtnEvent(
                            phone: mobileController.text,
                            otp: otpData,
                            context: context));
                    if (widget.seller == true) {
                      // navigationRemoveUntil(context, SellerNavigationBar(currentTab: 0));
                    } else {}
                  } else {
                    snackBar(context, 'Please fill otp first');
                  }
                },
                width: double.maxFinite,
                height: 40,
                btnName: 'VERIFY',
                color: marronColor,
              ),
            ),
          ],
        ),
      ),
    );
  }
}








// ! LOGIN FORM

// class LoginScr extends StatefulWidget {
//   final bool? seller;

//   LoginScr({Key? key, this.seller}) : super(key: key);

//   @override
//   State<LoginScr> createState() => _LoginScrState();
// }

// class _LoginScrState extends State<LoginScr> {
//   final mobileController = TextEditingController();
//   final _formKey = GlobalKey<FormState>();
//   // ! rister method

//   // ! end register method

//   @override
//   Widget build(BuildContext context) {
//     _loginMethod() async {
//       var isvalid = _formKey.currentState!.validate();
//       // print('valid $isvalid');
//       if (!isvalid) {
//         return 'Please Enter Valid Data';
//       }
//       _formKey.currentState!.save();
//       if (isvalid == true) {
//         BlocProvider.of<AuthBloc>(context, listen: false).add(LoginBtnEvent(
//             phone: mobileController.text, isSeller: false, context: context));
//       }
//     }

//     return Scaffold(
//       bottomNavigationBar:
//           // bottomSheet:
//           Container(
//         height: 85,
//         decoration: BoxDecoration(
//           color: offWhiteColor,
//           borderRadius: BorderRadius.only(
//             topLeft: Radius.circular(25),
//             topRight: Radius.circular(25),
//           ),
//         ),
//         child: Padding(
//           padding:
//               const EdgeInsets.only(top: 18.0, left: 25, right: 25, bottom: 5),
//           child: Column(
//             children: [
//               Txt(
//                 t: 'Don\'t have account ?',
//                 color: greyColor,
//               ),
//               heightSizedBox(5.0),
//               Btn(
//                 onTap: () => navigationPush(context, RegisterScr()),
//                 height: 40,
//                 btnName: 'Create an account',
//                 color: redColor,
//               ),
//             ],
//           ),
//         ),
//       ),
//       body: BlocConsumer<AuthBloc, AuthState>(
//         listener: (context, state) {},
//         builder: (context, state) => Form(
//           key: _formKey,
//           child: Container(
//             width: double.infinity,
//             height: double.infinity,
//             decoration: BoxDecoration(
//               // borderRadius: BorderRadius.only(
//               //   bottomLeft: Radius.circular(25),
//               //   bottomRight: Radius.circular(25),
//               // ),
//               borderRadius: BorderRadius.circular(6),
//               image: DecorationImage(
//                   image: AssetImage('assets/images/bg02.png'),
//                   fit: BoxFit.fill),
//             ),
//             child: Column(
//               mainAxisAlignment: MainAxisAlignment.center,
//               children: [
//                 WelcomeTxt(
//                   msg: 'Welcome to Login Page ',
//                 ),
//                 //  TEXTFORMFIELD
//                 Padding(
//                   padding: const EdgeInsets.all(8.0),
//                   child: Column(
//                     children: [
//                       Txt(
//                         t: 'Enter Mobile Number',
//                         fontSize: 12,
//                         color: txtWhiteColor,
//                       ),
//                       EditTextField(
//                         controller: mobileController,
//                         validator: (v) {
//                           if (v == null || v.isEmpty) {
//                             return 'Field is requred';
//                           }
//                         },
//                         // keyboardType: TextInputType.phone,
//                         // maxLength: 10,
//                         // validator: validateMobile,
//                       ),
//                       Padding(
//                         padding: const EdgeInsets.all(20.0),
//                         child: Btn(
//                           onTap:()=> _loginMethod(),
//                           width: double.maxFinite,
//                           height: 40,
//                           btnName: 'LOGIN',
//                           color: marronColor,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }
