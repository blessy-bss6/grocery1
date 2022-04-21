import 'package:flutter/material.dart';

const montserratMedium = 'MontserratMedium';
const montserratSemiBold = 'MontserratSemiBold';
// const redColor = Color(0xffF6343F);
// const blackColor = Color(0xFF000000);
// const bottomSheet = Color(0xff71181C);
// const transparent = Colors.transparent;

// const cartColor = Color(0xffF3F4F8);
const yellowColor = Color(0xffFFD700);
const greyColor = Colors.grey;
// const offWhiteColor = Color(0xffF8F8FB);
const darkBlueColor = Color(0xff3232AA);
const textBlueColor = Color(0xff2A1478);
const lightBlueColor = Color(0xffD8D8D8);
const primaryColor = Color(0xFFFFFFFF);
const borderColor = Colors.black12;

// ! these Color of applicaion
const offWhiteColor = Color.fromARGB(255, 255, 255, 255);
const offgreenColor = Color.fromARGB(255, 152, 166, 45); /* Text, Button */
const orangeColor =
    Color.fromARGB(255, 254, 148, 30); /* Text, AppBar Heading */
const redColor = Color.fromARGB(255, 225, 31, 42); /* Text, Button */
const marronColor = Color.fromARGB(255, 150, 20, 30); /* Text, Button */
const blackColor = Color.fromARGB(255, 0, 0, 0); /* Button */
const txtWhiteColor = Color.fromARGB(255, 255, 255, 255); /* Text,  */
const searchWhiteColor = Color.fromARGB(255, 246, 246, 246); /*  Search */
const OrangeCreamColor = Color.fromARGB(255, 251, 169, 67); /*  AppBar */
const brownWhiteColor = Color.fromARGB(255, 224, 224, 224); /*  Cart line */
const txtBlackColor = Color.fromARGB(255, 59, 59, 59); /*  Text */
const notiBgColor = Color.fromARGB(255, 250, 252, 203); /*  Notification Bg */
const FaqBgColor = Color.fromARGB(255, 241, 241, 241); /*  FAQ BG */
const dashBgColor =
    Color.fromARGB(255, 237, 237, 237); /* Seller DashBoard Bg */

TextStyle smallTextStyle =
    TextStyle(fontFamily: montserratMedium, color: txtBlackColor, fontSize: 14);
TextStyle appBarTS =
    TextStyle(fontFamily: montserratMedium, fontSize: 18, color: orangeColor);
TextStyle liteHeadingTS = TextStyle(
    color: Colors.grey.shade600, fontSize: 13.0, fontFamily: montserratMedium);

TextStyle blueTextStyle = TextStyle(
  fontSize: 12.5,
  decoration: TextDecoration.underline,
  fontFamily: montserratMedium,
  color: darkBlueColor,
);

TextStyle labelTextStyle = TextStyle(
  color: Colors.black,
  fontWeight: FontWeight.bold,
  fontFamily: montserratMedium,
  fontSize: 14.0,
);

TextStyle whiteTextStyle = TextStyle(
  color: Colors.white,
  fontFamily: montserratMedium,
  fontSize: 14.0,
);

BoxDecoration boxDecoration = BoxDecoration(
  color: Colors.white,
  borderRadius: BorderRadius.all(Radius.circular(12)),
  boxShadow: [
    BoxShadow(
        color: Colors.grey.withOpacity(0.8),
        blurRadius: 2,
        offset: Offset(-0.1, -0.1)),
  ],
);

BoxDecoration cardDecoration = BoxDecoration(
  color: txtWhiteColor,
  borderRadius: BorderRadius.only(
    topLeft: Radius.circular(12),
    topRight: Radius.circular(12),
  ),
);

BoxDecoration fieldDecoration = BoxDecoration(
    color: Colors.white,
    // border: Border.all(color: Colors.grey),
    borderRadius: BorderRadius.circular(8));
