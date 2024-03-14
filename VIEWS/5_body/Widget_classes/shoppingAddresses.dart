
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:untitled1/VIEWS/4_body/Bag/chooseing_from_lst_address.dart';

import '../../../CONTROLLERS/body4/Addadress_controller.dart';
import '../../4_body/Bag/Enter_new_address.dart';

class ShoppinAddess_body5 extends StatelessWidget {
   ShoppinAddess_body5({super.key});
  final latestAddress = Get.find<AddAddressController>();

  @override
  Widget build(BuildContext context) {

    Size size=MediaQuery.of(context).size;
    return SafeArea(
      child:

      Scaffold(
        appBar: AppBar(
          title: Text(
            'Choose Shipping Address',
            style: TextStyle(fontWeight: FontWeight.w500,
                fontSize: 16,
                color: Colors.black.withOpacity(0.8)),
          ),
          centerTitle: true,
        ),
        body:
        Stack(

       children: [
        addresscontent(page: 'others',),
          (latestAddress.addressList.length!=0)?
      Positioned(
      bottom: 4,
      child:   Container(
        alignment: Alignment.center,
        height: size.height*0.14,
        width: size.width-20,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            InkWell(
              onTap: (){
                Get.back();
              },
              child: Container(
                alignment: Alignment.center,
                padding: EdgeInsets.only(top: 15,bottom: 15),
                //   margin: EdgeInsets.only(left: 10,right: 10),
                margin: EdgeInsets.only(bottom: 15,right: 15,left: 15),
                // width: size.width - 60 ,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  color:Colors.black,
                ),

                child: Text('Select',style: GoogleFonts.plusJakartaSans(color:Colors.white,
                  fontWeight: FontWeight.w600,
                ),),
              ),
            ),

            InkWell(
              onTap: (){
                Get.back();
                // Get.to(()=>Address());
              },
              child: Container(
                alignment: Alignment.center,
                //    padding: EdgeInsets.symmetric(vertical: 15),
                //  padding: EdgeInsets.only(top: 15,bottom: 15),
                // margin: EdgeInsets.only(left: 10,right: 10),
                //    width: size.width - 20,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(20),
                  // color: Colors.black,
                ),
                child: Text('Add new Address ',style: GoogleFonts.plusJakartaSans(color:Colors.blue,
                  fontWeight: FontWeight.w600,
                ),
                ),),
            ),
          ],
        ),
      ),
    ):SizedBox.shrink(),
            ],
        //   ),
        // ),
        // SingleChildScrollView(
        //     child: Column(
        //       children: [
        //
        //
        //       ]
        //     ),
        // ),
      ),
      )
    );
  }
}
