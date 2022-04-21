import 'package:flutter/material.dart';
import '../Elements/baseAppbar.dart';
import '../common/button.dart';
import '../scrpart/imgslider.dart';
import '../utils/common.dart';
import '../utils/style.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({Key? key}) : super(key: key);

//   @override
//   State<NotificationScreen> createState() => _NotificationScreenState();
// }

// class _NotificationScreenState extends State<NotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        centerTitle: true,
        title: 'Notification',
      ),
      body: Container(
        child: ListView.builder(
          itemCount: 9,
          shrinkWrap: true,
          itemBuilder: ((context, i) {
            return NotificationContent(prodNumber: i);
          }),
        ),
      ),
    );
  }
}

class NotificationContent extends StatefulWidget {
  dynamic prodNumber;
  NotificationContent({Key? key, this.prodNumber}) : super(key: key);

  @override
  State<NotificationContent> createState() => _NotificationContentState();
}

class _NotificationContentState extends State<NotificationContent> {
  dynamic isHover = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: () => print('data ${widget.prodNumber}'),
        onHover: (val) {
          // print(val);

          if (isHover == false) {
            setState(() {
              isHover = true;
            });
          } else {
            setState(() {
              isHover = false;
            });
          }
        },
        child: Container(
            padding: const EdgeInsets.all(10.0),
            margin: EdgeInsets.all(10),
            decoration: BoxDecoration(
                color: isHover == true ? notiBgColor : null,
                border: Border(
                    bottom: BorderSide(
                  width: 1.0,
                  color: borderColor,
                ))
                // border: Border.all(
                //     width: 1, color: Color.fromARGB(255, 221, 214, 214))
                ),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Txt(
                      t: 'Title Name ${widget.prodNumber} ',
                      style: labelTextStyle,
                      // fontSize: 15,
                      // fontWeight: FontWeight.bold,
                    ),
                    Txt(
                      t: '${widget.prodNumber} Yesterday,5:50 AM',
                      fontSize: 12,
                      color: greyColor,
                    ),
                  ],
                ),

                // ! Content
                Container(
                  child: Txt(
                    t: '${widget.prodNumber} In publishing and graphic design, Lorem ipsum is a placeholder text commonly used to demonstrate the visual form of a document or a typeface without relying on meaningful content. Lorem ipsum may be used as a placeholder before the final copy is available. ',
                    style: smallTextStyle,
                  ),
                )
              ],
            )));
  }
}
