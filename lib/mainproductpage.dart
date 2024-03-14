import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:shimmer/shimmer.dart';
import 'package:untitled1/virtualTryOnPage.dart';

import 'CONTROLLERS/Cart/Retriving_controllers/cart_items_retrive_controller.dart';
import 'CONTROLLERS/product_card/Functionality_controllers/ADD_Favourites_controller.dart';
import 'CONTROLLERS/product_card/Functionality_controllers/product_Add_in_cart_controller.dart';
import 'MODELS/constants.dart';
import 'VIEWS/MainHome.dart';
import 'VIEWS/fullimage.dart';
import 'VIEWS/pageeState_controller.dart';
import 'mainpeoductController.dart';



//Get.to(()=>ProductDisplayScreen(id:paintings[i]["id"], varid: paintings[i]["variationId"],));

class ProductDisplayScreen extends StatefulWidget {
  ProductDisplayScreen({
    required this.id,
    required this.varid,
  });
  final String id;
  final String varid;

  @override
  State<ProductDisplayScreen> createState() => _ProductDisplayScreenState();
}

class _ProductDisplayScreenState extends State<ProductDisplayScreen> {
  final ParticularProductController controller = Get.put(ParticularProductController());
  final PageController _pageController = PageController();
  ScrollController _scrollController = ScrollController();

  int _currentPage = 0;
  bool isPressed1 = false;
  bool isPressed2 = false;

  int selectedSizeIndex = -1;

  final Product_Add_controller product_Add_to_cart_controller = Product_Add_controller();
  final CartProductController cartProductController = Get.put(CartProductController());
  final FavouritesController Fav = Get.put(FavouritesController());


  @override
  void dispose() {
    _scrollController.dispose();
    _pageController.dispose();

    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    super.dispose();

  }

  @override
  void initState() {
    super.initState();
    _fetchProducts();
  }

  Future<void> _fetchProducts() async {
    try {

      await controller.findProductDocument(widget.id, widget.varid);
    } catch (e) {

      print('Error fetching products: $e');
    }
  }

