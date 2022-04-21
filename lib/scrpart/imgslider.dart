import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import '../common/button.dart';
import '../utils/common.dart';
import '../utils/style.dart';

class ImgSlider extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    List<int> list = [1, 2, 3, 4, 5];
    return Container(
        child: CarouselSlider(
      options: CarouselOptions(
        height: 150,
        // aspectRatio: 16 / 9,
        // viewportFraction: 0.8,
        initialPage: 0,
        enableInfiniteScroll: true,
        reverse: false,
        autoPlay: true,
        autoPlayInterval: Duration(seconds: 2),
        autoPlayAnimationDuration: Duration(milliseconds: 200),
        autoPlayCurve: Curves.fastOutSlowIn,
        enlargeCenterPage: true,
        // onPageChanged: callbackFunction,
        scrollDirection: Axis.horizontal,
      ),
      items: [1, 2, 3, 4, 5].map((i) {
        return Builder(
          builder: (BuildContext context) {
            return Container(
                width: MediaQuery.of(context).size.width / 1.25,
                margin: EdgeInsets.symmetric(horizontal: 5.0),
                decoration: BoxDecoration(),
                child: Image.asset(
                  'assets/icons/banner-img.png',
                  fit: BoxFit.cover,
                  width: double.infinity,
                ));
          },
        );
      }).toList(),
    ));
  }
}

// ! Image Icon in Flutter

class ImgIcon extends StatelessWidget {
  final String? src;
  final double? width;
  final double? height;
  final double? cwidth;
  final double? cheight;
  final BoxFit? fit;
  final bool? imgType;
  final Color? color;
  final EdgeInsetsGeometry? padding;
  final EdgeInsetsGeometry? margin;
  const ImgIcon(
      {Key? key,
      this.cheight,
      this.fit,
      this.cwidth,
      this.height,
      this.src,
      this.imgType = false,
      this.padding,
      this.margin,
      this.color,
      this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: padding,
      margin: margin,
      width: cwidth,
      height: cheight,
      child: imgType == true
          ? Image.network(
              src!,
              width: width,
              height: height,
              fit: fit,
              color: color 
            )
          : Image.asset(
              src!,
              width: width,
              height: height,
              fit: fit,
              color: color 
            ),
    );
  }
}

//  IMAGE HORIZONTAL LIST
class ImgHorizontalList extends StatelessWidget {
  final dynamic prodList;
  final dynamic callBack;
  final dynamic itemBorder;
  final dynamic btn;
  final double? cheight;
  const ImgHorizontalList(
      {Key? key,
      this.itemBorder,
      this.cheight,
      this.btn,
      this.prodList,
      this.callBack})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.all(5),
      // color: Colors.red,
      height: cheight ?? 55,
      width: double.infinity,
      child: ListView.builder(
          itemCount: prodList.length,
          shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemBuilder: (context, i) {
            return InkWell(
              onTap: () {
                callBack(prodList[i]);
                // print('pics ${prodList[i]}');
              },
              child: Column(
                children: [
                  Container(
                    decoration: prodList[i] == itemBorder
                        ? BoxDecoration(
                            border: Border.all(width: 1, color: Colors.green),
                            borderRadius: BorderRadius.circular(5))
                        : null,
                    child: ImgIcon(
                      margin: EdgeInsets.all(3),
                      src: '${prodList[i]}',
                      width: 50,
                      height: 50,
                    ),
                  ),
                  // heightSizedBox(3.0),
                  Container(
                    child: btn != null
                        ? Btn(
                            padding: EdgeInsets.all(2),
                            color: redColor,
                            height: 20,
                            btnName: 'DELETE',
                            style: TextStyle(
                              color: txtWhiteColor,
                              fontSize: 12,
                            ))
                        : null,
                  )
                ],
              ),
            );
          }),
    );
  }
}

// ! Upload File
class SelUpdMultiFile extends StatefulWidget {
  final Function()? upDFile;
  final Function()? cleanImg;
  final String? imgSrc;
  final String? networkImage;
  SelUpdMultiFile(
      {Key? key, this.imgSrc, this.upDFile, this.cleanImg, this.networkImage})
      : super(key: key);

  @override
  _SelUpdMultiFileState createState() => _SelUpdMultiFileState();
}

class _SelUpdMultiFileState extends State<SelUpdMultiFile> {
  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(1.0),
        child: Column(
          children: [
            // ! UPLOAD NEW FILE
            Container(
              // padding: const EdgeInsets.all(1.0),
              // margin: EdgeInsets.all(1.0),
              height: 60,
              decoration: BoxDecoration(
                image:
                    //  widget.imgSrc != null?
                    DecorationImage(
                  image: FileImage(widget.imgSrc != null
                      ? File(widget.imgSrc as String)
                      : File('')),
                  // fit: BoxFit.fitWidth,
                )
                // : null
                ,
                // ! Cricle Border
                borderRadius: BorderRadius.circular(5),
              ),
              child: MaterialButton(
                color: widget.imgSrc == null ? offWhiteColor : null,
                onPressed: widget.upDFile,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(5.0),
                ),
                child: Ink(
                  decoration: BoxDecoration(
                    // ! Cricle Border
                    borderRadius: BorderRadius.circular(5),
                  ),
                  child: Container(
                    constraints: BoxConstraints(
                        maxWidth: 20.0,
                        minHeight: 45.0,
                        maxHeight: 45.0), // min sizes for Material buttons
                    alignment: Alignment.center,
                    child: Center(
                      child: Container(
                          height: 20,
                          decoration: BoxDecoration(
                            border: widget.imgSrc == null
                                ? Border.all(color: redColor)
                                : null,
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            color: widget.imgSrc == null ? redColor : null,
                          ),
                          child: widget.imgSrc == null ||
                                  widget.imgSrc.toString().isEmpty
                              ? Center(
                                  child: Icon(
                                    Icons.add,
                                    size: 16,
                                    color: offWhiteColor,
                                    textDirection: TextDirection.ltr,
                                  ),
                                )
                              : null),
                    ),
                  ),
                ),
              ),
            ),
            // ! Remove Button
            Padding(
              padding: const EdgeInsets.only(),
              child: Container(
                  child: widget.imgSrc == null || widget.imgSrc!.isEmpty
                      ? null
                      : InkWell(
                          onTap: widget.cleanImg,
                          child: IconBtn(
                              icon: Icons.cancel, size: 15, color: redColor))),
            )
          ],
        ));
  }
}
