import 'package:flutter/material.dart';
import '../Elements/baseAppbar.dart';
import '../common/formfield.dart';
import '../scrpart/imgslider.dart';
import '../utils/common.dart';

import '../Elements/all_list_content.dart';
import '../common/button.dart';
import '../utils/style.dart';
import 'prodShowScr.dart';

class CategoryScreen extends StatelessWidget {
  CategoryScreen({Key? key}) : super(key: key);

  final List<Widget> tabs = [];

  // dynamic cart;

  // dynamic cartItem;
  final TextEditingController? searchController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          // ! Sliver app Bar

          SliverAppBars(boolLeading: true,
            title: 'All Category',
            bottomChild: Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 5.0, horizontal: 15.0),
              child: SearchBox(
                controller: searchController,
              ),
            ),
          ),

          //  ! Sliver Product Content

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
                    onTap: () => navigationPush(context, ProductShowScreen()),
                    imageUrl: 'assets/images/banana.png',
                    title: 'Categoryname',
                  );
                }, childCount: 10)),
          )
        ],
      ),
    );
  }
}

// ! Category ProdList
class CategeoryGridProdList extends StatelessWidget {
  final String? title;
  final String? imageUrl;

  final dynamic onTap;
  final bool? fromSubProducts;
  const CategeoryGridProdList(
      {Key? key,
      this.title,
      this.imageUrl,
      this.onTap,
      this.fromSubProducts = false})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onTap,
        child: Container(
          // padding: EdgeInsets.only(top: 3),
          decoration: BoxDecoration(
              color: offWhiteColor,
              borderRadius: BorderRadius.circular(5.0),
              border: Border.all(
                color: Color.fromARGB(255, 236, 234, 234),
              )),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Center(
                  child: ImgIcon(
                    src: imageUrl!,
                    width: 150,
                    height: 100,
                    padding: EdgeInsets.all(2),
                  ),
                ),
                Divider(),
                // ! title  and Subtitle for
                Container(
                  padding:
                      EdgeInsets.only(left: 3, right: 3, top: 3, bottom: 2),
                  child: Txt(
                    t: title!.length <= 40 ? title! : title!.substring(0, 40),
                    textAlign: TextAlign.left,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                )
              ]),
        ));
  }
}
