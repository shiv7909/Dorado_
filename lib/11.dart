import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled1/CONTROLLERS/auth_controller.dart';
import 'package:untitled1/VIEWS/5_body/account_signout.dart';
import 'package:untitled1/virtualTryOnPage.dart';

import 'MODELS/constants.dart';
import 'VIEWS/4_body/Bag/chooseing_from_lst_address.dart';
import 'VIEWS/5_body/Favourites.dart';
import 'VIEWS/5_body/shoppingAddresses.dart';

class ECommerceApp extends StatelessWidget {
  final USER_CHECK controller=Get.put(USER_CHECK());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     // backgroundColor: Color(0XFFCCEAE9),
      appBar: AppBar(
     //   backgroundColor:Color(0XFFCCEAE9),
       // centerTitle: true,

        title: Text('Profile', style: GoogleFonts.plusJakartaSans(
          fontWeight: FontWeight.w500,
        )
            .copyWith(
            color: Colors.black.withOpacity(0.9),
            fontWeight: FontWeight.bold,

        )),
        actions: [
          Container(
            padding: EdgeInsets.all(8),

            child: GestureDetector(

            onTap: () {
              showDialog(context: context, builder: (context){
                return AlertDialog(
                  elevation: 30,
                  shadowColor: Colors.black,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(25)
                  ),
                  backgroundColor: Colors.white,
                 title: Text("Confirm Logout", style: GoogleFonts.plusJakartaSans(
                   fontWeight: FontWeight.w700,
                   // color: AppColor.kWhite
                 )
                     .copyWith(
                     color: Colors.black,
                     fontSize: 18),),


                 content: Text("Are you sure you want to logout ?", style: GoogleFonts.plusJakartaSans(

                   fontWeight: FontWeight.w500,

                 )
                     .copyWith(

                     fontSize: 14),),
                  actionsAlignment: MainAxisAlignment.center,
                  actions: <Widget>[
                    TextButton(
                      onPressed: () {
                        // Perform logout action here
                        // For example: controller.logOut();
                        Navigator.of(context).pop(true); // Dismiss the dialog and return true
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(

                          borderRadius: BorderRadius.circular(15),
                          color: Colors.grey.withOpacity(0.2)
                        ),
                        width: 80,

                       child:     Text("yes", style: GoogleFonts.plusJakartaSans(

                              fontWeight: FontWeight.w600,
                            )
                                .copyWith(
                                fontSize: 14),),


                      ),
                    ),
                    TextButton(

                      onPressed: () {
                        Navigator.of(context).pop(false); // Dismiss the dialog and return false
                      },
                      child: Container(
                        padding: EdgeInsets.symmetric(vertical: 10),
                        alignment: Alignment.center,

                        decoration: BoxDecoration(

                            borderRadius: BorderRadius.circular(15),
                          color: Colors.red,
                        ),
                        width: 80,

                        child:     Text("NO", style: GoogleFonts.plusJakartaSans(

                          fontWeight: FontWeight.w800,
                           color: AppColor.kWhite
                        )
                            .copyWith(
                            fontSize: 12.5),),
                      ),

                    ),
                  ],
                );
              }).then((value) {
                  if (value == true) {
                     controller.logOut();
              }});},
              child: Container(
                child: Icon(FontAwesomeIcons.rightFromBracket,size: 18,),
              ),
            ),
          ),
          SizedBox(width: 15,)
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(45),
                      child: Image.network( controller.user?.photoURL??""),
                    ),
                  ),
                  // CircleAvatar(
                  //   radius: 50,
                  //   backgroundImage: NetworkImage(controller.user?.photoURL??""), // Add your profile picture asset
                  // ),
                  SizedBox(height: 10),
                  Text(
                    controller.user?.displayName??"", // Add user's name here
                      style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.w500,
                      )
                          .copyWith(
                          color: Colors.black.withOpacity(0.65),
                          //color: kTextcolor,
                          fontWeight: FontWeight.bold,
                          fontSize: 15
                      )
                  ),
                  Text(
                   controller.user?.email??"", // Add user's email address here
                      style: GoogleFonts.plusJakartaSans(
                        fontWeight: FontWeight.w500,
                      )
                          .copyWith(
                          color: Colors.grey,
                          //color: kTextcolor,
                          fontWeight: FontWeight.bold,
                          fontSize: 13.4
                      )
                  ),
                ],
              ),
            ),
         //   Divider(thickness: 1, color: Colors.grey),

              ListTile(
                leading: Icon(Icons.favorite,color: Colors.black,size: 15,),
                title: Text('Favorites',
                    style: GoogleFonts.plusJakartaSans(
                      fontWeight: FontWeight.w500,
                    )
                        .copyWith(
                        color: Colors.black.withOpacity(0.9),
                        //color: kTextcolor,
                        fontWeight: FontWeight.bold,
                        fontSize: 14
                    )),
                onTap: () {
                 Get.to(()=>Fav());
                },
                trailing: Icon(Icons.arrow_forward_ios_sharp,color: Colors.black.withOpacity(0.5),size: 15),
              ),

          //  Divider(thickness: 1, color: Colors.grey),
            ListTile(
              leading: Icon(Icons.history,color: Colors.black,size: 15),
              title: Text('Previous orders',
                  style: GoogleFonts.plusJakartaSans(
                    fontWeight: FontWeight.w500,
                  )
                      .copyWith(
                      color: Colors.black.withOpacity(0.9),
                      //color: kTextcolor,
                      fontWeight: FontWeight.bold,
                      fontSize: 14
                  )),
              onTap: () {
                // Navigate to previous orders screen
              },
              trailing: Icon(Icons.arrow_forward_ios_sharp,color: Colors.black.withOpacity(0.5),size: 15),
            ),

            ListTile(
              leading: Icon(Icons.fire_truck,color: Colors.black,size: 15),
              title: Text('Track orders',
                  style: GoogleFonts.plusJakartaSans(
                    fontWeight: FontWeight.w500,
                  )
                      .copyWith(
                      color: Colors.black.withOpacity(0.9),
                      //color: kTextcolor,
                      fontWeight: FontWeight.bold,
                      fontSize: 14
                  )),
              onTap: () {
               // launchSceneViewer();
                 Get.to(()=>ModelView());
              },
              trailing: Icon(Icons.arrow_forward_ios_sharp,color: Colors.black.withOpacity(0.5),size: 15),
            ),


            ListTile(
                leading: Icon(Icons.location_on_rounded,color: Colors.black,size: 15),
                title: Text('Shopping addresses',
                    style: GoogleFonts.plusJakartaSans(
                      fontWeight: FontWeight.w500,
                    )
                        .copyWith(
                        color: Colors.black.withOpacity(0.9),
                        //color: kTextcolor,
                        fontWeight: FontWeight.bold,
                        fontSize: 14
                    )),
                onTap: () {
                  Get.to(()=>ShoppinAddess_body5());
                },
                trailing: Icon(Icons.arrow_forward_ios_sharp,color: Colors.black.withOpacity(0.5),size: 15),
              ),

        //    Divider(thickness: 1, color: Colors.grey),
            // Add more options as needed
          ],
        ),
      ),
    );
  }
}