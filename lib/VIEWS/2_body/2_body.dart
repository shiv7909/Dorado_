import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled1/CONTROLLERS/Bannerscontroller.dart';
import '../../CONTROLLERS/Navigation_panels/Navigation_1_controller.dart';
import '../../CONTROLLERS/appleStyle_Controller.dart';
import '../../CONTROLLERS/product_card/Retriving_controllers/product_controller.dart';
import '../1_body/Widget_classes/appleStyle.dart';
import 'Widget_classes/AppBar2.dart';
import 'Widget_classes/announcement1.dart';
import 'Widget_classes/featuring_panel.dart';
import 'Widget_classes/imp_navi_panel.dart';
import 'Widget_classes/impnavibar_heading.dart';
import 'Widget_classes/title_with_more_btn.dart';


class body_2 extends StatefulWidget {
  @override
  State<body_2> createState() => _body_2State();
}

class _body_2State extends State<body_2> with AutomaticKeepAliveClientMixin<body_2> {

  final productController=Get.find<ProductController>();
  final _navigationController=Get.find<NavigationController>();
  final bannerController=Get.put(bannerUrl());
  final Apple_slider=Get.put(ImageUrlController());


  @override
  bool get wantKeepAlive => true;

  // void init(){
  //   productController.fetchProductsFromPanel('Featuring_panel');
  //   _navigationController.fetchNavigationItems();
  // }
    @override
    Widget build(BuildContext context) {

      super.build(context);

      return
        Scaffold(
          appBar: Appbar2(),
          body: RefreshIndicator(
            color: Colors.blue,
            displacement: 50,
            onRefresh: () async {
              productController.fetchProductsFromPanel('Featuring_panel');
              _navigationController.fetchNavigationItems();
              bannerController.getCurrentImageUrl('banner1');
              Apple_slider.fetchImageUrls();



            },
            child: SingleChildScrollView(
           //   physics: const BouncingScrollPhysics(),
              child: Column(
                children: <Widget>[
                  // VideoPlayerScreen(),
                  impnavi_head(),
                  imp_navi_panel(),
                  TitleWithMoreBtn( title: 'Title1', size: 13, position: 'CenterLeft', background: false,),
                  FeaturingPanel(),
                  TitleWithMoreBtn( title: 'Title2', size: 13, position: 'CenterLeft', background: false,),
                  FeaturingPanel(),
                  Announcement(banner: "banner1", background: true,),
                  Announcement(banner: "banner2", background: false,),
                  SizedBox(height: 15,),
                  TitleWithMoreBtn( title: 'Title3', size: 13, position: 'Center', background: false,),
                  Homeslider(),
                  SizedBox(height: 15,),
                  TitleWithMoreBtn( title: 'Title4', size: 13, position: 'CenterLeft', background: false,),
                  FeaturingPanel(),
                ],
              ),
            ),
                ),
        );
    }
  }

