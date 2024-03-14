import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:untitled1/CONTROLLERS/body2/product_retriving/mainpeoductController.dart';
import '../../../CONTROLLERS/body1/Advertisement_controller.dart';
import '../../../MODELS/body1/Advertisement_model.dart';
import '../../Others/mainproductpage.dart';

class Advertisewidget extends StatefulWidget {
  final String Subcollection;
  Advertisewidget({required this.Subcollection});
  @override
  Advertise_widget createState() => Advertise_widget();
}

class Advertise_widget extends State<Advertisewidget> {
  final announcementController = Get.find<Advertisement_controller>();

  late String Category = "Men";
  late String Subcollection = widget.Subcollection;

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return FutureBuilder<List<AdvertisementData>?>(
      future:
          announcementController.getCurrentImageData(Category, Subcollection),
      builder: (BuildContext context,
          AsyncSnapshot<List<AdvertisementData>?> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Shimmer.fromColors(
            baseColor: Colors.grey[300]!,
            highlightColor: Colors.grey[100]!,
            child: Container(
              height: size.height * 0.7,
              width: size.width,
              margin: EdgeInsets.only(left: 5, right: 5, top: 5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(25),
                color: Colors.grey.shade300,
              ),
            ),
          );
        } else if (snapshot.hasError ||
            !snapshot.hasData ||
            snapshot.data!.isEmpty) {
          return Container();
        } else {
          return Container(
            child: Column(
              children: [
                for (var data in snapshot.data!)
                  Container(
                    width: size.width * 1,
                    margin: EdgeInsets.only(bottom: 30, top: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                    ),

                      child: Stack(
                        children: [
                          Container(
                            height: size.height * 0.7,
                            width: size.width * 1,
                            child: ClipRRect(
                             // borderRadius: BorderRadius.circular(2),
                              child: CachedNetworkImage(
                                imageUrl: data.imageUrl,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),

                          Positioned(
                            bottom: 15,
                            right: 15,
                            width: size.width * 0.3,
                            height: size.height * 0.05,
                            child: OutlinedButton(
                              onPressed: () {
                                // Add your onPressed function here
                              },
                              style: ButtonStyle(
                                shape: MaterialStateProperty.all<
                                    RoundedRectangleBorder>(
                                  RoundedRectangleBorder(
                                    borderRadius: BorderRadius.zero,
                                  ),
                                ),
                                side: MaterialStateProperty.all<BorderSide>(
                                  BorderSide(
                                    width: 2.0,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              child: null,
                            ),
                          ),
                          Positioned(
                            bottom: 20,
                            right: 20,
                            child: InkWell(
                              onTap: () {
                                Get.to(()=>ProductDisplayScreen(id: data.id ,varid: data.variationId,));
                              },
                              child: Container(
                                width: size.width * 0.3,
                                height: size.height * 0.05,
                                color: Colors.white,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                    Text(
                                      'Shop now ',
                                      style: TextStyle(
                                        color: Colors.black,
                                        fontWeight: FontWeight.bold,
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                  ),
              ],
            ),
          );
        }
      },
    );
  }
}

