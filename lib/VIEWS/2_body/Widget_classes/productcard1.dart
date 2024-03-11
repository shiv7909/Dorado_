import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../CONTROLLERS/product_card/Functionality_controllers/ADD_Favourites_controller.dart';
import '../../../mainpeoductController.dart';
import '../../../mainproductModel.dart';
import '../../../mainproductpage.dart';

class productcard1 extends StatefulWidget {
  // final ProductController productController;
  final FavouritesController Fav = FavouritesController();

  productcard1({
    // required this.productController,
    required this.id,
    required this.title,
    required this.description,
    required this.colors,



    required this.variationid,

    required this.oprice,
    required this.nprice,
    required this.discount,


    required this.imagePath,
    required this.quantity,
    // required this.sizes,
    // required this.count_in_cart,
  }) ;
      // : imagePath = imageUrls.isNotEmpty ? imageUrls[0] : '';

  final String title, description, imagePath,id,variationid;
  final int oprice, nprice, discount, quantity;
  final List<String> colors;

  @override
  State<productcard1> createState() => _productcard1State();
}

class _productcard1State extends State<productcard1> {

  ParticularProductController controller =Get.put(ParticularProductController());

  RxBool isFavorite = false.obs;



  Color _getColorFromHex(String hexColor) {
    final buffer = StringBuffer();
    buffer.write(hexColor.replaceFirst('0x', ''));
    if (buffer.length == 6) buffer.write('FF'); // Adding alpha if it's missing
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  @override
  Widget build(BuildContext context) {
    Size size = MediaQuery.of(context).size;
    return Stack(
        children: [
      Container(
        width: size.width / 2 -15,
          padding: EdgeInsets.only( left: 2, right: 2),
        margin: EdgeInsets.only(
          left: 5,
        ),

          child: Column(
              children: <Widget>[
              Container(
                height: size.height * 0.26,
                width: size.height * 0.231,
                padding: EdgeInsets.all(2.4),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(15),
                ),
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(12),
                  child: InkWell(
                      onTap: () {
                        Get.to(()=>ProductDisplayScreen(id: widget.id, varid: widget.variationid,));
                      },
                      child: SizedBox(

                        child: widget.imagePath.isNotEmpty &&
                                widget.quantity != 0
                            ? CachedNetworkImage(
                               imageUrl: widget.imagePath,
                          fit: widget.title=="shoes"?BoxFit.contain:BoxFit.cover,
                        //  fit: BoxFit.cover,
                            )
                            : ColorFiltered(
                                colorFilter: ColorFilter.mode(
                                  Colors
                                      .grey, // Use grey color for desaturation
                                  BlendMode
                                      .saturation, // Apply saturation blend mode for grayscale effect
                                ),
                                child: Stack(
                                    children: [
                                  Container(
                                    height: size.height * 0.26,
                                    width: size.height * 0.244,
                                    child: widget.imagePath.isEmpty
                                        ? Container(
                                            color: Colors.grey,
                                          )
                                        : Image.network(
                                            widget.imagePath,
                                            fit: BoxFit.contain,
                                          ),
                                  ),
                                  Center(
                                    child: Text(
                                      'Out of Stock',
                                      style: TextStyle(color: Colors.white),
                                    ),
                                  )
                                ]),
                              ),
                      )),





                ),
              ),

            ///look at this during the unexpected exception
            Container(
              height: (size.height * 0.39)-(size.height * 0.26),

                 padding: EdgeInsets.only(left: 6.5, right: 6.5),
                
                child: InkWell(
                  onTap: () {
                    Get.to(()=>ProductDisplayScreen(id: widget.id, varid: widget.variationid,));
                  },
                  child: Column(
           mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[

                      Container(
                          alignment: Alignment.centerLeft,
                          height: (size.height * 0.13/3),
                          padding: EdgeInsets.only(right: 5),
                          //  width: size.width * 0.44,
                          child: Text(
                            '${widget.description}\n',
                            style: GoogleFonts.plusJakartaSans(
                              fontWeight: FontWeight.w500,
                            )
                                .copyWith(
                                color: Colors.black87,
                                fontSize: 13
                            ),
                            // style:
                            // Theme.of(context)
                            //     .textTheme
                            //    .displayLarge
                            //     ?.copyWith(fontSize: 13.4,fontWeight: FontWeight.w400)
                            // ,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,

                            // Limit the title to 2 lines (adjust as needed)
                          )),

                      Container(
                        padding: EdgeInsets.only(right: 6),
                      //  alignment: Alignment.centerLeft,
                        height: (size.height * 0.13/3-12),
                        child: Row(
                         crossAxisAlignment: CrossAxisAlignment.center,
                         // mainAxisAlignment: MainAxisAlignment.start,
                          children: <Widget>[
                            Expanded(
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  "\Rs ${widget.nprice}",
                                  style:
                                  Theme.of(context)
                                      .textTheme
                                      .displayMedium
                                      ?.copyWith(fontSize: 12.5,fontFamily: "light1",fontWeight: FontWeight.w700)
                                  ,

                                  maxLines: 1,
                                ),
                              ),
                            ),
                            // SizedBox(
                            //   width: size.width*0.042,
                            // ),
                            Visibility(
                              visible: widget.nprice < widget.oprice,
                              child: Expanded(
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Container(
                                    margin: EdgeInsets.only(left: 12),
                                    child: Text(
                                      "${widget.oprice}",
                               //       style:

                                      style:
                                      Theme.of(context)
                                          .textTheme
                                          .displayMedium
                                          ?.copyWith(fontSize: 12,fontFamily: "light1",fontWeight: FontWeight.w600,
                                          color: Color(0xFF525252),
                                      decoration: TextDecoration.lineThrough
                                      )
                                      ,
                                      maxLines: 1,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                            // SizedBox(
                            //   width: size.width*0.042,
                            // ),
                            Visibility(
                              visible: widget.nprice < widget.oprice,
                              child: Expanded(
                                child: FittedBox(
                                  fit: BoxFit.scaleDown,
                                  child: Container(
                                    margin: EdgeInsets.only(left: 10),
                                    child: Text(
                                      '${widget.discount}\% ' 'off',
                                      style:
                                      // TextStyle(
                                      //     color: Colors.red,
                                      //     fontWeight: FontWeight.w500,
                                      //     fontSize: 12
                                      // ),
                                      Theme.of(context)
                                          .textTheme
                                          .displayMedium
                                          ?.copyWith(fontSize: 12,fontFamily: "light1",fontWeight: FontWeight.w600,
                                         color: Colors.red
                                      )
                                      ,
                                      maxLines: 1,
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),



                      Container(
                        alignment: Alignment.centerLeft,
                        height: (size.height * 0.13 / 3),
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: widget.colors.length,
                          itemBuilder: (context, index) {
                            return Row(
                              children: [
                                CircleAvatar(
                                  radius: 3,
                                  backgroundColor: _getColorFromHex(widget.colors[index]),
                                ),
                                CircleAvatar(
                                  radius: 1,
                                  backgroundColor: Colors.transparent,
                                )
                              ],
                            );
                          },
                        ),
                      )


                      // Container(
                      //     alignment: Alignment.centerLeft,
                      //     height: (size.height * 0.14/3),
                      //     padding: EdgeInsets.only(right: 5,),
                      //     child: CircleAvatar(
                      //       radius: 3.5,
                      //       backgroundColor: Colors.orange,
                      //     )
                      // )




                    ],
                  ),
                ))
          ]),
        ),
      Positioned(
        top: 0,
        right: 0,
        child: Obx(() {
    bool isFavorite = widget.Fav.favoriteItems.contains('${widget.id}-${widget.variationid}');
    return IconButton(
    icon: Icon(
    isFavorite ? Icons.favorite : Icons.favorite_border,
    color: isFavorite ? Colors.red : Colors.grey,
    size: 20,
    ),
    onPressed: () {
    isFavorite
    ? widget.Fav.removeFromFavorites(widget.id,widget.variationid)
        : widget.Fav.addToFavorites(widget.id,widget.variationid,"S");
    },
    );
    })      ),

    ]);
  }
}

