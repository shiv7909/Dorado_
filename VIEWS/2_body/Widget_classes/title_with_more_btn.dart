

import 'package:animated_text_kit/animated_text_kit.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import '../../../CONTROLLERS/body1/Title_retriver_controller.dart';


class TitleWithMoreBtn extends StatelessWidget {
   TitleWithMoreBtn({
    Key? key, required  this.title,
    required this.size,
    required this.position,
     required this.background,
  }):super(key: key);

  final String title;
  final double size;
  final String position;
  final bool background;


  @override
  Widget build(BuildContext context) {
// Size size=MediaQuery.of(context).size;

    final titleRetriever = Get.find<Title_retriever>();

    return FutureBuilder<String> (
        future: titleRetriever.fetchTitle(title),
        builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Container(
                height: 20,
                margin: EdgeInsets.only(left: 15,right: 15),
                decoration: BoxDecoration(borderRadius: BorderRadius.all(Radius.circular(10 ))),
            );
          }
          else {
            return

                    Row(
                      mainAxisAlignment: position=="CenterLeft"?MainAxisAlignment.start:MainAxisAlignment.center,
                      children: [
                        Container(

                          margin: EdgeInsets.only(top: 5,bottom: 8,left: 10),
                          padding: background==true? EdgeInsets.all(10): const EdgeInsets.only(top: 3,left: 2,right: 5),

                          child:

                          Text( snapshot.data!.toUpperCase() ,
                            style: GoogleFonts.plusJakartaSans(
                                fontWeight: FontWeight.w700,
                              )
                                .copyWith(
                                color: Colors.black45.withOpacity(0.8),
                                fontSize: size
                            ),
                            textAlign: TextAlign.center,

                        ),

                                    ),
                      ],
                    );
          }
        }
    );
    }
  }

