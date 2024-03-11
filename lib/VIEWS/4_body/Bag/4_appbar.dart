
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class cart_icon_head extends StatelessWidget {


  late final String nameString;

  cart_icon_head({

    required this.nameString,
  });



  @override
  Widget build(BuildContext context) {



    Size size = MediaQuery.of(context).size;


    return

      Container(
        margin: EdgeInsets.only(top: 15),

        decoration: BoxDecoration(
           // borderRadius: BorderRadius.circular(20),
           color: Color(0XFFCCEAE9),
          // color: Colors.white
            // boxShadow: [
            //   BoxShadow(
            //       color: Colors.blueGrey.withOpacity(0.4),
            //       offset: Offset(0,2),
            //       blurRadius: 1
            //   )
            // ]
        ),
       // margin: EdgeInsets.only(top: 3),
        alignment: Alignment.center,
        child: Stack(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                InkWell(
                  onTap: () {
                    Get.back();
                  },
                  child: Container(

                    alignment: Alignment.center,
                    margin: EdgeInsets.only(left: 5),
                     width: size.width*0.1,
                      child: Icon(
                        Icons.arrow_back_ios_new,
                        size: 17,
                        weight: 2,

                    ),
                  ),
                ),


                Expanded(
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Row(
                      children: [
                        Text(
                          nameString,
                          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 16,color: Colors.black),
                        ),
                        SizedBox(width: 2,),

                        Icon(Icons.shopping_bag,size: 18,)

                      ],
                    ),
                  ),
                ),

                Container(
                //  margin: EdgeInsets.only(right: 5),
                  // width: size.width * 0.1,
                  child: PopupMenuButton<String>(
                    onSelected: (value) {

                      switch (value) {
                        case 'Previous Orders':

                          break;
                        case 'Saved for Later':

                          break;
                        case 'Contact Support':

                          break;
                      }
                    },
                    itemBuilder: (BuildContext context) => <PopupMenuEntry<String>>[
                      PopupMenuItem<String>(
                        value: 'Previous Orders',
                        child: Text('Previous Orders'),
                      ),
                      PopupMenuItem<String>(
                        value: 'Saved for Later',
                        child: Text('Saved for Later'),
                      ),
                      PopupMenuItem<String>(
                        value: 'Contact Support',
                        child: Text('Contact Support'),
                      ),
                    ],
                  ),
                ),



              ],
            ),


          ],
        ),
      // ),

    );
  }
}
