import 'dart:io';

import 'package:flutter/material.dart';
import 'package:groce1/Extra.dart';
import '../Screen/spalash.dart';
import 'package:provider/provider.dart';

import 'Allproveder.dart';
import 'Screen/dashBoard.dart';
// import 'sellerPart/selHomScr.dart';
// import 'sellerPart/selProdAddScr.dart';
// import 'sellerPart/selProdListScr.dart';
// import 'sellerPart/selTransScr.dart';
import 'Screen/login.dart';
import 'utils/shared_preferences.dart';

// class MyHttpOverrides extends HttpOverrides {
//   @override
//   HttpClient createHttpClient(SecurityContext? context) {
//     return super.createHttpClient(context)
//       ..badCertificateCallback =
//           (X509Certificate cert, String host, int port) => true;
//   }
// }
final GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();
void main() {
  // HttpOverrides.global = new MyHttpOverrides();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // SharedHelper sharedData = SharedHelper();
  // ! TAKING TOKEN DATA

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: MainBloc.allBlocs(),
      child: MaterialApp(
        theme: ThemeData(
            // primaryColor: redColor,
            // appBarTheme: const AppBarTheme(color: redColor)
            ),
        debugShowCheckedModeBanner: false,
        // home: SplashScreen(),
        initialRoute: '/',
        navigatorKey: navigatorKey,
        routes: {
          // When navigating to the "/" route, build the FirstScreen widget.
          '/': (context) =>  SplashScreen(),
          // When navigating to the "/second" route, build the SecondScreen widget.
          '/login': (context) =>  LoginScr(),
        },
        // home:ProdData()
      ),
    );
  }
}
