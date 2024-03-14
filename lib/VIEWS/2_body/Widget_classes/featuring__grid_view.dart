



import 'dart:math';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import 'package:untitled1/VIEWS/2_body/Widget_classes/productcard1.dart';
import '../../../CONTROLLERS/product_card/Retriving_controllers/product_controller.dart';


import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';



import 'package:dynamic_height_grid_view/dynamic_height_grid_view.dart';

class FeaturingPanel1 extends StatefulWidget {
  @override
  State<FeaturingPanel1> createState() => _FeaturingPanelState();
}

class _FeaturingPanelState extends State<FeaturingPanel1> {
  final Productcontroller = Get.find<ProductController>();

  int maxProductsToShow = 20;
  String quote = '';

  bool loadingMore = false; // Flag to track loading more products

  void loadMoreProducts() {
    setState(() {
      loadingMore = true; // Set loading flag to true
    });

    // Fetch more products from Firebase
    Productcontroller.fetchProductsFromPanel('Featuring_panel').then((_) {
      setState(() {
        loadingMore = false; // Set loading flag to false after fetching
      });
    });
  }

  Widget buildShimmerPlaceholder(Size size) {
    return Shimmer.fromColors(
      baseColor: Colors.grey[300]!, // Adjust the base and highlight colors
      highlightColor: Colors.grey[100]!,
      child: DynamicHeightGridView(
        crossAxisCount: 2,
        crossAxisSpacing: 10,
        mainAxisSpacing: 10,
        itemCount: maxProductsToShow,
        builder: (context, index) {
          return Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              color: Colors.white,
            ),
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Obx(() {
      if (Productcontroller.isLoading.value) {
        return buildShimmerPlaceholder(size);
      } else if (Productcontroller.products.isEmpty) {
        return Container(
          alignment: Alignment.center,
          height: size.height * 0.4,
          child: Text('Loading'),
        );
      } else {
        return DynamicHeightGridView(
          crossAxisCount: 2,
          crossAxisSpacing: 10,
          mainAxisSpacing: 10,
          itemCount: Productcontroller.products.length,
          builder: (context, index) {
            final product = Productcontroller.products[index];
            return Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(10),
                color: Colors.orange,
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
        );
      }
    });
  }
}
