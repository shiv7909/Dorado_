import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:untitled1/VIEWS/2_body/2_body.dart';
import 'package:untitled1/VIEWS/pageeState_controller.dart';

import '../CONTROLLERS/Cart/Retriving_controllers/cart_items_retrive_controller.dart';
import '1_body/1_body.dart';
import '4_body/Bag_body.dart';
import '5_body/account_signout.dart';

import 'bottom_navigator.dart';

class Main_Homes_builder extends StatefulWidget {
  Main_Homes_builder({Key? key}) : super(key: key);

  @override
  State<Main_Homes_builder> createState() => _MainHomeState();
}

class _MainHomeState extends State<Main_Homes_builder> with AutomaticKeepAliveClientMixin {
  final PageState pageState = Get.put(PageState());
  final CartProductController cartProductController = Get.put(CartProductController());


  @override
  bool get wantKeepAlive => true;


//   void initState() {
//     super.initState();
//     // WidgetsBinding.instance.addPostFrameCallback((_) {
//     //   cartProductController.cartProducts.clear();
//   //    cartProductController.fetchProducts();
//   //   })
//   // ;
// }


    List<Widget> bodies = [
      body_1(),
      body_2(),
      BagBody(), // HomeScreen1(),
      SignOut(),
    ];

    @override
    Widget build(BuildContext context) {
      super.build(context);

      return SafeArea(
        child: Scaffold(
          body: Obx(() => bodies[pageState.page.value]),
          // bottomNavigationBar:CustomBottomNavigator()
          floatingActionButton: CustomBottomNavigator(),
        ),
      );
    }
  }

