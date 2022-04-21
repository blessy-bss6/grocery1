import 'package:flutter/material.dart';
import '../Elements/drawers.dart';
import '../Screen/notificationScr.dart';
import '../common/button.dart';
import '../utils/common.dart';
import '../utils/style.dart';

class SelHomeScreen extends StatelessWidget {
  SelHomeScreen({Key? key}) : super(key: key);

  var selscaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: selscaffoldKey,
      body: CustomScrollView(
        slivers: [
          // ! Sliver app Bar
          SliverAppBar(
            backgroundColor: offWhiteColor,
            leading: IconButton(
              icon: Icon(
                Icons.account_circle_rounded,
                color: txtBlackColor,
              ),
              // onPressed: () => Scaffold.of(context).openDrawer(),
              onPressed: () {
                selscaffoldKey.currentState?.openDrawer();
              },
            ),
            title: Text(
              'Hey, Username',
              style: appBarTS,
            ),
            centerTitle: true,
            actions: <Widget>[
              IconBtn(
                onPressed: () => navigationPush(context, NotificationScreen()),
                icon: Icons.notification_add_outlined,
                size: 20,
                color: txtBlackColor,
              )
            ],
          ),

          // ! First List
          SliverPadding(
            padding: const EdgeInsets.all(3),
            sliver: SliverToBoxAdapter(
              child: Column(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 4.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Txt(
                          t: 'This Month',
                          style: labelTextStyle,
                        ),
                        Txt(
                          t: 'All Report',
                          style: TextStyle(color: redColor, fontSize: 12),
                        )
                      ],
                    ),
                  ),
                  Row(
                    children: [
                      Expanded(
                          child: SelHomeHeader(
                              t1: 'Month Earnings', t2: ' R 1245550')),
                      Expanded(
                          child: SelHomeHeader(
                              t1: 'Today Earnings', t2: ' R 45550'))
                    ],
                  ),
                ],
              ),
            ),
          ),

          SliverList(
            delegate: SliverChildListDelegate([
              SelHomeDetails(
                  icon: Icons.dashboard,
                  color1: offWhiteColor,
                  color2: offgreenColor,
                  t1: 'Order Received',
                  t2: '4'),
              SelHomeDetails(
                  icon: Icons.indeterminate_check_box,
                  color1: offWhiteColor,
                  color2: Colors.blueAccent,
                  t1: 'Sold Items',
                  t2: '243'),
              SelHomeDetails(
                  icon: Icons.dashboard,
                  color1: offWhiteColor,
                  color2: orangeColor,
                  t1: 'Order Cancelled',
                  t2: '154'),
              SelHomeDetails(
                  icon: Icons.dashboard,
                  color1: offWhiteColor,
                  color2: yellowColor,
                  t1: 'Order Return',
                  t2: '422'),
            ]),
          ),
        ],
      ),
      drawer: DrawerScreen(),
    );
  }
}

// ! Seller Home Header
class SelHomeHeader extends StatelessWidget {
  final String? t1, t2;
  const SelHomeHeader({Key? key, this.t1, this.t2}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 80,
      margin: EdgeInsets.all(3),
      decoration: BoxDecoration(
          color: marronColor, borderRadius: BorderRadius.circular(5)),
      alignment: Alignment.center,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Txt(
            t: t1,
            fontSize: 12,
            color: txtWhiteColor,
          ),
          Txt(
            t: t2,
            fontSize: 15,
            color: txtWhiteColor,
          ),
        ],
      ),
    );
  }
}

// ! List Product for Home
class SelHomeDetails extends StatelessWidget {
  final String? t1, t2;
  final IconData? icon;
  final Color? color2, color1;

  const SelHomeDetails(
      {Key? key, this.color1, this.color2, this.icon, this.t1, this.t2})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Container(
        height: 70,
        decoration: BoxDecoration(
            color: FaqBgColor, borderRadius: BorderRadius.circular(5)),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Container(
                padding: EdgeInsets.all(5),
                decoration: BoxDecoration(
                    color: color2, borderRadius: BorderRadius.circular(30)),
                child: IconBtn(
                  icon: icon,
                  color2: color1,
                  size: 30,
                ),
              ),
              // Row(mainAxisAlignment: MainAxisAlignment.spaceAround,
              //   children: [
              Txt(
                t: t1 ?? '',
                style: labelTextStyle,
              ),
              Txt(
                t: t2 ?? '',
                style: labelTextStyle,
              ),
              //   ],
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
