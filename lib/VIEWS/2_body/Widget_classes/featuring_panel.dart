import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart'; // Import the shimmer package
import 'package:untitled1/VIEWS/2_body/Widget_classes/productcard1.dart';
import '../../../CONTROLLERS/product_card/Retriving_controllers/product_controller.dart';

class FeaturingPanel extends StatefulWidget {
  @override
  State<FeaturingPanel> createState() => _FeaturingPanelState();
}

class _FeaturingPanelState extends State<FeaturingPanel> {
  final Productcontroller = Get.find<ProductController>();

  int maxProductsToShow = 10;
  String quote = '';

  void loadMoreProducts() {}

  Widget buildShimmerPlaceholder(Size size) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!, // Adjust the base and highlight colors
      highlightColor: Colors.grey[100]!,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            margin: EdgeInsets.only(left: 10, right: 10),
            width: size.width * 0.4 + 30,
            height: size.height * 0.2 + 38,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10, right: 10, top: 4),
            width: (size.width * 0.4 + 30) / 2,
            height: 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
          ),
          Container(
            margin: EdgeInsets.only(left: 10, right: 10, top: 4),
            width: size.width * 0.4 + 30,
            height: 20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    bool showText = true; // Control flag to show text for the first 4 seconds

    return FutureBuilder(
        future: Future.delayed(Duration(microseconds: 4)),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            showText = false;
          }
          return Obx(() {
            if (Productcontroller.isLoading.value) {
              if (showText) {
                // Show text for the first 4 seconds
                return Shimmer.fromColors(
                  baseColor:
                      Colors.grey[500]!, // Adjust the base and highlight colors
                  highlightColor: Colors.black,
                  child: Container(
                    margin: EdgeInsets.only(left: 30, right: 30),
                    alignment: Alignment.center,
                    height: size.height * 0.42,
                    child: Text(
                      quote,
                      style: TextStyle(
                          fontWeight: FontWeight.bold, color: Colors.black54),
                      maxLines: 2,
                    ),
                  ),
                );
              } else {
                // After 4 seconds, show shimmering placeholders
                return SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children: List.generate(
                      maxProductsToShow,
                      (index) {
                        return buildShimmerPlaceholder(size);
                      },
                    ),
                  ),
                );
              }
            } else if (Productcontroller.products.isEmpty) {
              return Container(
                  alignment: Alignment.center,
                  height: size.height * 0.4,
                  child: Text('Loading'));
            } else {
              return Container(
                height: size.height * 0.39,
                child: ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: maxProductsToShow,
                  itemBuilder: (context, index) {
                    if (index < Productcontroller.products.length) {
                      final product = Productcontroller.products[index];
                      return productcard1(
                        id: product.id,
                        title: product.Title,
                        description: product.Description,
                        oprice: product.oprice,
                        nprice: product.nprice,
                        discount: product.discount,
                        quantity: product.Quantity,
                        imagePath: product.imagepath,
                        variationid: product.variationid,
                        colors: product.colors,
                      );
                    } else if (index == Productcontroller.products.length) {
                      // Display a "Load More" button when reaching the end
                      return Container(
                        width: size.width/2,
                        height: size.height * 0.39,
                        alignment: Alignment.center,
                        // padding: EdgeInsets.only(
                        //     left: 10, right: 10, top: size.height*0.15, bottom: size.height*0.15),
                        // child: ElevatedButton(
                        //   style: ButtonStyle(
                        //     backgroundColor: MaterialStateProperty.all(Color(
                        //         0xC7412020))
                        //   ),
                        //   onPressed: loadMoreProducts,
                          child: Text('Load More..',style: GoogleFonts.plusJakartaSans(
                          fontWeight: FontWeight.w500,
                          )
                              .copyWith(
                            color: Color(0xC7412020),
                             fontWeight: FontWeight.bold,
                            fontSize: 13

                          )),
                        // ),
                      );
                    } else {
                      // Return an empty container for indices greater than the product count
                      return Container();
                    }
                  },
                ),
              );
            }
          });
        });
  }
}
