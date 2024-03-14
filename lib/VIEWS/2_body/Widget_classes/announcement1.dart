import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';

import '../../../CONTROLLERS/Bannerscontroller.dart';
import '../produxts_gris_show.dart';


class Announcement extends StatefulWidget {
  Announcement({
    required this.banner,
    required this.background,
  });
  String banner;
  bool background;

  @override
  State<Announcement> createState() => _AnnouncementState();
}

class _AnnouncementState extends State<Announcement> {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return FutureBuilder<String>(
      future: bannerUrl().getCurrentImageUrl(widget.banner),
      builder: (BuildContext context, AsyncSnapshot<String> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!, // Adjust the base and highlight colors
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: ((size.height * 0.1) - 5),
              width: size.width,
              margin: EdgeInsets.only(left: 10, right: 10,),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.grey.shade300,
              ),
            ),
          );
        } else if (snapshot.hasError || !snapshot.hasData || snapshot.data == null) {
          return Text('Error loading image');
        } else {
          return GestureDetector(
            onTap: (){
              Get.to(()=>Grid_show());
            },
            child: Container(
              decoration: widget.background==true?BoxDecoration(
                  boxShadow: [
                    BoxShadow(
                      color: Colors.brown.withOpacity(0.5),
                      offset: Offset(0, 3),
                      spreadRadius: 1,
                      blurRadius: 8,
                    )
                  ]
              ):BoxDecoration(),
              height: size.height * 0.15,
              width: size.width,
              margin: EdgeInsets.only(right: 10, left: 10, top: 20),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: CachedNetworkImage(
                  imageUrl: snapshot.data!,
                    fit: BoxFit.fitWidth,
                ), // Use the retrieved image URL
              ),
            ),
          );
        }
      },
    );
  }
}

