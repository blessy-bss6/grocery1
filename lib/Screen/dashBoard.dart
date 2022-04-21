import 'package:flutter/material.dart';
import '../Elements/baseAppbar.dart';
import '../Screen/authconfrim.dart';
import '../Screen/cartScr.dart';
import '../Screen/profileScr.dart';
import '../Screen/searchScr.dart';
import '../Screen/wishlistScr.dart';
import '../common/button.dart';
import '../sellerPart/selCategoryScr.dart';
import '../sellerPart/selHomScr.dart';
import '../sellerPart/selOrder.dart';
import '../sellerPart/selOrderDetScr.dart';
import '../sellerPart/selProdListScr.dart';
import '../sellerPart/selTransScr.dart';

import '../utils/style.dart';
import 'home.dart';

class UserNavigationBar extends StatefulWidget {
  final int? sellerId;
  int? currentTab;
  Widget? currentPage;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  UserNavigationBar({Key? key, this.currentTab, this.sellerId}) {
    if (currentTab == null) currentTab = 0;
  }
  @override
  _UserNavigationBarState createState() => _UserNavigationBarState();
}

class _UserNavigationBarState extends State<UserNavigationBar> {
  @override
  initState() {
    super.initState();
    _selectTab(widget.currentTab!);
  }

  void _selectTab(int tabItem) {
    setState(() {
      widget.currentTab = tabItem;
      switch (tabItem) {
        case 0:
          widget.currentPage = HomeScreen(
              // sellerId: widget.sellerId,
              );
          break;
        case 1:
          widget.currentPage = SearchScreen(
              // sellerId: widget.sellerId,
              );
          break;
        case 2:
          widget.currentPage = CartScreen(
              // sellerId: widget.sellerId,
              );
          break;
        case 3:
          widget.currentPage = WishListScreen();

          break;
        case 4:
          widget.currentPage = ProfileScreen();
          // widget.currentPage = SelGeneratePromoCodes(sellerId: widget.sellerId);
          break;
        case 5:
          widget.currentPage = AuthOptionScr(
            seller: true,
          );
          break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget.scaffoldKey,
      body: widget.currentPage,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: offgreenColor,
        // selectedFontSize: 0,
        // unselectedFontSize: 0,
        unselectedItemColor: offWhiteColor,
        iconSize: 25,
        backgroundColor: Colors.white,
        currentIndex: widget.currentTab!,
        showSelectedLabels: true,
        selectedFontSize: 12,

        showUnselectedLabels: true,
        selectedLabelStyle: TextStyle(
            fontSize: 12, color: offgreenColor, fontFamily: montserratMedium),

        unselectedLabelStyle: TextStyle(
            fontSize: 12, color: Colors.black38, fontFamily: montserratMedium),
        unselectedFontSize: 12,

        onTap: (int i) {
          this._selectTab(i);
        },
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/bottom-1.png',
              height: 22,
              color: widget.currentTab == 0 ? offgreenColor : Colors.black38,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/bottom-2.png',
              height: 22,
              color: widget.currentTab == 1 ? offgreenColor : Colors.black38,
            ),
            label: 'Search Bar',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/bottom-3.png',
              height: 22,
              color: widget.currentTab == 2 ? offgreenColor : Colors.black38,
            ),
            label: 'Cart',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/bottom-4.png',
              height: 22,
              color: widget.currentTab == 3 ? offgreenColor : Colors.black38,
            ),
            label: 'Like',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.account_circle,
              size: 22,
              color: widget.currentTab == 4 ? offgreenColor : Colors.black38,
            ),
            //  Image.asset(
            //   'assets/icons/bottom-5.png',
            //   height: 22,
            //   color: widget.currentTab == 4 ? offgreenColor : Colors.black38,
            // ),
            label: 'Profile',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.sell_sharp,
              size: 22,
              color: widget.currentTab == 5 ? offgreenColor : Colors.black38,
            ),
            label: 'Seller',
          ),
        ],
      ),
    );
  }
}

