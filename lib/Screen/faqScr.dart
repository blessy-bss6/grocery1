import 'package:flutter/material.dart';
import '../Elements/baseAppbar.dart';
import '../common/button.dart';
import '../utils/style.dart';

class FaqScreen extends StatelessWidget {
  const FaqScreen({Key? key}) : super(key: key);

//   @override
//   State<FaqScreen> createState() => _FaqScreenState();
// }

// class _FaqScreenState extends State<FaqScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: BaseAppBar(
        centerTitle: true,
        title: 'FAQs',
      ),
      body: Container(
        margin: EdgeInsets.all(3),
        width: double.infinity,
        child: ListView.builder(
            itemCount: 9,
            shrinkWrap: true,
            itemBuilder: (context, i) {
              return FaqContent(prodNumber: i);
              // return Text('home');
            }),
      ),
    );
  }
}

class FaqContent extends StatefulWidget {
  dynamic prodNumber;
  FaqContent({Key? key, this.prodNumber}) : super(key: key);

  @override
  State<FaqContent> createState() => _FaqContentState();
}

class _FaqContentState extends State<FaqContent> {
  dynamic click = false;
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        if (click == false) {
          setState(() {
            click = true;
          });
        } else {
          setState(() {
            click = false;
          });
        }
      },
      child: Container(
        decoration: BoxDecoration(
            color: click == true ? FaqBgColor : null,
            border: Border(bottom: BorderSide(width: 1.0, color: borderColor))),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Txt(t: 'Question for asking ?'),
                IconBtn(
                  onPressed: () {
                    if (click == false) {
                      setState(() {
                        click = true;
                      });
                    } else {
                      setState(() {
                        click = false;
                      });
                    }
                  },
                  icon: click == true
                      ? Icons.keyboard_arrow_up
                      : Icons.keyboard_arrow_down,
                  size: 20,
                  color2: Colors.black,
                )
              ],
            ),
            Container(
                child: click == true
                    ? Txt(
                        fontSize: 15,
                        t: "Lorem ipsum dolor sit amet . The graphic and typographic operators know this well, in reality all the professidealing with the universe of communication have a stable relationship with these words, but what i it? Lorem ipsum is a dummy text without any sense.")
                    : null)
          ],
        ),
      ),
    );
  }
}
