import 'dart:async';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../../CONTROLLERS/body1/Sliders_images_controller.dart';
import '../../2_body/Product_ramp_grid_BODY.dart';



class HomeCarouselSlider1 extends StatefulWidget {
  const HomeCarouselSlider1({Key? key}) : super(key: key);
  @override
  _MyCarouselSliderState createState() => _MyCarouselSliderState();
}


class _MyCarouselSliderState extends State<HomeCarouselSlider1> {
  int _currentIndex = 0;
  Sliders_images carouselcontroller1 = Get.put(Sliders_images());

  Timer? _timer;
  @override
  void initState() {
    super.initState();

    carouselcontroller1.fetchImageUrls('Carousel_Slider',"Carousel_Slider");
    setState(() {});

    _timer = Timer.periodic(Duration(seconds: 3), (timer) {
      final int newIndex = (_currentIndex + 1) % carouselcontroller1.imageUrlsMap["Carousel_Slider"]!.length;
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

    if(carouselcontroller1.imageUrlsMap["Carousel_Slider"]!= null) {
      return
        GestureDetector(
          onTap: (){
            Get.to(()=>Grid_show(title: "Carousel1",));
          },
          child: Container(
            height: size.height * 0.2,
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors:
                    [
                      Color(0XFFCCEAE6),
                      Color(0XFFCCEAE6),
                      Colors.white,
                    ]
                  //colors: [Colors.white, Colors.white],
                )
            ),
            child: Stack(
              children: [
                CarouselSlider(
                  items: carouselcontroller1.imageUrlsMap["Carousel_Slider"]!
                      .map((image_url) {
                    return GestureDetector(
                      onTap: () {},
                      child: Stack(
                        children: [
                          Container(
                            height: size.height * 0.2,
                            margin: EdgeInsets.all(15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(9),
                              image: DecorationImage(
                                image: NetworkImage(image_url),
                                fit: BoxFit.cover,
                              ),
                              // boxShadow: [
                              //   BoxShadow(
                              //     color: Colors.black45,
                              //     spreadRadius: 1,
                              //     blurRadius: 7,
                              //     offset: Offset(0,4)
                              //   )
                              // ]
                            ),
                          ),
                        ],
                      ),
                    );
                  }).toList(),
                  options: CarouselOptions(
                    enlargeCenterPage: false,
                    height: size.height * 0.2,
                    viewportFraction: 1,
                    enableInfiniteScroll: true,
                    onPageChanged: (index, reason) {
                      setState(() {
                        _currentIndex = index;
                      });
                    },
                    autoPlay: true,
                    autoPlayInterval: Duration(seconds: 3),
                    autoPlayAnimationDuration: Duration(milliseconds: 800),
                    autoPlayCurve: Curves.fastOutSlowIn,
                  ),
                ),
                Container(
                  color: Colors.transparent,
                  height: size.height * 0.2,
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: List.generate(
                      carouselcontroller1.imageUrlsMap["Carousel_Slider"]!.length,
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
          ),
        );
    }

    else return  Container(
    height: size.height * 0.1,
    margin: EdgeInsets.all(15),
    decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(9),
    ),
    child: Center(
    child: CircularProgressIndicator(color: Colors.black54,strokeWidth: 3.3,),
    ),
    );

  }
}
