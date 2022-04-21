import 'package:flutter/material.dart';
import '../Screen/authconfrim.dart';
import '../utils/style.dart';
import '../common/button.dart';
import '../utils/common.dart';

class WelcomeScreen extends StatefulWidget {
  const WelcomeScreen({Key? key}) : super(key: key);

  @override
  State<WelcomeScreen> createState() => _WelcomeScreenState();
}

class _WelcomeScreenState extends State<WelcomeScreen> {
  dynamic index;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(child: screen()),
    );
  }

  Widget? screen() {
    if (index == 1) {
      return WelcomeBody(
        imgSrc: 'assets/icons/img-2.png',
        title: 'Hassle Free Payments',
        isActive2: true,
        msg:
            'Pay as per your Convenience , we accept \n all credit and debit cards.',
        onTap: () {
          // print('go to third');
          setState(() {
            index = 2;
          });
        },
      );
    }

    if (index == 2) {
      return WelcomeBody(
        imgSrc: 'assets/icons/img-3.png',
        title: 'Fast Doorstep Deliveries',
        isActive3: true,
        msg:
            'Our Delivery Executive will deliver your order  \n in under 2 Hours',
        onTap: () {
          // print('final Screen');

          navigationPush(context, AuthOptionScr());
        },
        btnName: 'Get Started',
      );
    }

    return WelcomeBody(
      isActive1: true,
      imgSrc: 'assets/icons/img-1.png',
      title: 'Need Groceries Now ?',
      msg: 'Select Wide Range of Grocery items form \n our application',
      onTap: () {
        // print('go to second');
        setState(() {
          index = 1;
        });
      },
    );
  }
}

class WelcomeBody extends StatelessWidget {
  final Widget? child;
  final String? imgSrc;
  final String? btnName;
  final dynamic onTap;
  final String? title;
  final String? msg;
  final bool? currentScreen;
  final bool? isActive1;
  final bool? isActive2;
  final bool? isActive3;

  const WelcomeBody(
      {Key? key,
      this.imgSrc,
      this.child,
      this.btnName,
      this.msg,
      this.onTap,
      this.title,
      this.isActive1,
      this.isActive2,
      this.isActive3,
      this.currentScreen = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        // 1. Images
        Container(
          width: double.infinity,
          height: 250,
          child: Image.asset(imgSrc!),
        ),

        // ! 2. Welcome Txt
        WelcomeTxt(
          title: title ?? 'Need Groceries Now ?',
          color1: redColor,
          msg: msg ??
              'Select Wide Range of Grocery items form \n our application',
          color2: blackColor,
        ),
        heightSizedBox(10.0),
        // ! 3. Dot Screen
        // Container(
        //   child: child,
        // ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SingleDot(
              isActive: isActive1 ?? false,
            ),
            SingleDot(
              isActive: isActive2 ?? false,
            ),
            SingleDot(
              isActive: isActive3 ?? false,
            ),
          ],
        ),
        // ! 4. Button for
        Padding(
          padding: const EdgeInsets.only(right: 25, left: 25),
          child: Btn(
            height: 40,
            btnName: btnName ?? 'Next',
            txtColor: txtWhiteColor,
            onTap: onTap,
            color: offgreenColor,
          ),
        )
      ],
    );
  }
}

class SingleDot extends StatelessWidget {
  const SingleDot({Key? key, this.isActive}) : super(key: key);
  final bool? isActive;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 10,
      child: AnimatedContainer(
        duration: Duration(milliseconds: 150),
        margin: EdgeInsets.symmetric(horizontal: 4.0),
        height: isActive! ? 7 : 5.0,
        width: isActive! ? 7 : 5.0,
        decoration: BoxDecoration(
            // boxShadow: [
            //   isActive!
            //       ? BoxShadow(
            //           // color: Color(0XFF2FB7B2).withOpacity(0.72),
            //           color: redColor,
            //           blurRadius: 4.0,
            //           spreadRadius: 1.0,
            //           offset: Offset(
            //             0.0,
            //             0.0,
            //           ),
            //         )
            //       : BoxShadow(
            //           color: Colors.transparent,
            //         )
            // ],
            shape: BoxShape.circle,
            // color: isActive! ? Color(0XFF6BC4C9) : Color(0XFFEAEAEA),
            color: isActive! ? redColor : Color.fromARGB(255, 153, 153, 153)),
      ),
    );
  }
}
