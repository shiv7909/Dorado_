import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled1/CONTROLLERS/body1/Bannerscontroller.dart';
import '../../CONTROLLERS/body2/Categories_navigation.dart';
import '../../CONTROLLERS/body2/product_retriving/product_controller.dart';
import 'Widget_classes/Animated_slider.dart';
import 'Widget_classes/AppBar2.dart';
import 'Widget_classes/Banner.dart';
import 'Widget_classes/Slider.dart';
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
            },
            child: SingleChildScrollView(
           //   physics: const BouncingScrollPhysics(),
              child: Column(
                children: <Widget>[
                  // VideoPlayerScreen(),
                  HomeCarouselSlider2(),
                  impnavi_head(),
                  imp_navi_panel(),
                  TitleWithMoreBtn( title: 'Title1', size: 13, position: 'CenterLeft', background: false,),
                  FeaturingPanel(),
                  TitleWithMoreBtn( title: 'Title2', size: 13, position: 'CenterLeft', background: false,),
                  FeaturingPanel(),
                  BANNERS( background: true, bannerPic: 'banner1', BannerList: 'Banner_1_List',),
                  BANNERS(background: false, bannerPic: 'banner2', BannerList: 'Banner_2_List',),
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

