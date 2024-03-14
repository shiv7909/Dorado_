
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:shimmer/shimmer.dart';
import '../../CONTROLLERS/body3/Functionality_controllers/product_in_cart_incre_decre.dart';
import '../../CONTROLLERS/body3/Functionality_controllers/saved_for_later_controller.dart';
import '../../CONTROLLERS/body3/Retriving_controllers/FavoRetrive.dart';
import 'Bag/4_appbar.dart';
import 'Bag/Bag_item_product_card.dart';



class Fav_Body extends StatefulWidget {
  @override
  State<Fav_Body> createState() => _BodyState();
}

class _BodyState extends State<Fav_Body> {
  final Product_incre_decre_remo_cart_controller cartcontroller = Product_incre_decre_remo_cart_controller();
  final Saved_for_later save4later = Saved_for_later();
  final Fav_Retrive_Controller Fav_pro_Controller = Get.put(Fav_Retrive_Controller());

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      Fav_pro_Controller.fetchProducts();
    });

  }

  @override
  Widget build(BuildContext context) {


    Size size = MediaQuery.of(context).size;
    return RefreshIndicator(
        color: Colors.blue,
        displacement: 200,
        onRefresh: () async {
          Fav_pro_Controller.fetchProducts(); // Refresh the data
        },
        child: Scaffold(
          backgroundColor: Color(0XFFCCEAE9),
          // backgroundColor: Color(0xffeae9e9),
          body: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: <Widget>[
                cart_icon_head(
                  nameString: 'Favourite Items',
                ),

                Obx(() {
                  if (Fav_pro_Controller.isLoading.value) {
                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.all(0),
                      itemCount: 3,
                      itemBuilder: (context, index) {
                        return ShimmerCartProductItem();
                      },
                    );
                  } else if (Fav_pro_Controller.isCartEmpty.isTrue) {
                    // If cart is empty, display a message
                    return Center(
                      child: Container(
                        alignment: Alignment.center,
                        height: size.height * 0.40,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [

                              Icon(Icons.shopping_bag),

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

                    return ListView.builder(
                      shrinkWrap: true,
                      physics: NeverScrollableScrollPhysics(),
                      padding: EdgeInsets.all(0),
                      itemCount: Fav_pro_Controller.FavProducts.length,
                      itemBuilder: (context, index) {
                        final FavProduct = Fav_pro_Controller.FavProducts[index];
                        return CartProductItem(
                          cartProduct: FavProduct,
                          cartController: cartcontroller,
                         saveforlater: save4later,
                          level: 'bag',
                        );
                      },
                    );
                  }
                }),
                Container(
                  height: 300,
                  color: Colors.orange,
                )
          ])
        )));
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
