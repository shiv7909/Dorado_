


import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:untitled1/CONTROLLERS/body2/product_retriving/product_controller.dart';

import '../../../CONTROLLERS/body1/Advertisement_mini_controller.dart';
import '../../../CONTROLLERS/body2/product_retriving/mainpeoductController.dart';
import '../../2_body/Product_ramp_grid_BODY.dart';
import '../../Others/mainproductpage.dart';

class Advertise_widgetMini extends StatelessWidget {
   Advertise_widgetMini({Key? key});

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final controller = Get.put(AdvertiseMini());

    return FutureBuilder(
      future: controller.fetchAnnouncementData(),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(child: Text('Error: ${snapshot.error}'));
        } else {
          return Obx(() {
            if (controller.imageUrls.isEmpty) {
              return Container(); // Return an empty container if imageUrls is empty
            }
            return _buildUI(controller, size);
          });
        }
      },
    );
  }

  Widget _buildUI(AdvertiseMini controller, Size size) {
    return Container(
      width: size.width,
      child: Column(
        children: [
          Row(
            children: [
              GestureDetector(
                onTap: (){
                  Get.to(()=>Grid_show( title: 'Add_mini',));
                },
                child: Card(
                  elevation: 2,
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: Container(
                    height: size.height * 0.2,
                    width: size.width * 0.5,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: controller.imageUrls[0],
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              Column(
                children: [
                  SizedBox(height: 22),
                  InkWell(
                    onTap: (){
                      Get.to(()=>ProductDisplayScreen(id:controller.products[0].id,varid:controller.products[0].variation));
                    },
                    child: Card(
                      elevation: 2,
                      margin: EdgeInsets.all(0),
                      child: Container(
                        height: size.height * 0.2,
                        width: size.width * 0.5 - 28,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(10),
                        ),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(10),
                          child: CachedNetworkImage(
                            imageUrl: controller.imageUrls[1],
                            fit: BoxFit.cover,
                          ),
                        ),
                      ),
                    ),
                  ),
                ],
              )
            ],
          ),
          Row(
            children: [
              GestureDetector(
                onTap: (){
                  Get.to(()=>ProductDisplayScreen(id:controller.products[1].id,varid:controller.products[1].variation));
                },
                child: Card(
                  elevation: 2,
                  margin: EdgeInsets.only(left: 10, right: 10),
                  child: Container(
                    height: size.height * 0.2,
                    width: size.width * 0.5 - 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(10),
                      child: CachedNetworkImage(
                        imageUrl: controller.imageUrls[2],
                          fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
              InkWell(
                onTap: (){
                  Get.to(()=>Grid_show( title: 'Add_mini',));
                },
                child: Container(
                  alignment: Alignment.center,
                  height: size.height * 0.2,
                  width: size.width * 0.5,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    //   color: Colors.black,
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        controller.text.value,
                        style: TextStyle(
                          fontFamily: "light1",
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: EdgeInsets.all(5),
                        margin: EdgeInsets.all(15),
                        decoration: BoxDecoration(
                            shape: BoxShape.rectangle,
                            color: Colors.red,
                            borderRadius: BorderRadius.circular(10)),
                        child: Text(
                          "Shop collection",
                          style: TextStyle(
                            color: Colors.white,
                            fontSize: 12,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              )
            ],
          )
        ],
      ),
    );
  }
}
