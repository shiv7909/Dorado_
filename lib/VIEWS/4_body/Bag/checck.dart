import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:lottie/lottie.dart';
import 'package:shimmer/shimmer.dart';
import '../../../CONTROLLERS/Cart/Functionality_controllers/product_in_cart_incre_decre.dart';
import '../../../CONTROLLERS/Cart/Functionality_controllers/saved_for_later_controller.dart';
import '../../../CONTROLLERS/Cart/Retriving_controllers/cart_items_retrive_controller.dart';
import '../../../CONTROLLERS/Cart/Retriving_controllers/emptybag_icon_controller.dart';
import '../../../CONTROLLERS/user_address_controller/Addadress_controller.dart';
import 'Bag_item_product_card.dart';
import 'addressWidget.dart';




class Checkout extends StatefulWidget {
  const Checkout({super.key});

  @override
  State<Checkout> createState() => _CheckoutState();
}

class _CheckoutState extends State<Checkout> {



  final CartIconController cartIcon = CartIconController();
  final Saved_for_later save4later = Saved_for_later();
  final Product_incre_decre_remo_cart_controller cartcontroller =
  Product_incre_decre_remo_cart_controller();

  final latestaddress = Get.find<AddAddressController>();


  final cartController = Get.find<CartProductController>();



  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      cartController.fetchProducts();
    });
  }

    @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;


    var oprice=0;

    return SafeArea(
      child: Scaffold(
      //  appBar: cart_icon_head(levelString: 'checkout', nameString: 'checkout',),
        // appBar: AppBar(
        //   leading: Container(
        //     margin: EdgeInsets.only(left: 20),
        //       alignment:Alignment.center,child: Text("Back",
        //       style: GoogleFonts.plusJakartaSans(
        //           fontWeight: FontWeight.w500,
        //           )
        //           .copyWith(
        //           color: Colors.black54,
        //           fontWeight: FontWeight.w600,
        //
        //       )
        //
        //   )),
        // ),
        appBar: AppBar(),
        body: SingleChildScrollView(
          child: Column(
            children: [

              Container(
                  padding: EdgeInsets.only(left: 30,right: 30,top: 5,bottom: 5),
                  child: Lottie.asset("assists/images/delivery main 1.json")),
             ADDRESS(),




          GestureDetector(
            onTap: (){
              print(cartController.toatl_after_cost);
              print(cartController.toatl_origi_cost);
            },
            child: Container(
              alignment: Alignment.centerLeft,
              margin: EdgeInsets.only(top: 15,left: 20),
              child: Text("Order Summary :",
                style: GoogleFonts.plusJakartaSans(
                    color: Colors.black.withOpacity(0.8),
                    fontWeight: FontWeight.w800,
                    fontSize: 14),
                // style:
                // Theme.of(context)
                //     .textTheme
                //     .displaySmall
                //     ?.copyWith(fontSize: 14,fontWeight: FontWeight.w600,),
              ),
            ),
          ),

              Container(
                padding: EdgeInsets.only(left: 8, right: 15, bottom: 15, top: 10),
                margin: EdgeInsets.only(top: 15,left: 10,right: 10),
                height: 100,
                width: size.width,
                decoration: BoxDecoration(
                  shape: BoxShape.rectangle,
                  borderRadius: BorderRadius.circular(30),
                  color:  Color(0x8E4AB4F6),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Sub Total:${cartController.toatl_origi_cost.value}")
                  ],
                ),
              ),




              if (latestaddress.addressList.isNotEmpty)
                Padding(
                padding: const EdgeInsets.only(top: 12,bottom: 10),
                child: ElevatedButton(onPressed: (){}, child: Text("Proceed to pay",style:GoogleFonts.plusJakartaSans(color:Colors.white,
                    fontWeight: FontWeight.w600,fontSize:12
                ),),style: ButtonStyle(
                  backgroundColor: MaterialStateProperty.all(Colors.blue),
                ),),
              ),




              Obx(() {
                if (cartController.isLoading.value==true) {
                  return ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    padding: EdgeInsets.all(0),
                    itemCount: 3,
                    itemBuilder: (context, index) {
                      return ShimmerCartProductItem();
                    },
                  );
                } else {
                  return Column(
                    children: [
                      Container(
                        alignment: Alignment.centerLeft,
                        margin: EdgeInsets.only(top: 10,left: 20),
                        child: Text("Items :",
                          style: GoogleFonts.plusJakartaSans(
                              color: Colors.black.withOpacity(0.7),
                              fontWeight: FontWeight.w800,
                              fontSize: 13),
                        ),
                      ),
                      ListView.builder(
                        shrinkWrap: true,
                        physics: NeverScrollableScrollPhysics(),
                        padding: EdgeInsets.all(0),
                        itemCount: cartController.cartProducts.length,
                        itemBuilder: (context, index) {
                          final cartProduct = cartController.cartProducts[index];
                           oprice=oprice+cartController.cartProducts[0].oprice;
                          return CartProductItem(
                            cartProduct: cartProduct,
                            cartController: cartcontroller,
                            saveforlater: save4later,
                            level: 'checkout',
                          );
                        },
                      ),
                    ],
                  );
                }
              }),
            ],
          ),
        ),
      ),
    );
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
                  // Container(
                  //   margin: EdgeInsets.only(bottom: 4, top: 4, right: 20),
                  //   width: size.width / 2,
                  //   height: 20,
                  //   decoration: BoxDecoration(
                  //     borderRadius: BorderRadius.all(
                  //       Radius.circular(10),
                  //     ),
                  //     color: Colors.grey[100],
                  //   ), // Shimmer placeholder color
                  // ),
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
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
