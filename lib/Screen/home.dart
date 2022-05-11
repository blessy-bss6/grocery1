import 'package:flutter/material.dart';
import '../Elements/all_list_content.dart';
import '../Elements/baseAppbar.dart';
import '../Elements/drawers.dart';
import '../Screen/prodShowScr.dart';
import '../Screen/notificationScr.dart';
import '../Screen/prodDetails.dart';
import '../common/formfield.dart';
import '../utils/common.dart';
import '../utils/style.dart';

import '../common/button.dart';
import '../scrpart/imgslider.dart';
import 'category.dart';

class HomeScreen extends StatelessWidget {
  HomeScreen({Key? key}) : super(key: key);
  final TextEditingController? searchController = TextEditingController();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () => willPopCallback(context, true),
      child: Scaffold(
        key: scaffoldKey,
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
                  scaffoldKey.currentState?.openDrawer();
                },
              ),
              title: Text(
                'Hey, Username',
                style: appBarTS,
              ),
              centerTitle: true,
              bottom: PreferredSize(
                  preferredSize: Size.fromHeight(80),
                  child: Container(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: AddressPart(),
                        ),
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 10.0, horizontal: 15.0),
                          child: SearchBox(
                            fillColor: FaqBgColor,
                            controller: searchController,
                          ),
                        ),
                      ],
                    ),
                  )),
              actions: <Widget>[
                IconBtn(
                  onPressed: () =>
                      navigationPush(context, NotificationScreen()),
                  icon: Icons.notification_add_outlined,
                  size: 20,
                  color: txtBlackColor,
                )
              ],
            ),
            SliverList(
              delegate:
                  SliverChildListDelegate([ImgSlider(), CategoryListItem()]),
            ),

            // ! First List
            SliverPadding(
              padding: const EdgeInsets.all(3),
              sliver: SliverToBoxAdapter(
                child: Column(
                  children: [
                    Divider(),
                    Container(
                        alignment: Alignment.center,
                        child: Txt(
                          t: 'Exclusive Product ',
                          color: marronColor,
                        )),
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.all(5.0),
              sliver: SliverGrid(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    childAspectRatio: MediaQuery.of(context).size.width /
                        (MediaQuery.of(context).size.height / 1.9),
                    mainAxisSpacing: 10.0,
                    crossAxisSpacing: 10.0,
                  ),
                  delegate: SliverChildBuilderDelegate((context, index) {
                    return CategeoryGridProdList(
                      // onTap: () => navigationPush(context, ProductShowScreen()),
                      imageUrl: 'assets/images/banana.png',
                      title: 'Categoryname',
                    );
                  }, childCount: 5)),
            ),
          ],
        ),
        drawer: DrawerScreen(),
      ),
    );
  }
}

// ! Address Part in Home
class AddressPart extends StatelessWidget {
  final Widget? trailing;
  final dynamic onPressed;
  const AddressPart({Key? key, this.trailing, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Row(mainAxisAlignment: MainAxisAlignment.spaceBetween, children: [
        Row(
          children: [
            ImgIcon(
              src: 'assets/icons/location-icon.png',
              width: 30,
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(left: 5.0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Txt(
                    t: 'Your Location',
                    fontSize: 13,
                  ),
                  Txt(t: ''),
                ],
              ),
            ),
          ],
        ),
        Container(
            alignment: Alignment.topRight,
            child: trailing != null
                ? IconBtn(
                    icon: Icons.chevron_right,
                    onPressed: onPressed,
                  )
                : null),
      ]),
    );
  }
}

// !  Vertical list for Category
class CategoryListItem extends StatelessWidget {
  CategoryListItem({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 10.0, right: 10),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              // ! Title Value
              Txt(
                t: 'Shop By Category',
                color: redColor,
                fontSize: 17,
              ),
              //  padding: EdgeInsets.all(10),
              Btn(
                padding: EdgeInsets.only(left: 6, right: 6),
                height: 30,
                btnName: 'VIEW ALL',
                style: TextStyle(fontSize: 13, color: blackColor),
                color: Color.fromARGB(246, 200, 200, 214),
                onTap: () => navigationPush(context, CategoryScreen()),
              ),
            ],
          ),
        ),
        Container(
          height: 150,
          child: ListView.builder(
            shrinkWrap: true,
            itemCount: 15,
            scrollDirection: Axis.horizontal,
            itemBuilder: (context, i) {
              return Padding(
                padding: const EdgeInsets.only(
                    top: 8.0, left: 8, right: 8, bottom: 5),
                child: InkWell(
                  onTap: () => navigationPush(context, ProductShowScreen()),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      // ! Pic Section
                      Container(
                        child: Image.asset(
                          'assets/images/snacks.png',
                          height: 100,
                        ),
                      ),

                      // ! Bottom Name
                      Container(
                        alignment: Alignment.bottomCenter,
                        child: Txt(
                          t: 'name $i',
                          fontSize: 14,
                        ),
                      )
                    ],
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }
}

// Product GridList
class HomeProdGridList extends StatelessWidget {
  HomeProdGridList({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        // shrinkWrap: true,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 10.0, right: 10),
            child: Txt(
              t: 'Exclusive Products',
              color: redColor,
              fontSize: 17,
            ),
          ),
          Container(
            child: GridView.builder(
              // primary: false,
              physics: ScrollPhysics(),
              padding: EdgeInsets.all(1.0),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                childAspectRatio: MediaQuery.of(context).size.width /
                    (MediaQuery.of(context).size.height / .99
                    // 1.2
                    ),
                mainAxisSpacing: 10.0,
                crossAxisSpacing: 10.0,
              ),
              shrinkWrap: true,
              itemCount: 15,
              itemBuilder: (context, i) {
                return HomeGridProdList(
                  onPressed: () => print('add tocart'),
                  onTap: () => navigationPush(context, ProductDetailScr()),
                  imageUrl: 'assets/images/snacks.png',
                  name: 'productname',
                  slug: 'uslug',
                  desc: 'Qunatity ',
                  price: '500',
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
