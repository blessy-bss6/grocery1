import 'package:flutter/material.dart';
import '../Elements/baseAppbar.dart';

class OffersScreen extends StatelessWidget {
  const OffersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        centerTitle: true,
        title: 'Offers',
      ),
      body: Center(
        child: Text('Offers'),
      ),
    );
  }
}
