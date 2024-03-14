import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:untitled1/mainpeoductController.dart';

import '../../../mainproductpage.dart';

class Home_slider extends StatefulWidget {
  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<Home_slider> {
  late PageController pageController;
  double pageOffset = 0;

  @override
  void initState() {
    super.initState();
    pageController = PageController(viewportFraction: 0.7);
    pageController.addListener(() {
      setState(() {
        pageOffset = pageController.page!;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Container(
      // margin: EdgeInsets.only(bottom: 8),
      width: MediaQuery.of(context).size.width,
      decoration: BoxDecoration(),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                height: size.height * 0.35,
                // padding: EdgeInsets.only(bottom: size.height*0.01),
                // decoration: BoxDecoration(
                //   gradient: LinearGradient(
                //       begin: Alignment.topCenter,
                //       end: Alignment.bottomCenter,
                //       colors:
                //       [
                //         // Colors.white,
                //         // Colors.brown.withOpacity(0.2),
                //         // Colors.brown.withOpacity(0.2),
                //         // Colors.brown.withOpacity(0.2),
                //          Color(0XFFCCEAE6),
                //         Colors.white,
                //         Colors.white,
                //       ]
                //     //colors: [Colors.white, Colors.white],
                //   ),
                // ),
                child: PageView.builder(
                    itemCount: paintings.length,
                    controller: pageController,
                    itemBuilder: (context, i) {
                      return Transform.scale(
                        scale: 1,
                        child: Container(
                          padding: EdgeInsets.only(right: 20),
                          child: Column(
                            children: [

                             ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: GestureDetector(
                                    onTap: (){
                                      Get.to(()=>ProductDisplayScreen(id:paintings[i]["id"], varid: paintings[i]["variationId"],));
                                    },
                                    child: Image.asset(
                                      paintings[i]['image'],
                                      height: size.height * 0.35,
                                      width: size.width * 0.7,
                                      fit: BoxFit.cover,
                                      alignment:
                                          Alignment(-pageOffset.abs() + i, 0),

                                                                    ),
                                  ),
                              ),
                            ],
                          ),
                        ),
                      );
                    }),
              )
            ],
          ),
          Container(
            alignment: Alignment.centerRight,
            height: size.height * 0.06,
            width: size.width,
            color: Colors.black,
            padding: EdgeInsets.only(right: 15, top: 4, bottom: 4),
            child: Text(
              // paintings[i]['name'],
              'SHOP COLLECTION',
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.bold),
            ),
          ),
        ],
      ),
    );
  }
}



List<Map> paintings = [
  {
    'image': 'assists/images/IMG-20240310-WA0001.jpg',
    'id':'1-23-001-04',
    "variationId":"variation1",

  },

  {
    'image': 'assists/images/22.png',
    'id':'1-23-001-04',
    "variationId":"variation1",
  },

  {
    'image': 'assists/images/333.png',
    'id':'1-23-001-04',
    "variationId":"variation1",
  },
  {
    'image': 'assists/images/44.png',
    'id':'1-23-001-04',
    "variationId":"variation1",
  },
  {
    'image': 'assists/images/55.png',
    'id':'1-23-001-04',
    "variationId":"variation1",
  },
];
