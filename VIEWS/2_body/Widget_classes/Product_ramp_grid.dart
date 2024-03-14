import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:untitled1/VIEWS/2_body/Widget_classes/productcard1.dart';
import '../../../CONTROLLERS/body2/product_retriving/product_controller.dart';
import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';

class Product_ramp extends StatefulWidget {
  Product_ramp({super.key, required this.panel});
  final String panel;

  @override
  State<Product_ramp> createState() => _FeaturingPanelState();
}

class _FeaturingPanelState extends State<Product_ramp> {
  final ProductController productController = ProductController();

  int maxProductsToShow = 20;
  String quote = '';

  bool loadingMore = false; // Flag to track loading more products

  Future<void> loadProducts() async {
      await productController.fetchProductsFromPanel(widget.panel);
  }



  Widget buildShimmerPlaceholder(Size size) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!, // Adjust the base and highlight colors
      highlightColor: Colors.grey[100]!,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.all(20),
            height: 40,
            width: size.width-20,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              color: Colors.grey.withOpacity(0.3),
            ),
          ),
          Expanded(
            child: DynamicHeightGridView(
              crossAxisCount: 2,
              crossAxisSpacing: 0,
              mainAxisSpacing: 10,
              itemCount: maxProductsToShow,
              builder: (context, index) {
                return Container(
            
                  margin: EdgeInsets.only(left: 5,right: 5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(10),
                    color: Colors.grey.withOpacity(0.5)
                  ),
                  height: size.height * 0.28,
                  width: size.width/2
            
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return FutureBuilder<void>(
      future: loadProducts(), // Await the loading of products
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return buildShimmerPlaceholder(size); // Show shimmer placeholder while loading
        } else if (snapshot.hasError) {
          return Center(child: Text('Error loading products'));
        } else {
          // Check if products are available
          if (productController.products.isEmpty) {
            return Center(child: Text('No products available'));
          } else {
            return
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                   Container(
                     margin: EdgeInsets.only(left: 10,top: 10,bottom: 10),
                     child:Stack(
                       children: [
                         Container(
                           width: size.width,
                           alignment: Alignment.centerLeft,
                           child: GestureDetector(
                             onTap: (){
                               Get.back();
                             },
                             child: Padding(
                               padding: const EdgeInsets.only(left: 20),
                               child: Icon(Icons.arrow_back_ios_outlined,size: 18,color: Colors.black87,),
                             ),
                           ),
                         ),
                         Container(
                           width: size.width,
                           alignment: Alignment.center,
                           child: Text(productController.Heading.value,style: GoogleFonts.plusJakartaSans(
                             fontWeight: FontWeight.bold,
                                                ).copyWith(
                               color: Colors.black.withOpacity(0.6),
                               fontSize: 15)),
                         ),
                       ],
                     ),
                   height: 50,
                   ),



                    Expanded(
                      child: DynamicHeightGridView(
                        crossAxisCount: 2,
                        crossAxisSpacing: 10,
                        mainAxisSpacing: 10,
                        itemCount: productController.products.length,
                        builder: (context, index) {
                          final product = productController.products[index];
                          return Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            height: size.height * 0.39,
                            child: productcard1(
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
                            ),
                          );
                        },
                                  ),
                    ),
                  ],
                );
          }
        }
      },
    );
  }
}
