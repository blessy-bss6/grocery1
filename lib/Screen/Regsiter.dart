import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../Backend/Bloc/reg_Login_Bloc.dart';
import '../Screen/authconfrim.dart';
import '../Screen/login.dart';
import '../Screen/otpscreen.dart';
import '../common/validate.dart';
import '../utils/style.dart';

import '../Backend/Bloc/otpsBloc.dart';
import '../common/button.dart';
import '../common/formfield.dart';
import '../utils/common.dart';

class RegisterScr extends StatefulWidget {
  final bool? seller;
  const RegisterScr({Key? key, this.seller}) : super(key: key);

  @override
  _RegisterScrState createState() => _RegisterScrState();
}

class _RegisterScrState extends State<RegisterScr> {
  int activeIndex = 0;
  int totalIndex = 2;

  final mobileController = TextEditingController();
  final fullnameController = TextEditingController();
  final emailController = TextEditingController();
  final passwordController = TextEditingController();

  final _formKey = GlobalKey<FormState>();

  final TextEditingController _fieldOne = TextEditingController();
  final TextEditingController _fieldTwo = TextEditingController();
  final TextEditingController _fieldThree = TextEditingController();
  final TextEditingController _fieldFour = TextEditingController();

  String? otpData;

  _registerMethod() {
    var isvalid = _formKey.currentState!.validate();
    // print('valid $isvalid');
    if (!isvalid) {
      return 'Please Enter Valid Data';
    }
    _formKey.currentState!.save();
    if (isvalid == true) {
      BlocProvider.of<OtpBloc>(context, listen: false).add(SendOtpBtnEvent(
        phone: mobileController.text,context:context
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
                      t: 'Already have an account ?',
                      color: greyColor,
                    ),
                    heightSizedBox(5.0),
                    Btn(
                      onTap: () => navigationPush(context, RegisterScr()),
                      height: 40,
                      btnName: 'Login Here',
                      color: redColor,
                    ),
                  ],
                ),
              ))
          : null,
      body: BlocConsumer<OtpBloc, OtpState>(
        listener: (context, state) {
          if (state is OtpSuccess2State) {
            BlocProvider.of<AuthBloc>(context, listen: false).add(
                SignUpBtnEvent(
                    phone: mobileController.text,
                    fullname: fullnameController.text,
                    email: emailController.text,
                    password: passwordController.text,
                    isSeller: widget.seller,
                    context: context));
          }
        },
        builder: (context, state) {
          switch (activeIndex) {
            case 0:
              return signForm();
            case 1:
              return otpScreen();

            default:
              return signForm();
          }
        },
      ),
    );
  }

  Widget signForm() {
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
              title: 'Create an Account',
              msg:
                  'We are going to send you a OTP to \n authentic your phone number',
            ),
            //  TEXT FORM FIELD
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                children: [
                  EditTextField(
                    headTxt: 'fullname',
                    controller: fullnameController,
                    keyboardType: TextInputType.name,
                    maxLength: 10,
                    validator: validateField,
                  ),
                  EditTextField(
                    headTxt: 'Mobile',
                    controller: mobileController,
                    keyboardType: TextInputType.phone,
                    maxLength: 10,
                    validator: validateMobile,
                  ),
                  EditTextField(
                    headTxt: 'Email',
                    controller: emailController,
                    keyboardType: TextInputType.emailAddress,
                    // maxLength: 10,
                    validator: validateEmail,
                  ),
                  EditTextField(
                    headTxt: 'Password',
                    controller: passwordController,
                    keyboardType: TextInputType.visiblePassword,
                    // maxLength: 10,
                    validator: validateField,
                  ),
                  Padding(
                    padding: const EdgeInsets.all(20.0),
                    child: Btn(
                      onTap:  _registerMethod,


                      width: double.maxFinite,
                      height: 40,
                      btnName: 'CREATE ACCOUNT',
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
