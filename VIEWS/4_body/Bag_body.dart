import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import '../../CONTROLLERS/body3/Functionality_controllers/product_in_cart_incre_decre.dart';
import '../../CONTROLLERS/body3/Functionality_controllers/saved_for_later_controller.dart';
import '../../CONTROLLERS/body3/Retriving_controllers/cart_items_retrive_controller.dart';
import '../../CONTROLLERS/body3/Retriving_controllers/emptybag_icon_controller.dart';
import 'Bag/checck.dart';
import '../2_body/Widget_classes/featuring_panel.dart';
import '../2_body/Widget_classes/title_with_more_btn.dart';

import 'Bag/4_appbar.dart';
import 'Bag/Bag_item_product_card.dart';

class BagBody extends StatefulWidget {
  @override
  State<BagBody> createState() => _BodyState();
}

class _BodyState extends State<BagBody> {
  final Product_incre_decre_remo_cart_controller cartcontroller = Product_incre_decre_remo_cart_controller();
  final Cart_Emptybag_IconController cartIcon = Cart_Emptybag_IconController();
  final Saved_for_later save4later = Saved_for_later();

  String imageUrl = '';

  final CartProductController cartController = Get.put(CartProductController());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cartController.fetchProducts();
    });

    cartIcon.getCartIcon().then((cartIcon) {
      if (cartIcon != null) {
        setState(() {
          imageUrl = cartIcon.imageUrl;
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    //final cartController = Get.find<CartProductController>();

    Size size = MediaQuery.of(context).size;
    return RefreshIndicator(
        color: Colors.blue,
        displacement: 200,
        onRefresh: () async {
          cartController.fetchProducts(); // Refresh the data
        },
        child: Scaffold(
          backgroundColor: Color(0XFFCCEAE9),
          // backgroundColor: Color(0xffeae9e9),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                cart_icon_head(
                  nameString: 'Shopping bag',
                ),
                Container(
                  margin: EdgeInsets.only(top: 15, bottom: 5),
                  padding: const EdgeInsets.only(top: 3, left: 12),
                  child: Text(
                    "Bag items :",
                    style: GoogleFonts.plusJakartaSans(
                      fontWeight: FontWeight.w500,
                    ).copyWith(
                        color: Colors.black87,
                        fontWeight: FontWeight.bold,
                        fontSize: 12),
                    textAlign: TextAlign.center,
                  ),
                ),
                Obx(() {
                  if (cartController.isLoading.value) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.all(0),
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return ShimmerCartProductItem();
                        // return CircularProgressIndicator();
                      },
                    );
                  } else if (cartController.isCartEmpty.isTrue) {
                    // If cart is empty, display a message
                    return Center(
                      child: Container(
                        alignment: Alignment.center,
                        height: size.height * 0.40,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            if (imageUrl.isEmpty)
                              Icon(Icons.shopping_bag)
                            else
                              Image.network(imageUrl,
                                  height: size.height * 0.2),
                            Container(
                              margin: EdgeInsets.only(top: 15),
                              child: Text(
                                'Your cart is empty',
                                style: TextStyle(fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  } else {
                    // If data is loaded and cart is not empty, display cart products
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.all(0),
                      itemCount: cartController.cartProducts.length,
                      itemBuilder: (context, index) {
                        final cartProduct = cartController.cartProducts[index];
                        return CartProductItem(
                          cartProduct: cartProduct,
                          cartController: cartcontroller,
                          saveforlater: save4later,
                          level: 'bag',
                        );
                      },
                    );
                  }
                }),
                SizedBox(
                  height: 10,
                ),
                TitleWithMoreBtn(
                  title: 'Title2',
                  size: 15, position: 'CenterLeft', background: false,
                ),
                FeaturingPanel(),
                SizedBox(
                  height: size.height * 0.2,
                )
              ],
            ),
          ),
          bottomSheet: Obx(
            () => (!cartController.isCartEmpty.value &&
                    !cartcontroller.isCartEmpty.value)
                ? Container(
                    color: Colors.transparent,
                    padding: EdgeInsets.only(bottom: 16+55),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        GestureDetector(
                          onTap: () {
                            Get.to(() => Checkout());
                          },
                          child: Container(
                            alignment: Alignment.center,
                            width: size.width * 0.7,
                            height: 42,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Color(0xFF2D0C0C),
                                boxShadow: [
                                  BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 1,
                                      offset: Offset(0, 1))
                                ]),
                            child: Text(
                              'Checkout',
                              style: Theme.of(context)
                                  .textTheme
                                  .displayMedium
                                  ?.copyWith(
                                    fontSize: 13.5,
                                    fontFamily: "light1",
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                  ),
                            ),
                          ),
                        ),
                        // SizedBox(height: 35,)
                      ],
                    ),
                  )
                : SizedBox.shrink(),
          ),
        ));
  }
}

class ShimmerCartProductItem extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;

    return Shimmer.fromColors(
      baseColor: Colors.grey[350]!, // Adjust the base and highlight colors
      highlightColor: Colors.grey[100]!,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(15)),
        ),
        margin: EdgeInsets.only(bottom: 5, top: 8),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Column(
              children: [
                Container(
                  margin: EdgeInsets.symmetric(vertical: 20, horizontal: 10),
                  height: size.height * 0.12,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: Container(
                      width: size.width * 0.2,
                      height: size.height * 0.12,
                      color: Colors.grey[100], // Shimmer placeholder color
                    ),
                  ),
                ),
              ],
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Container(
                    margin: EdgeInsets.only(bottom: 4, top: 20),
                    width: size.width / 2,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      color: Colors.grey[100],
                    ),
                    height: 20,
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 4, top: 4, right: 20),
                    height: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      color: Colors.grey[100],
                    ), // Shimmer placeholder color
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 4, top: 4, right: 20),
                    width: size.width / 2,
                    height: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      color: Colors.grey[100],
                    ), // Shimmer placeholder color
                  ),
                  Container(
                    margin: EdgeInsets.only(bottom: 4, top: 4, right: 20),
                    width: size.width / 2,
                    height: 20,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(
                        Radius.circular(10),
                      ),
                      color: Colors.grey[100],
                    ), // Shimmer placeholder color
                  ),
                  Container(
                    margin: EdgeInsets.only(top: 5, bottom: 5),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Container(
                          margin: EdgeInsets.only(
                              right: 8, left: 10, top: 10, bottom: 10),
                          width: size.width * 0.07,
                          height: size.height * 0.02,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: CircleBorder(),
                              padding: EdgeInsets.all(0),
                              foregroundColor: Colors.white,
                              backgroundColor:
                                  Colors.grey[100], // Shimmer placeholder color
                            ),
                            child: Icon(
                              Icons.remove,
                              size: 15,
                            ),
                            onPressed: () {},
                          ),
                        ),
                        Text(
                          '0', // Placeholder quantity
                          style: TextStyle(
                            fontSize: 13,
                          ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              right: 10, left: 8, top: 10, bottom: 10),
                          width: size.width * 0.07,
                          height: size.height * 0.02,
                          child: ElevatedButton(
                            style: ElevatedButton.styleFrom(
                              shape: CircleBorder(),
                              foregroundColor: Colors.white,
                              backgroundColor:
                                  Colors.grey[100], // Shimmer placeholder color
                              padding: EdgeInsets.all(0),
                            ),
                            child: Icon(
                              Icons.add,
                              size: 15,
                            ),
                            onPressed: () {},
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}




