// import 'package:flutter/material.dart';
// import '../Elements/baseAppbar.dart';
// import '../utils/style.dart';

// class SelCategoryScreen extends StatelessWidget {
//   const SelCategoryScreen({Key? key}) : super(key: key);

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: BaseAppBar(
//         title: 'Category',
//         centerTitle: true,
//       ),
//       body: Center(
//           child: Text(
//         'Category ',
//         style: labelTextStyle,
//       )),
//     );
//   }
// }
import 'package:flutter/material.dart';
import '../Elements/baseAppbar.dart';
import '../common/button.dart';
import '../utils/style.dart';

class SelCategoryScreen extends StatelessWidget {
  const SelCategoryScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: BaseAppBar(
          boolLeading: true,
          centerTitle: true,
          title: 'Category',
        ),

        // body: CustomScrollView(
        //   slivers: [

        //   ],
        // ),
        body: Container(
          child: ListView.builder(
              shrinkWrap: true,
              itemCount: 3,
              itemBuilder: ((context, index) => ListView(
                    shrinkWrap: true,
                    children: [
                      Text(
                        'Category name',
                        style: labelTextStyle,
                      ),
                      Wrap(
                        children: List.generate(
                          10,
                          (index) {
                            return Padding(
                              padding: const EdgeInsets.all(8.0),
                              child: FilterChip(
                                label: Text('index $index'),
                                onSelected: (val) {},
                                // disabledColor :
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ))),
        ),
        bottomNavigationBar: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15.0, vertical: 3.0),
          child: Btn(
            onTap: () {},
            height: 35,
            width: 200,
            btnName: 'Submit',
            color: Colors.green,
            txtColor: offWhiteColor,
          ),
        ));
  }
}