  Color _getColorFromHex(String hexColor) {
    final buffer = StringBuffer();
    buffer.write(hexColor.replaceFirst('0x', ''));
    if (buffer.length == 6) buffer.write('FF'); // Adding alpha if it's missing
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  void SnackBar1(Size size) {
    ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
      backgroundColor: Colors.brown,
      content: Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    "Successfully added to cart    ",
                    style: TextStyle(
                        fontWeight: FontWeight.bold, color: Colors.white),
                  ),
                  Icon(
                    Icons.verified,
                    color: Colors.white,
                  )
                ],
              ),
            ),
      behavior: SnackBarBehavior.floating,
      elevation: 1,
      duration: Duration(milliseconds: 400),
          margin: EdgeInsets.only(bottom: size.height/2),
    ));
  }


  void navigateToProductDisplayScreen(String id) async {
    await Get.off(() => ProductDisplayScreen(id: widget.id, varid: id));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    final pageState = Get.find<PageState>();

    return SafeArea(
      child: Scaffold(
          body: SingleChildScrollView(
            child: Stack(
                children: [
              // FloatingActionButton(onPressed: (){},
              //   child: Icon(Icons.favorite_border_sharp),
              // ),
              Obx(
                () {
                  if (controller.isLoading.value) {
                    return
                      Center(
                        child: Shimmer.fromColors(
                      baseColor: Colors.grey[500]!,
                      // Adjust the base and highlight colors
                      highlightColor: Colors.black,
                      child: Container(
                        margin: EdgeInsets.only(left: 30, right: 30),
                        alignment: Alignment.center,
                        child: Text(
                          'LOADING ...',
                          style: TextStyle(
                            fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54),
                          maxLines: 2,
                        ),
                      ),
                    ));
                  } else if (controller.hasError.value) {
                    return Center(child: Text('Error fetching data'));
                  } else if (controller.products.isEmpty ||
                      controller.products[0].images.isEmpty) {
                    return Center(
                        child: Shimmer.fromColors(
                      baseColor: Colors.grey[500]!,
                      // Adjust the base and highlight colors
                      highlightColor: Colors.black,
                      child: Container(
                        margin: EdgeInsets.only(
                            left: 30, right: 30, top: size.height / 2),
                        alignment: Alignment.center,
                        child: Text(
                          'LOADING ...',
                          style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black54),
                          maxLines: 2,
                        ),
                      ),
                    ));
                  } else {
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // GestureDetector(
                        //   child:
                        // Padding(
                        //   padding: const EdgeInsets.all(8.0),
                        //   child: Row(
                        //     mainAxisAlignment: MainAxisAlignment.start,
                        //     children: [
                        //       Positioned(
                        //           top: 15,
                        //           left: 15,
                        //           child:
                        //
                        //
                        //       GestureDetector(
                        //         onTap: (){
                        //           Get.back();
                        //         },
                        //         child: Container(
                        //           alignment: Alignment.center,
                        //           padding: EdgeInsets.all(3),
                        //           decoration:BoxDecoration(
                        //               borderRadius: BorderRadius.circular(8),
                        //              // color: Colors.tealAccent,
                        //               // boxShadow: [
                        //               //   BoxShadow(
                        //               //     offset: Offset(0, 3),
                        //               //     blurRadius: 2,
                        //               //     color: Colors.black.withOpacity(0.2),
                        //               //   )
                        //               // ]
                        //           ),
                        //           child: Icon(Icons.arrow_back,color: Colors.grey,size: 26,),
                        //         ),
                        //       ),
                        //       ),
                        //
                        //
                        //       // Positioned(
                        //       //     top: 15,
                        //       //     right: 15,
                        //       //     child:
                        //       //     Obx(() {
                        //       //       bool isFavorite = Fav.favoriteItems.contains('${widget.id}-${widget.varid}');
                        //       //       return InkWell(
                        //       //         onTap: () {
                        //       //           isFavorite
                        //       //               ?Fav.removeFromFavorites(widget.id,widget.varid)
                        //       //               :Fav.addToFavorites(widget.id,widget.varid);
                        //       //         },
                        //       //         child: Container(
                        //       //           alignment: Alignment.center,
                        //       //           padding: EdgeInsets.all(3),
                        //       //           decoration:BoxDecoration(
                        //       //               borderRadius: BorderRadius.circular(8),
                        //       //               color: Colors.tealAccent,
                        //       //               boxShadow: [
                        //       //                 BoxShadow(
                        //       //                   offset: Offset(0, 3),
                        //       //                   blurRadius: 2,
                        //       //                   color: Colors.black.withOpacity(0.2),
                        //       //                 )
                        //       //               ]
                        //       //           ),
                        //       //           child:  Icon(
                        //       //             isFavorite ? Icons.favorite : Icons.favorite_border,
                        //       //             color: isFavorite ? Colors.red : Colors.grey,
                        //       //             size: 20,
                        //       //           ),
                        //       //         ),
                        //       //       );
                        //       //     }),
                        //
                        //       // ),
                        //
                        //
                        //
                        //     ],
                        //   ),
                        // ),
                          Container(

                            height: size.height * 0.6,
                            width: size.width,
                            child: Stack(children: [
                              PageView.builder(
                                controller: _pageController,
                                itemCount: 200,
                                onPageChanged: (int index) {
                                  setState(() {
                                    _currentPage = index %
                                        controller.products[0].images.length;
                                  });
                                },
                                itemBuilder: (context, index) {
                                  return  GestureDetector(
                                      onTap: (){
                                        Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) => FullScreenImage(
                                              imageUrl: controller.products[0].images[index % controller.products[0].images.length],
                                            ),
                                          ),
                                        );
                                      },
                                        child:  CachedNetworkImage(
                                            imageUrl:
                                              controller.products[0].images[index %
                                                  controller.products[0].images.length],
                                          fit: controller.products[0].Title=="shoes"?null:BoxFit.cover,
                                          ),

                                  );
                                },
                              ),
                              Positioned(
                                bottom: 5,
                                left: 5,
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: List.generate(
                                    controller.products[0].images.length,
                                    (index) {
                                      return Padding(
                                        padding: EdgeInsets.symmetric(
                                            horizontal: 4.0),
                                        child: AnimatedContainer(
                                          duration: Duration(milliseconds: 300),
                                          width: _currentPage == index
                                              ? 10.0
                                              : 2.0,
                                          height: 5.0,
                                          decoration: BoxDecoration(
                                            color: _currentPage == index
                                                ? Colors.black87
                                                : Colors.grey,
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ),
                              Positioned(
                                  bottom: 5,
                                  right: 5,
                                  child: Container(
                                    decoration: BoxDecoration(
                                        // color: Color(0xFFE74740),
                                        color: Colors.red,
                                        borderRadius: BorderRadius.all(
                                            Radius.circular(3))),
                                    alignment: Alignment.center,
                                    height: size.height * 0.029,
                                    width: size.width * 0.13,
                                    // color: Colors.white,
                                    child: Text(
                                      "-${controller.products[0].discount} %",
                                      style: TextStyle(
                                          color: Colors.white,
                                          fontSize: 13,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  )),



                              Positioned(
                                top: 15,
                                left: 15,
                                child:
                                GestureDetector(
                                  onTap: (){
                                    Get.back();
                                  },
                                  child: Container(
                                    alignment: Alignment.center,
                                    padding: EdgeInsets.all(10),

                                    child: Icon(Icons.arrow_back,color: Colors.grey,size: 24,),
                                  ),
                                ),
                              ),




                              Positioned(
                                        top: 15,
                                        right: 15,
                                        child:
                                        Obx(() {
                                          bool isFavorite = Fav.favoriteItems.contains('${widget.id}-${widget.varid}');
                                          return InkWell(
                                            onTap: () {
                                              isFavorite
                                                  ?Fav.removeFromFavorites(widget.id,widget.varid)
                                                  :Fav.addToFavorites(widget.id,widget.varid,"S");
                                            },
                                            child: Container(
                                              alignment: Alignment.center,
                                              padding: EdgeInsets.all(10),
                                              child:  Icon(
                                                isFavorite ? Icons.favorite : Icons.favorite_border,
                                                color: isFavorite ? Colors.red : Colors.grey,
                                                size: 20,
                                              ),
                                            ),
                                          );
                                        }),
                                    ),
                            ]),
                          // ),
                        ),
                        Container(
                          margin: EdgeInsets.only(
                              left: size.width / 28,
                              right: size.width / 28,
                              top: 20),
                          child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [

                                    Text(
                                      "${controller.products[0].Description}".toUpperCase(),
                                        style: GoogleFonts.plusJakartaSans(
                                          fontWeight: FontWeight.bold,
                                        )
                                            .copyWith(
                                            color: Colors.black.withOpacity(0.9),
                                            //color: kTextcolor,
                                            fontSize: 16.5
                                        )
                                    ),
                                    // Icon(Icons.label_outlined,size: 17,)

                                SizedBox(
                                  height: size.height * 0.02,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "₹ ${controller.products[0].nprice}",
                                        style: GoogleFonts.plusJakartaSans(
                                          fontWeight: FontWeight.w500,
                                        )
                                            .copyWith(
                                            color: Colors.black.withOpacity(0.9),
                                            //color: kTextcolor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 14
                                        )
                                    ),
                                    SizedBox(
                                      width: size.width * 0.08,
                                    ),
                                    Text("₹ ${controller.products[0].oprice}",
                                        style: GoogleFonts.plusJakartaSans(
                                          fontWeight: FontWeight.w500,
                                        )
                                            .copyWith(
                                            color: Colors.black.withOpacity(0.9),
                                            //color: kTextcolor,
                                            fontSize: 13,
                                          decoration: TextDecoration.lineThrough
                                        )
                                    )
                                  ],
                                ),
                                SizedBox(
                                  height: size.height * 0.003,
                                ),
                                Text(
                                  "incl. of all Taxes",
                                    style: GoogleFonts.plusJakartaSans(
                                      fontWeight: FontWeight.w500,
                                    )
                                        .copyWith(
                                        color: kTextcolor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10
                                    )
                                ),
                                SizedBox(
                                  height: 30,
                                ),


                              if  (controller.products[0].colors.length>0)
                                Text(
                                  "Colors available",
                                    style: GoogleFonts.plusJakartaSans(
                                      fontWeight: FontWeight.w500,
                                    )
                                        .copyWith(
                                        color: kTextcolor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10
                                    )
                                ),


                                if  (controller.products[0].colors.length>0)
                                Container(
                                  margin: EdgeInsets.only(top: 5),
                                  alignment: Alignment.centerLeft,
                                  height: size.height * 0.045,
                                  child: ListView.builder(
                                    scrollDirection: Axis.horizontal,
                                    itemCount:
                                        controller.products[0].colors.length,
                                    itemBuilder: (context, index) {
                                      bool isSelected = controller
                                              .products[0].colors[index] ==
                                          controller.products[0].color;
                                      String variationId =
                                          'variation${index + 1}'; // Assuming selectedColor is the color selected
                                      return Row(
                                        children: [
                                          Stack(
                                            children: [
                                              Container(
                                                padding: EdgeInsets.all(1.6),
                                                decoration: (isSelected)
                                                    ? BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                            color: Colors.grey,
                                                            width: 2),
                                                      )
                                                    : BoxDecoration(
                                                        shape: BoxShape.circle,
                                                        border: Border.all(
                                                            color: Colors
                                                                .transparent,
                                                            width: 2),
                                                      ),
                                                child: GestureDetector(
                                                  onTap: () {

                                                    controller.findProductDocument("${widget.id}", variationId);

                                                    print(widget.id);
                                                    print(variationId);
                                                    // }
                                                  },
                                                  child: CircleAvatar(
                                                    radius: 10,
                                                    backgroundColor:
                                                        _getColorFromHex(
                                                            controller
                                                                .products[0]
                                                                .colors[index]),
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                          SizedBox(
                                              width:
                                                  12), // Adjust the spacing between the circle avatars
                                        ],
                                      );
                                    },
                                  ),
                                ),

                                if  (controller.products[0].Title=="shoes")
                                  GestureDetector(
                                    onTap:(){
                                      Get.to(()=>ModelView());
                                    },
                                    child: Container(
                                      padding: EdgeInsets.only(left: 15,right: 15),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                          color: Colors.brown,
                                          width: 0.5
                                        ),
                                        borderRadius: BorderRadius.circular(10),

                                      ),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        children: [
                                          Text(
                                              "View in 3D",
                                              style: GoogleFonts.plusJakartaSans(
                                                fontWeight: FontWeight.w500,
                                              )
                                                  .copyWith(
                                                  color: kTextcolor,
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 10
                                              )
                                          ),
                  Container(
                                                padding: EdgeInsets.all(10),
                                                  child: Icon(Icons.layers,color: Colors.blue,))

                                        ],
                                      ),
                                    ),
                                  ),


                                // if  (controller.products[0].colors.length>0)
                                //   Text(
                                //       "Colors available",
                                //       style: GoogleFonts.plusJakartaSans(
                                //         fontWeight: FontWeight.w500,
                                //       )
                                //           .copyWith(
                                //           color: kTextcolor,
                                //           fontWeight: FontWeight.bold,
                                //           fontSize: 10
                                //       )
                                //   ),


                                SizedBox(
                                  height: 10,
                                ),

                                Text(
                                  "Choose size:",
                                    style: GoogleFonts.plusJakartaSans(
                                      fontWeight: FontWeight.w500,
                                    )
                                        .copyWith(
                                        color: kTextcolor,
                                        fontWeight: FontWeight.bold,
                                        fontSize: 10
                                    )
                                ),

                                Container(
                                  margin: EdgeInsets.only(top: 4, bottom: 8),
                                  height: size.height * 0.045,
                                  //Adjust this height based on your requirement
                                  child: ListView.builder(
                                    controller: _scrollController,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: controller.products.isNotEmpty
                                        ? controller.products[0].sizes.length
                                        : 0,
                                    itemBuilder:
                                        (BuildContext context, int index) {
                                      final sizeInfo =
                                          controller.products[0].sizes[index];
                                      return GestureDetector(
                                        onTap: () {
                                          if (sizeInfo.availableItems > 0) {
                                            setState(() {
                                              selectedSizeIndex = index;
                                            });
                                            // Scroll to the selected size
                                            // _scrollController
                                            //     .
                                            //     // animateTo(
                                            //     //     2, duration: Duration(seconds: 2), curve: Curves.ease);
                                            //     animateTo(
                                            //   index * (size.width * 0.1),
                                            //   duration:
                                            //       Duration(milliseconds: 100),
                                            //   curve: Curves.easeIn,
                                            // );
                                          } else {
                                            ScaffoldMessenger.of(context)
                                                .showSnackBar(
                                              SnackBar(
                                                content: Text(
                                                  "size out of stock!",
                                                  textAlign: TextAlign.center,
                                                ),
                                                behavior:
                                                    SnackBarBehavior.floating,
                                                duration: Duration(seconds: 1),
                                              ),
                                            );
                                          }
                                          ;
                                        },
                                        child: Container(
                                          
                                          alignment: Alignment.center,
                                          width: size.width * 0.15,
                                          margin: EdgeInsets.only(
                                              top: 2, bottom: 2, right: 6),
                                          decoration: BoxDecoration(
                                            color: selectedSizeIndex == index
                                                ? Colors.teal
                                                : Colors.white,
                                            border: sizeInfo.availableItems > 0
                                                ? Border.all(
                                                    color: Colors.black,
                                                    width: 1.0,
                                                  )
                                                : Border.all(
                                                    color:
                                                        Colors.grey.shade300),
                                           // borderRadius: BorderRadius.circular(30),
                                            shape: BoxShape.circle
                                            // borderRadius: BorderRadius.circular(8),
                                          ),
                                          child: Text(
                                            sizeInfo.size,
                                            style: TextStyle(
                                              color: selectedSizeIndex == index
                                                  ? Colors.white
                                                  : sizeInfo.availableItems > 0
                                                      ? Colors.black
                                                      : Colors.grey,
                                              fontSize: size.width * 0.034,
                                              fontWeight: FontWeight.bold,
                                            ),
                                          ),
                                        ),
                                      );
                                    },
                                  ),
                                ),

                                selectedSizeIndex != -1
                                    ? Container(
                                        margin: EdgeInsets.only(bottom: 10),
                                        child: Text(
                                          'Selected size: ${controller.products[0].sizes[selectedSizeIndex].size}',
                                            style: GoogleFonts.plusJakartaSans(
                                              fontWeight: FontWeight.w500,
                                            )
                                                .copyWith(
                                                color: Colors.black,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 12
                                            )
                                        ),
                                      )
                                    : Container(),

                                InkWell(
                                  splashColor:
                                      Colors.white, // Define the splash color
                                  onTap: () {
                                    setState(() {
                                      if (selectedSizeIndex != -1)
                                        isPressed1 =
                                            true; // Set pressed state to true
                                    });
                                    Future.delayed(Duration(milliseconds: 200),
                                        () {
                                      setState(() {
                                        isPressed1 =
                                            false; // Reset pressed state after a delay
                                      });
                                    });
                                    // Your existing functionality here
                                    if (selectedSizeIndex != -1) {
                                      product_Add_to_cart_controller.ADD(
                                        controller.products[0].id,
                                        controller.products[0].varid,
                                        controller.products[0].sizes[selectedSizeIndex].size,
                                      );
                                      Future.delayed(
                                          Duration(milliseconds: 200), () {
                                        SnackBar1(size);
                                      });
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          margin: EdgeInsets.only(
                                              bottom: size.height / 4),
                                          content: Text(
                                            "Please select a size!",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.red),
                                            textAlign: TextAlign.center,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                          ),
                                          elevation: 1,
                                          duration: Duration(milliseconds: 700),
                                          backgroundColor: Colors.white,
                                          behavior: SnackBarBehavior.floating,
                                        ),
                                      );
                                    }
                                  },
                                  child: Stack(children: [
                                    AnimatedContainer(
                                      padding: EdgeInsets.only(right: 10),
                                      duration: Duration(milliseconds: 200),
                                      curve: Curves.easeInOut,
                                      margin: isPressed1
                                          ? EdgeInsets.only(
                                              left: (size.width / 28) * 3,
                                              right: (size.width / 28) * 3,
                                              top: size.height * 0.0125,
                                              bottom: size.height * 0.0125)
                                          : EdgeInsets.only(left: 0),
                                      width: isPressed1
                                          ? size.width - ((size.width / 28) * 6)
                                          : size.width -
                                              ((size.width / 28) * 2),
                                      alignment: Alignment.center,
                                      height: isPressed1
                                          ? size.height * 0.04
                                          : size.height * 0.065,
                                      decoration: BoxDecoration(
                                        color: isPressed1
                                            ? Colors.brown.withOpacity(0.4)
                                            : selectedSizeIndex != -1
                                                ? Colors.black87
                                                : Colors.grey,
                                         borderRadius: BorderRadius.circular(22.0),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Spacer(),
                                          Text(
                                            "Add to Bag",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Spacer(),
                                          Icon(
                                            Icons.shopping_bag_outlined,
                                            size: size.width * 0.05,
                                            color: Colors.white,
                                          )
                                        ],
                                      ),
                                    ),
                                  ]),
                                ),

                                SizedBox(
                                  height: 10,
                                ),

                                InkWell(
                                  splashColor:
                                      Colors.white, // Define the splash color
                                  onTap: () {
                                    setState(() {
                                      if (selectedSizeIndex != -1)
                                        isPressed2 =
                                            true; // Set pressed state to true
                                    });
                                    Future.delayed(Duration(milliseconds: 200),
                                        () {
                                      setState(() {
                                        isPressed2 =
                                            false; // Reset pressed state after a delay
                                      });
                                    });
                                    // Your existing functionality here
                                    if (selectedSizeIndex != -1) {
                                      if (selectedSizeIndex != -1) {
                                        product_Add_to_cart_controller.ADD(
                                          controller.products[0].id,
                                          controller.products[0].varid,
                                          controller.products[0].sizes[selectedSizeIndex].size,
                                        );
                                          setState(() {
                                            pageState.page.value = 2;
                                          });
                                         Get.back();

                                      }
                                    } else {
                                      ScaffoldMessenger.of(context)
                                          .showSnackBar(
                                        SnackBar(
                                          margin: EdgeInsets.only(
                                              bottom: size.height / 2),
                                          content: Text(
                                            "Please select a size!",
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: Colors.red),
                                            textAlign: TextAlign.center,
                                          ),
                                          shape: RoundedRectangleBorder(
                                            borderRadius: BorderRadius.all(
                                                Radius.circular(10)),
                                          ),
                                          elevation: 2,
                                          duration: Duration(milliseconds: 500),
                                          backgroundColor: Colors.white70,
                                          behavior: SnackBarBehavior.floating,
                                        ),
                                      );
                                    }
                                  },
                                  child: Stack(children: [
                                    AnimatedContainer(
                                      padding: EdgeInsets.only(right: 10),
                                      duration: Duration(milliseconds: 200),
                                      curve: Curves.easeInOut,
                                      margin: isPressed2
                                          ? EdgeInsets.only(
                                              left: (size.width / 28) * 3,
                                              right: (size.width / 28) * 3,
                                              top: size.height * 0.0125,
                                              bottom: size.height * 0.0125)
                                          : EdgeInsets.only(left: 0),
                                      width: isPressed2
                                          ? size.width - ((size.width / 28) * 6)
                                          : size.width -
                                              ((size.width / 28) * 2),
                                      alignment: Alignment.center,
                                      height: isPressed2
                                          ? size.height * 0.04
                                          : size.height * 0.065,
                                      decoration: BoxDecoration(
                                        color: isPressed2
                                            ? Colors.orange.withOpacity(0.4)
                                            : selectedSizeIndex != -1
                                                ? Colors.black87
                                                : Colors.grey,
                                        borderRadius: BorderRadius.circular(22.0),
                                      ),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.center,
                                        children: [
                                          Spacer(),
                                          Text(
                                            "Go to cart",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold),
                                          ),
                                          Spacer(),
                                          Icon(
                                            Icons.arrow_forward_outlined,
                                            size: size.width * 0.05,
                                            color: Colors.white,
                                          )
                                        ],
                                      ),
                                    ),
                                  ]),
                                ),

                                //     ],
                                //   ),
                                //
                                // ),
                                // AddCounter(id: widget.id),
                                SizedBox(
                                  height: 100,
                                ),
                                SizedBox(
                                  height: 200,
                                  child: Container(
                                    color: Colors.orange,
                                  ),
                                )
                              ]),
                        ),
                      ],
                    );
                  }
                },
              )
            ]),
          )),
    );
  }
}
