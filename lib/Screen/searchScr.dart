import 'package:flutter/material.dart';
import '../common/formfield.dart';
import '../utils/common.dart';

import '../Elements/all_list_content.dart';
import '../common/button.dart';
import '../utils/style.dart';
import 'prodShowScr.dart';

// class SearchScreen extends StatelessWidget {
//   const SearchScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//         appBar: BaseAppBar(
//           bgColor: OrangeCreamColor,
//           centerTitle: true,
//           title: 'Search Product',
//           txtColor: txtWhiteColor,
//         ),
//         body: Container(
//             alignment: Alignment.center,
//             child: Text(
//               "Search SCREEN",
//             )));
//   }
// }

class SearchScreen extends StatelessWidget {
  SearchScreen({Key? key}) : super(key: key);

  final List<Widget> tabs = [];

  // dynamic cart;

  // dynamic cartItem;
  final TextEditingController? searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: OrangeCreamColor,
            // automaticallyImplyLeading: false,
            // leading: IconButton(
            //   iconSize: 28,
            //   icon: Icon(Icons.chevron_left_sharp, color: txtBlackColor),
            //   onPressed: () => Navigator.of(context).pop(),
            // ),
            floating: true,
            pinned: true,
            snap: false,
            centerTitle: true,
            title: Txt(
              t: 'Search',
              style: TextStyle(color: txtWhiteColor, fontSize: 15),
            ),
            bottom: PreferredSize(
              preferredSize: Size.fromHeight(60),
              child: Padding(
                padding:
                    const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
                child: SearchBox(
                  controller: searchController,
                ),
              ),
            ),
          ),
          // Other Sliver Widgets

          // SliverPadding(
          //   padding: const EdgeInsets.all(5.0),
          //   sliver: SliverGrid(
          //       gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          //         crossAxisCount: 2,
          //         childAspectRatio: MediaQuery.of(context).size.width /
          //             (MediaQuery.of(context).size.height / 1.9),
          //         mainAxisSpacing: 10.0,
          //         crossAxisSpacing: 10.0,
          //       ),
          //       delegate: SliverChildBuilderDelegate((context, index) {
          //         return CategeoryGridProdList(
          //           onTap: () => navigationPush(context, ProductShowScreen()),
          //           imageUrl: 'assets/images/banana.png',
          //           title: 'Categoryname',
          //         );
          //       }, childCount: 10)),
          // )
        ],
      ),
    );
  }
}
