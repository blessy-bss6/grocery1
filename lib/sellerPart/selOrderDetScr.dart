import 'package:flutter/material.dart';
import '../sellerPart/selOrder.dart';
import '../Elements/baseAppbar.dart';
import '../common/button.dart';
import '../utils/common.dart';
import '../utils/style.dart';

class SelOrderDetailScreen extends StatelessWidget {
  const SelOrderDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        title: 'Orders',
      ),
      body: Container(
          child: ListView.builder(
              itemCount: 9,
              itemBuilder: (context, index) => Card(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10.0, horizontal: 10.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                '#798565555',
                                style: labelTextStyle,
                              ),
                              Btn(
                                onTap: () {},
                                height: 25,
                                width: 100,
                                btnName: 'inProgress',
                                color: Colors.orange,
                                txtColor: offWhiteColor,
                              )
                            ],
                          ),

                          // ! BUTTON

                          Text(
                            'Title name',
                            style:
                                TextStyle(fontSize: 17, color: Colors.black38),
                          ),
                          Text(
                            '6 oct,2020 at 12:08 AM',
                            style:
                                TextStyle(fontSize: 12, color: Colors.black38),
                          ),
                          heightSizedBox(5.0),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                'Total Ammount: \u{20B9}  120.0',
                                style: labelTextStyle,
                              ),
                              InkWell(
                                onTap: () => navigationPush(
                                    context, SelOrderConfScreen()),
                                child: Text(
                                  'View Details',
                                  // 'View Details ${Icon(Icons.chevron_left_sharp)}',
                                  style: smallTextStyle,
                                ),
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ))),
    );
  }
}
