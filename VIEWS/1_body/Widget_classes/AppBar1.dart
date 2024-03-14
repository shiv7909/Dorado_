import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../CONTROLLERS/body1/Title_retriver_controller.dart';
import 'onBoarding.dart';



class Appbar1 extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => const Size.fromHeight(60);

  @override
  Widget build(BuildContext context) {
    String title = 'HEADER_title';
    final titleRetriever = Get.find<Title_retriever>();

    return
        SafeArea(
          child: Container(
              alignment: Alignment.center,
              height: 60,
              decoration: BoxDecoration(
                color:Color(0XFFCCEAE6),
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

              ),
              child: Column(
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      FutureBuilder<String>(
                          future: titleRetriever.fetchTitle("Title2"),
                          builder: (BuildContext context,
                              AsyncSnapshot<String> snapshot) {
                            if (snapshot.connectionState ==
                                ConnectionState.waiting) {
                              return Container(
                                height: 20,
                                margin: EdgeInsets.only(left: 15, right: 15),
                                decoration: BoxDecoration(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(10))),
                              );
                            } else {
                              return Container(
                                margin: EdgeInsets.only(left: 15),
                                height: 60,
                                alignment: Alignment.center,
                                child: GestureDetector(
                                    onTap: () {
                                    },
                                    child: Text(
                                      snapshot.data!.toUpperCase(),
                                      style: GoogleFonts.plusJakartaSans(
                                          fontSize: 14,
                                          fontWeight: FontWeight.bold,
                                          color:Colors.black.withOpacity(0.7)
                                         ),
                                    )),
                              );
                            }
                          }),

                      // Container(
                      //   margin: EdgeInsets.only(right: 8),
                      //   height: 60,
                      //   alignment: Alignment.center,
                      //   child: GestureDetector(
                      //       onTap: () {
                      //         Get.to(() => OnboardingScreen());
                      //       },
                      //       child: Icon(
                      //         Icons.list_rounded,
                      //         color: Colors.black,
                      //         size: 30,
                      //       )),
                      // ),
                      // Header(),
                    ],
                  ),
                ],
              )),

    );
  }
}