// ! Seller DashBaord
class SellerNavigationBar extends StatefulWidget {
  final int? sellerId;
  int? currentTab;
  Widget? currentPage;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  SellerNavigationBar({Key? key, this.currentTab, this.sellerId}) {
    if (currentTab == null) currentTab = 0;
  }
  @override
  _SellerNavigationBarState createState() => _SellerNavigationBarState();
}

class _SellerNavigationBarState extends State<SellerNavigationBar> {
  @override
  initState() {
    super.initState();
    _selectTab(widget.currentTab!);
  }

  void _selectTab(int tabItem) {
    setState(() {
      widget.currentTab = tabItem;
      switch (tabItem) {
        case 0:
          widget.currentPage = SelHomeScreen(
              // sellerId: widget.sellerId,
              );
          break;
        case 1:
          widget.currentPage = SelCategoryScreen(
              // sellerId: widget.sellerId,
              );
          break;
        case 2:
          widget.currentPage = SelProdListScreen(
              // sellerId: widget.sellerId,
              );
          break;
        case 3:
          widget.currentPage = SelOrderDetailScreen();

          break;
        case 4:
          widget.currentPage = SelTranscationScreen();
          // widget.currentPage = SelGeneratePromoCodes(sellerId: widget.sellerId);
          break;
        // case 5:
        //   widget.currentPage = Profile();
        //   break;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: widget.scaffoldKey,
      body: widget.currentPage,
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.fixed,
        selectedItemColor: offgreenColor,
        // selectedFontSize: 0,
        // unselectedFontSize: 0,
        unselectedItemColor: Colors.black12,
        iconSize: 25,
        backgroundColor: offWhiteColor,
        currentIndex: widget.currentTab!,
        showSelectedLabels: true,
        selectedFontSize: 12,

        showUnselectedLabels: true,
        selectedLabelStyle: TextStyle(
            fontSize: 12, color: offgreenColor, fontFamily: montserratMedium),

        unselectedLabelStyle: TextStyle(
            fontSize: 12, color: Colors.black, fontFamily: montserratMedium),
        unselectedFontSize: 12,

        onTap: (int i) {
          this._selectTab(i);
        },
        items: [
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/bottom-1.png',
              height: 22,
              color: widget.currentTab == 0 ? offgreenColor : Colors.black38,
            ),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            icon: Image.asset(
              'assets/icons/bottom-2.png',
              height: 22,
              color: widget.currentTab == 1 ? offgreenColor : Colors.black38,
            ),
            label: 'Category',
          ),
          BottomNavigationBarItem(
            icon: IconBtn(
              size: 22,
              icon: Icons.list,
              color: widget.currentTab == 2 ? offgreenColor : Colors.black38,
            ),

            //  Image.asset(
            //   'assets/icons/bottom-3.png',
            //   height: 22,
            //   color: widget.currentTab == 2 ? offgreenColor : Colors.black38,
            // ),
            label: 'Product',
          ),
          BottomNavigationBarItem(
            icon: IconBtn(
              size: 22,
              icon: Icons.shopping_bag,
              color: widget.currentTab == 3 ? offgreenColor : Colors.black38,
            ),
            // Image.asset(
            //   'assets/icons/bottom-4.png',
            //   height: 22,
            //   color: widget.currentTab == 3 ? offgreenColor : Colors.black38,
            // ),
            label: 'Order',
          ),
          BottomNavigationBarItem(
            icon: Icon(
              Icons.find_in_page,
              size: 22,
              color: widget.currentTab == 4 ? offgreenColor : Colors.black38,
            ),
            //  Image.asset(
            //   'assets/icons/bottom-5.png',
            //   height: 22,
            //   color: widget.currentTab == 4 ? offgreenColor : Colors.black38,
            // ),
            label: 'History',
          ),
        ],
      ),
    );
  }
}
