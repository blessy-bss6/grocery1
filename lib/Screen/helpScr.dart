import 'package:flutter/material.dart';
import '../Elements/baseAppbar.dart';
import '../common/button.dart';
import '../common/formfield.dart';
import '../scrpart/imgslider.dart';
import '../utils/common.dart';
import '../utils/style.dart';

class HelpScreen extends StatelessWidget {
  HelpScreen({Key? key}) : super(key: key);
  final TextEditingController QuestionController = TextEditingController();
  List helpVal = ['Question 1', 'Question 2', 'Question 3', 'Question 4'];
  List prodList = [
    'assets/images/pulse.png',
    'assets/images/onion.png',
    // 'assets/images/snacks.png',
    'assets/images/potato.png',
    'assets/images/pulse.png',
    'assets/images/watermelon.png',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        centerTitle: true,
        title: 'Help',
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                child: DropDownBtn(
                  labelText: 'Select Question',
                  listData: helpVal,
                  pageName: 'Select Question',
                  vertical: 10,
                  listController: QuestionController,
                ),
              ),
              heightSizedBox(10.0),
              EditTextField(
                headTxt: 'Message',
                formBox: true,
                hintText: 'Message',
                textAlign: TextAlign.start,
                maxLines: 6,
              ),
              heightSizedBox(10.0),
              Btn(
                btnName: 'UPLOAD PHOTOS',
                color: offgreenColor,
                txtColor: txtWhiteColor,
                width: 200,
                height: 40,
              ),
              heightSizedBox(10.0),
              ImgHorizontalList(
                prodList: prodList,
                btn: true,
                cheight: 100,
              )
            ],
          ),
        ),
      ),
      bottomNavigationBar: Padding(
        padding: const EdgeInsets.all(20),
        child: Btn(
          // alignment: Alignment.bottomLeft,
          height: 45,
          width: double.infinity,
          btnName: 'Submit',
          txtColor: txtWhiteColor,
          color: redColor,
          // onTap: () => navigationPush(context, ),
        ),
      ),

      // ),
      // ),
    );
  }
}
