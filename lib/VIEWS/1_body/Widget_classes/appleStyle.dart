import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../CONTROLLERS/appleStyle_Controller.dart';





class Homeslider extends StatefulWidget {
  @override
  _HomeSliderState createState() => _HomeSliderState();
}


class _HomeSliderState extends State<Homeslider> {
  late PageController pageController;
  double currentPageValue = 0;


  final apple_slider_controller=Get.put(ImageUrlController());

  @override
  void initState() {
    super.initState();
    pageController = PageController(viewportFraction: 0.5);
    pageController.addListener(() {
      setState(() {
        currentPageValue = pageController.page!;
      });
    });
    fetchImageUrlsAndBuildUI(); // Call method to fetch image URLs and build UI
  }

  Future<void> fetchImageUrlsAndBuildUI() async {
    await apple_slider_controller.fetchImageUrls(); // Wait for image URLs to be fetched
    setState(() {}); // Trigger rebuild of widget tree after fetching is complete
  }


  @override
  Widget build(BuildContext context) {
    return Container(
      height: 210, // Adjust the height as needed
      child: PageView.builder(
        controller: pageController,
        itemCount: apple_slider_controller.imageUrls.length,
        itemBuilder: (BuildContext context, int index) {
          return AnimatedBuilder(
            animation: pageController,
            builder: (context, child) {
              double value = 0.9;
              if (pageController.position.haveDimensions) {
                value = pageController.page! - index;
                value = (1 - (value.abs() * 0.5)).clamp(0.0, 1.0);
              }
              return Center(
                child: SizedBox(
                  height: Curves.easeInOut.transform(value) * 200,
                  width: Curves.easeInOut.transform(value) * 600,
                  child: child,
                ),
              );
            },
            child: Obx(() {
              return
                _buildPageItem(apple_slider_controller.imageUrls[index]);
            }
            ),
          );
        },
      ),
    );
  }

  Widget _buildPageItem(String imageUrl) {
    return Container(
      margin: EdgeInsets.symmetric(horizontal: 5.0),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.grey[300],
      ),
      child: GestureDetector(
        onTap: (){
          // Handle onTap event
        },
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15.0),
          child: CachedNetworkImage(
            imageUrl:
              imageUrl,
              fit: BoxFit.cover,
            ),
          ),

      ),
    );
  }
}

