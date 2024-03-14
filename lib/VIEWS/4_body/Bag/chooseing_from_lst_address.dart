import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../CONTROLLERS/user_address_controller/Addadress_controller.dart';
import 'Enter_new_address.dart';

class AddressPage extends StatefulWidget {
  @override
  State<AddressPage> createState() => _AddressPageState();
}

class _AddressPageState extends State<AddressPage> {
  final latestAddress = Get.find<AddAddressController>();


  
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    return Container(
      color: Colors.transparent, // Ensure the background is transparent
      child: Stack(
        children:[
          Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Expanded(
              child: Container(
                padding: EdgeInsets.only(left: 10,right: 10),
                margin: EdgeInsets.only(bottom: 10),
                width: size.width,
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.vertical(top: Radius.circular(30),bottom: Radius.circular(30)),
                  boxShadow: [
                    BoxShadow(
                      color:
                        Colors.black,
                      blurRadius: 5
                    )
                  ]
                ),
                child: addresscontent(page: 'checkout',),

              ),
            ),
          ],
        ),
          if  (latestAddress.addressList.length!=0)
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
                            Get.to(()=>Address());
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
              ),
      ]

      ),
    );
  }
}




class addresscontent extends StatefulWidget {
  String page;
   addresscontent({super.key,required this.page});

  @override
  State<addresscontent> createState() => _addresscontentState();
}

class _addresscontentState extends State<addresscontent> {
  @override
  Widget build(BuildContext context) {
    Size size=MediaQuery.of(context).size;
    final latestAddress = Get.find<AddAddressController>();
    return  Padding(
      padding: const EdgeInsets.only(left: 8,right: 8,bottom: 8),
      child: Column(
        //     crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          if(widget.page=="checkout")
          Container(
              padding: EdgeInsets.symmetric(vertical: 14),
              alignment: Alignment.center,
              child: Text(
                'Choose Shipping Address',
                style: TextStyle(fontWeight: FontWeight.w500,
                    fontSize: 16,
                    color: Colors.black.withOpacity(0.8)),
              )
          ),
          if(widget.page=="checkout")
          Divider(height: 1, color: Colors.grey),

          Expanded(
              child: latestAddress.addressList.length!=0?
              ListView.builder(
                itemCount: latestAddress.addressList.length,
                itemBuilder: (context, index) {
                  final address = latestAddress.addressList[index];

                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        latestAddress.selectedIndex.value = index;
                      });
                    },
                    child: Container(
                      margin: EdgeInsets.only(top: 10, bottom: 5),
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(15),
                        color: Colors.brown.withOpacity(0.1),
                        border: Border.all(
                          width:   latestAddress.selectedIndex == index ? 0.4:0,
                          color: latestAddress.selectedIndex == index ?Colors.black.withOpacity(0.3):Colors.transparent,
                        )
                      ),
                      child: ListTile(
                        title: Text('${address['name']}, ${address['house-number']}, ${address['locality/colony']}, ${address['city/town/village']}'),
                        subtitle: Text('${address['state']}, ${address['pinCode']}'),
                        titleTextStyle: GoogleFonts.plusJakartaSans(
                          color: Colors.black.withOpacity(0.7),
                          fontWeight: FontWeight.w600,
                        ).copyWith(fontSize: 13),
                        subtitleTextStyle: GoogleFonts.plusJakartaSans(
                          color: Colors.black.withOpacity(0.7),
                          fontWeight: FontWeight.w600,
                        ).copyWith(fontSize: 13),

                        leading:  latestAddress.selectedIndex == index ?
                        Container(
                          width: 16,
                          height: 16,
                          // decoration: BoxDecoration(
                          //   color: latestAddress.selectedIndex == index ? Colors.transparent : Colors.transparent,
                          //   border: Border.all(color: Colors.blue, width: 2),
                          // ),
                          child:Icon(Icons.location_on_rounded,color: Colors.red,),
                        ):SizedBox.shrink(),
                      ),
                    ),
                  );
                },
              ):Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assists/images/1bied.png",),
                      Text("We're waiting for your  address",style: GoogleFonts.plusJakartaSans(
                        color: Colors.black.withOpacity(0.9),
                        fontWeight: FontWeight.w700,
                      ).copyWith(fontSize: 15),),
                      SizedBox(height: 15,),
                      Text("Let us pack something special",style: GoogleFonts.plusJakartaSans(
                        color: Colors.black.withOpacity(0.6),
                        fontWeight: FontWeight.w700,
                      ).copyWith(fontSize: 13),),
                      Text("for you",style: GoogleFonts.plusJakartaSans(
                        color: Colors.black.withOpacity(0.6),
                        fontWeight: FontWeight.w700,
                      ).copyWith(fontSize: 13),),



                      SizedBox(height: 35,),
                      InkWell(
                        onTap: (){
                          Get.back();
                          Get.to(()=>Address());
                        },

                        child: Text(''
                            '+ Add new Address ',style: GoogleFonts.plusJakartaSans(color:Colors.blue,
                          fontWeight: FontWeight.w600,
                        ),
                        ),
                      ),
                    ],
                  ))
          ),

          Container(height: size.height*0.13,)
          // SizedBox(height: 190,)
        ],
      ),
    );
  }
}



