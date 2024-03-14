
import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../CONTROLLERS/body1/Sliders_images_controller.dart';




class HomeCarouselSlider2 extends StatefulWidget {
  const HomeCarouselSlider2({Key? key}) : super(key: key);
  @override
  _MyCarouselSliderState createState() => _MyCarouselSliderState();
}

class _MyCarouselSliderState extends State<HomeCarouselSlider2> {
  int _currentIndex = 0;
  Sliders_images carouselcontroller2 = Get.put(Sliders_images());
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    carouselcontroller2.fetchImageUrls('Carousel_Slider_2',"Carousel_Slider_2");
    setState(() {});
    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      final int newIndex = (_currentIndex + 1) % carouselcontroller2.imageUrlsMap["Carousel_Slider_2"]!.length;
      setState(() {
        _currentIndex = newIndex;
      });
    });
  }


  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }


  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    if(carouselcontroller2.imageUrlsMap["Carousel_Slider_2"]!= null) {
      return
        Container(
          height: size.height * 0.1,

          color: Color(0XFFCCEAE6),

          child: Stack(
            children: [
              CarouselSlider(
                items: carouselcontroller2.imageUrlsMap["Carousel_Slider_2"]!
                    .map((image_url) {
                  return GestureDetector(
                    onTap: () {},
                    child: Stack(
                      children: [
                        Container(
                          height: size.height * 0.1,
                          margin: EdgeInsets.all(15),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(9),
                          ),
                          child: CachedNetworkImage(
                            imageUrl: image_url,
                            fit: BoxFit.cover,
                          ),
                        ),
                      ],
                    ),
                  );
                }).toList(),
                options: CarouselOptions(
                  enlargeCenterPage: false,
                  height: size.height * 0.1,
                  viewportFraction: 1,
                  enableInfiniteScroll: true,
                  onPageChanged: (index, reason) {
                    setState(() {
                      _currentIndex = index;
                    });
                  },
                  autoPlay: true,
                  autoPlayInterval: Duration(seconds: 80),
                  autoPlayAnimationDuration: Duration(seconds: 1),
                  autoPlayCurve: Curves.fastOutSlowIn,
                ),
              ),
              Container(
                color: Colors.transparent,
                height: size.height * 0.1,
                alignment: Alignment.bottomCenter,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    carouselcontroller2.imageUrlsMap["Carousel_Slider_2"]!
                        .length,
                        (index) =>
                        Container(
                          padding: EdgeInsets.only(bottom: 5),
                          margin: EdgeInsets.all(1),
                          child: Icon(
                            Icons.circle,
                            size: 5.0,
                            color: _currentIndex == index
                                ? Colors.black
                                : Colors.grey,
                          ),
                        ),
                  ),
                ),
              ),
            ],
          ),
        );
    }
    else return  Container( padding: EdgeInsets.all(10),
      height: size.height * 0.1,
      margin: EdgeInsets.all(15),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(9),
        color: Color(0XFFCCEAE6),

      ),
      child: Center(
        child: CircularProgressIndicator(color: Colors.black54,strokeWidth: 3.3,),
      ),
    );
  }
}
