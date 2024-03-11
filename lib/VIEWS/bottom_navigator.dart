import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled1/VIEWS/pageeState_controller.dart';




class CustomBottomNavigator extends StatefulWidget {
  CustomBottomNavigator({Key? key}) : super(key: key);

  @override
  State<CustomBottomNavigator> createState() => _CustomBottomNavigatorState();
}

class _CustomBottomNavigatorState extends State<CustomBottomNavigator> {
  final pageState = Get.find<PageState>();

  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;

    // according to theequation we can add more 10 combinig the both
    return Container(
     padding: EdgeInsets.only(left: 5,right: 5),

alignment: Alignment.center,
     width: size.width-30,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(25)),
           color: Colors.white.withOpacity(0.8),
          // gradient: LinearGradient(
          //     begin: Alignment.topCenter,
          //     end: Alignment.bottomCenter,
          //     colors:
          //     [
          //       Colors.brown.withOpacity(0.3),
          //       Color(0XFFCCEAE6),
          //       Colors.white,
          //     ]
          //   //colors: [Colors.white, Colors.white],
          // ),
          border: Border.all(
            color: Colors.brown.withOpacity(0.2)
          ),
        boxShadow: [
          BoxShadow(
            color: Colors.brown.withOpacity(0.2),
            blurRadius:4,
            spreadRadius: 1,
            offset: Offset(0,5)
          )
        ]
      ),

      height: 50,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          buildButton(Icons.home, 0),
          buildButton(Icons.search, 1),
         // buildButton(Icons.w, 2),
          buildButton(Icons.shopping_bag, 2),
          buildButton(Icons.account_circle_rounded, 3),
        ],
      ),
    );
  }

  Widget buildButton(IconData icon, int index) {
    Size size=MediaQuery.of(context).size;

    return GestureDetector(
      onTap: () {
        setState(() {
          pageState.page.value = index;

        });
      },
      child: Obx(()
    { return
    AnimatedContainer(

    duration: Duration(milliseconds: 700),
    width: pageState.page.value == index ? size.width/5: size.width/5-25, // Expand selected icon
    height: 40,
    alignment: Alignment.center,
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(25),
    color: pageState.page.value == index ? Colors.grey.withOpacity(0.2) : Colors.transparent,
    ),
    child:
    Icon(
    icon,
    color: pageState.page.value == index ? Colors.black : Colors.grey,
    ),
    );
    })
    );
  }
}


