import 'package:flutter/material.dart';
import '../scrpart/imgslider.dart';
import '../utils/common.dart';
import '../utils/style.dart';

class BaseAppBar extends StatelessWidget implements PreferredSizeWidget {
  final AppBar appBar = AppBar();

  final double? elevation;
  final bool? boolLeading;
  final bool? centerTitle;
  final Widget? leading;
  final Function? onTap;
  final String? title;
  final List<Widget>? actionList;
  final Color? bgColor, txtColor;
  final dynamic leadingOnTap;

  BaseAppBar(
      {this.boolLeading,
      this.elevation,
      this.leading,
      this.centerTitle,
      this.onTap,
      this.title,
      this.bgColor,
      this.txtColor,
      this.leadingOnTap,
      this.actionList});

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: bgColor ?? offWhiteColor,
      elevation: elevation,
       iconTheme: IconThemeData(color: Colors.black),
      // automaticallyImplyLeading: boolLeading ?? true,
      // leading: leading,
      title: title != null
          ? Text(title!, style: TextStyle(fontFamily: montserratMedium,color: orangeColor))
          : null,
      centerTitle: centerTitle ?? false,
      actions: actionList,
    );
  }

  @override
  Size get preferredSize => Size.fromHeight(appBar.preferredSize.height);
}

// ! SLIVER APP BAR
class SliverAppBars extends StatelessWidget {
  final Widget? bottomChild;
  final double? elevation;
  final bool? boolLeading;

  final Widget? leading;
  final Function? onTap;
  final String? title;
  final List<Widget>? actionList;
  final Color? bgColor, txtColor;
  final double? toolBarHeight;
  SliverAppBars(
      {Key? key,
      this.bottomChild,
      this.actionList,
      this.bgColor,
      this.boolLeading,
      this.elevation,
      this.leading,
      this.title,
      this.txtColor,
      this.toolBarHeight = 50,
      this.onTap})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SliverAppBar(
      backgroundColor: offWhiteColor,
      floating: true,
      pinned: true,
      snap: false,
      centerTitle: true,
      // toolbarHeight:toolBarHeight ,

      elevation: elevation,
      // automaticallyImplyLeading: boolLeading ?? true,
      // leading: leading,
      // leading: leading
      // != null
      //     ? leading
      //     : IconButton(
      //         iconSize: 28,
      //         icon: Icon(Icons.chevron_left_sharp, color: txtBlackColor),
      //         onPressed: () => navigationPop(context),
      //       ),
      // title: Text(
      //   'All Category ',
      //   style: appBarTS,
      // ),
      iconTheme: IconThemeData(color: Colors.black),
      title: title != null
          ? Text(title!,
              style: TextStyle(
                  fontFamily: montserratMedium,
                  color: txtColor ?? orangeColor))
          : null,
      actions: actionList,
      bottom: bottomChild != null
          ? PreferredSize(
              preferredSize: Size.fromHeight(60),
              child: Container(child: bottomChild))
          : null,
    );
  }
}

// actionList: [
//   ImgIcon(
//     cheight: 25,
//     width: 25,
//     src: 'assets/icons/fillter-icon.png',
//   )
//   // IconButton(
//   //   icon: Icon(Icons.filter_list),
//   //   onPressed: () {},
//   // ),
// ]
