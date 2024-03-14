import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../CONTROLLERS/body4/Addadress_controller.dart';
import 'chooseing_from_lst_address.dart';

class ADDRESS extends StatefulWidget {
  const ADDRESS({super.key});

  @override
  State<ADDRESS> createState() => _ADDRESSState();
}

class _ADDRESSState extends State<ADDRESS> {
  final latestaddress = Get.find<AddAddressController>();

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    print(latestaddress.addressList);
    return Obx(() {
      return GestureDetector(
        onTap: () {
          //  latestaddress.fetchLatestAddress();
        },
        child: Container(
          padding: EdgeInsets.only(left: 8, right: 15, bottom: 15, top: 10),
          margin: EdgeInsets.only(top: 15, left: 10, right: 10),
          decoration: BoxDecoration(
            shape: BoxShape.rectangle,
            borderRadius: BorderRadius.circular(30),
            color: Color(0XFFCCEAE9),
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                child: Row(
                  children: [
                    Row(
                      children: [
                        Icon(
                          Icons.location_on_rounded,
                          size: 15,
                          color: Colors.black54,
                        ),
                        Text(
                          "    Delivering to",
                          style: GoogleFonts.plusJakartaSans(
                              color: Colors.black54,
                              fontWeight: FontWeight.w800,
                              fontSize: 13),
                        ),
                      ],
                    ),
                    Spacer(),
                    GestureDetector(
                      onTap: () {
                        showModalBottomSheet(
                          backgroundColor: Colors.transparent,
                          context: context,
                          isScrollControlled: true,
                          builder: (context) {
                            return Container(
                                padding: EdgeInsets.only(
                                    top: size.height * 0.16,
                                    left: 10,
                                    right: 10,
                                    bottom: 10),
                                child: AddressPage());
                          },
                        );
                      },
                      child: latestaddress.addressList.isNotEmpty
                          ? Container(
                              padding: EdgeInsets.all(5),
                              child: Text(
                                "Edit",
                                style: Theme.of(context)
                                    .textTheme
                                    .displaySmall
                                    ?.copyWith(
                                        fontSize: 12,
                                        fontWeight: FontWeight.w500,
                                        color: Colors.blue),
                              ),
                            )
                          : SizedBox.shrink(),
                    )
                  ],
                ),
              ),
              (latestaddress.addressList.isNotEmpty)
                  ? Container(
                      padding: EdgeInsets.only(left: 15, top: 10),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "${latestaddress.addressList[latestaddress.selectedIndex.value]['name']},${latestaddress.addressList[latestaddress.selectedIndex.value]['house-number']}, ${latestaddress.addressList[latestaddress.selectedIndex.value]['locality/colony']}, ${latestaddress.addressList[latestaddress.selectedIndex.value]['city/town/village']}",
                            //     style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 13, fontWeight: FontWeight.w400),
                            style: GoogleFonts.plusJakartaSans(
                                color: Colors.black.withOpacity(0.7),
                                fontWeight: FontWeight.w600,
                                fontSize: 12),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "${latestaddress.addressList[latestaddress.selectedIndex.value]['state']},  ${latestaddress.addressList[latestaddress.selectedIndex.value]['pinCode']}",
                            textAlign: TextAlign.center,
                            // style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 13, fontWeight: FontWeight.w400),
                            style: GoogleFonts.plusJakartaSans(
                                color: Colors.black.withOpacity(0.7),
                                fontWeight: FontWeight.w600,
                                fontSize: 12),
                          ),
                          SizedBox(height: 4),
                          Text(
                            "Contact Number: ${latestaddress.addressList[latestaddress.selectedIndex.value]['phoneNumber']}",
                            textAlign: TextAlign.center,
                            // style: Theme.of(context).textTheme.displaySmall?.copyWith(fontSize: 13, fontWeight: FontWeight.w400),
                            style: GoogleFonts.plusJakartaSans(
                                color: Colors.black.withOpacity(0.7),
                                fontWeight: FontWeight.w600,
                                fontSize: 12),
                          ),
                        ],
                      ),
                    )
                  : Padding(
                      padding: const EdgeInsets.only(top: 25, bottom: 15),
                      child: Center(
                        child: GestureDetector(
                            onTap: () {
                              showModalBottomSheet(
                                backgroundColor: Colors.transparent,
                                context: context,
                                isScrollControlled: true,
                                builder: (context) {
                                  return Container(
                                      padding: EdgeInsets.only(
                                          top: size.height * 0.16,
                                          left: 10,
                                          right: 10,
                                          bottom: 10),
                                      child: AddressPage());
                                },
                              );
                            },
                            child: Text(
                              "+ Choose Address",
                              style: GoogleFonts.plusJakartaSans(
                                  color: Colors.blue.withOpacity(0.5),
                                  fontWeight: FontWeight.w800,
                                  fontSize: 12),
                            )),
                      ),
                    ),
            ],
          ),
        ),
      );
    });
  }
}
