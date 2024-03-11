import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import '../../../../MODELS/constants.dart';
import '../../../../CONTROLLERS/Cart/Functionality_controllers/product_in_cart_incre_decre.dart';
import '../../../CONTROLLERS/Cart/Functionality_controllers/saved_for_later_controller.dart';
import '../../../CONTROLLERS/Cart/Retriving_controllers/cart_items_retrive_controller.dart';
import '../../../MODELS/cart_products_model.dart';


class CartProductItem extends StatefulWidget {

  final CartProduct cartProduct;
  final Product_incre_decre_remo_cart_controller cartController;
  final Saved_for_later saveforlater;
  final String level;

  CartProductItem({
    required this.cartProduct,
    required this.cartController,
    required this.saveforlater,
    required this.level,
  });

  @override
  _CartProductItemState createState() => _CartProductItemState();
}



class _CartProductItemState extends State<CartProductItem> {

  late int quantity;

  @override
  void initState() {
    super.initState();
    quantity = widget.cartProduct.Quantity_in_cart;
  }


  void remove() {
    setState(() {
      quantity = 0;
    });

  }


  void incrementQuantity() {
    if(quantity+1<=widget.cartProduct.Quantity_in_stock) {
      setState(() {
        quantity++;
      });
      widget.cartController.increment_cart(
          widget.cartProduct.size, widget.cartProduct.id,
          widget.cartProduct.variationid);
    }
    else{

    }
  }




  void decrementQuantity() {
    if (quantity > 0) {
      setState(() {
        quantity--;
      });
    }
  }


  void saveforlater() {
    setState(() {
      quantity = 0;
    });

  }





  @override
  Widget build(BuildContext context) {

    // if(widget.level=='checkout')
    //   {
    //     quantity=widget.cartProduct.Quantity_in_stock;
    //   }
    Size size = MediaQuery
        .of(context)
        .size;

    int dis = widget.cartProduct.oprice - widget.cartProduct.nprice;

    return quantity > 0
        ?
    Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(20)),
         color: Colors.grey[100],

      ),
      margin: EdgeInsets.only(top: 15),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Column(
            children: [
              widget.cartProduct.Quantity_in_stock >= widget.cartProduct.Quantity_in_cart
                  ? Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                ),
                height: size.height * 0.15,
                width: size.width * 0.3,
                child: ClipRRect(
                  borderRadius: BorderRadius.all(Radius.circular(10)),
                  child: CachedNetworkImage( imageUrl: widget.cartProduct.imagepath,)),
                ):
                Container(
                  alignment: Alignment.center,
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 10),
                  height: size.height * 0.15,
                  width: size.width * 0.3,
                  child: ClipRRect(
                    borderRadius: BorderRadius.all(Radius.circular(10)),
                    child: Stack(children:[ Image.network(widget.cartProduct.imagepath),

                      if (widget.cartProduct.Quantity_in_stock == 0)
                         Positioned(
                           top: size.height * 0.15/2,
                           child: Text(
                              '! Out of stock',
                              style: TextStyle(
                                  color: Colors.red,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 12
                              ),
                            ),
                         ),

                    ]),
                  ),
                ),


              if (widget.cartProduct.Quantity_in_stock <= 20 && widget.cartProduct.Quantity_in_stock != 0)
                Container(
                  width: size.width * 0.3,
                  child: FittedBox(
                    fit: BoxFit.scaleDown,
                    child: Text(
                      "Only"
                          // " ${widget.cartProduct
                          // .Quantity_in_stock} "
                          " few left in stock",
                      style: TextStyle(
                        color: Colors.red[900],
                        fontWeight: FontWeight.w500,
                        fontSize: 10,
                      ),
                    ),
                  ),
                ),
            ],
          ),
          Expanded(
            child: Column(
              children: [

                Container(
                  margin: EdgeInsets.only(
                      bottom: 2, top: 10, right: size.width * 0.2),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          '${widget.cartProduct.Description}',
                          style: TextStyle(fontWeight: FontWeight.w500,fontSize: 13,color: Colors.black87),
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      )
                    ],
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(bottom: 2, top: 4),
                  child: Row(
                    children: [
                      Text(
                        'Size: ',
                        style: TextStyle(fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: Colors.grey),
                      ),
                      Container(
                        child: Text(
                          ' ${widget.cartProduct.size}  ',
                          style: TextStyle(fontWeight: FontWeight.w500,
                              fontSize: 11),
                        ),
                         ),
                       SizedBox(width: 4,),

                        Text(
                          'Quantity: ',
                          style: TextStyle(fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: Colors.grey),
                      ),

                      Container(
                        child: Text(
                        (widget.level!="checkout")?
                            widget.cartProduct.Quantity_in_cart>widget.cartProduct.Quantity_in_stock?
                            "${widget.cartProduct.Quantity_in_stock}":quantity.toString():
                          "${widget.cartProduct.Quantity_in_cart} ",
                          style: TextStyle(fontWeight: FontWeight.w500,
                              fontSize: 11),
                        ),
                      ),

                    ],
                  ),
                ),

                Container(
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    children: <Widget>[
                      Container(
                        margin: EdgeInsets.only(right: size.width * 0.1),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            "\₹${widget.cartProduct.nprice}",
                            style: TextStyle(
                              color: Colors.black,
                              fontWeight: FontWeight.w500,
                              fontSize: 13,
                            ),
                            maxLines: 1,
                          ),
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.only(right: size.width * 0.1),
                        child: FittedBox(
                          fit: BoxFit.scaleDown,
                          child: Text(
                            "\₹${widget.cartProduct.oprice}",
                            style: TextStyle(
                              decoration: TextDecoration.lineThrough,
                              fontWeight: FontWeight.w500,
                              fontSize: 11,
                              color: kPrimarycolor,
                            ),
                            maxLines: 1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(top: 3),
                  child: Row(
                    children: [
                      Visibility(
                        visible: widget.cartProduct.nprice <
                            widget.cartProduct.oprice,
                        child: Row(
                          children: [
                            Container(
                              padding: EdgeInsets.all(3),
                              width: size.width * 0.14,
                              height: size.height * 0.03,
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topLeft: Radius.circular(5),
                                    bottomLeft: Radius.circular(5)),
                                color: Colors.redAccent
                              ),
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  "save ₹${dis}",
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 10,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              width: size.width * 0.14,
                              height: size.height * 0.03,
                              padding: EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.only(
                                    topRight: Radius.circular(5),
                                    bottomRight: Radius.circular(5)),
                                  color: Colors.redAccent
                              ),
                              child: FittedBox(
                                fit: BoxFit.scaleDown,
                                child: Text(
                                  '(${widget.cartProduct.discount}\%)',
                                  style: TextStyle(
                                    fontWeight: FontWeight.w700,
                                    fontSize: 12,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Spacer(),

                      if(widget.level!="checkout")
                      Container(
                        margin: EdgeInsets.only(right: 8, top: 10, bottom: 15),
                        width: size.width * 0.07,
                        height: size.height * 0.03,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)
                            ),
                            padding: EdgeInsets.all(0),
                            elevation: 0,
                            foregroundColor: Colors.white,
                           // backgroundColor: Colors.black38.withOpacity(0.3),
                          ),
                          child: Icon(
                            Icons.remove,
                            color: Colors.grey,
                            size: 15,
                          ),
                          onPressed: () {
                            widget.cartController.decrement2_cart(
                                widget.cartProduct.id,widget.cartProduct.variationid, widget.cartProduct.size);
                            decrementQuantity();
                          },
                        ),
                      ),
                      if(widget.level=="checkout")
                      Container(
                        margin: EdgeInsets.only(right: 8, top: 10, bottom: 15),
                        width: size.width * 0.07,
                        height: size.height * 0.03,
                      ),





                      if(widget.level!="checkout")

                      Text(
                      // widget.cartProduct.Quantity_in_cart>widget.cartProduct.Quantity_in_stock?
                      //  "${widget.cartProduct.Quantity_in_cart}":
                   quantity.toString(),
                        style: TextStyle(fontSize: 13),
                      ),


                      if(widget.level!="checkout")
                      Container(
                        margin: EdgeInsets.only(
                            right: 10, left: 8, top: 10, bottom: 15),
                        width: size.width * 0.07,
                        height: size.height * 0.03,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(4)
                            ),
                            foregroundColor: Colors.white,
                            padding: EdgeInsets.all(0),
                            elevation: 0
                          ),
                          child: Icon(
                            Icons.add,
                            size: 15,
                            color: Colors.blue,
                          ),
                          onPressed: () {
                            widget.cartProduct.Quantity_in_stock > quantity
                                ? incrementQuantity()
                                : ScaffoldMessenger.of(context).showSnackBar(
                              SnackBar(
                                showCloseIcon: true,
                                duration: Duration(seconds: 3),
                                shape: StadiumBorder(),
                                backgroundColor: Colors.red,
                                content: Container(
                                  alignment: Alignment.center,
                                  child: Column(
                                    children: [
                                      Text(
                                        'Due to high demand we deliver limited Quantity of some products',
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
                if(widget.level!="checkout")
                Container(
                  alignment: Alignment.centerLeft,
                  margin: EdgeInsets.only(top: 10),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () {
                          // widget.cartController.saveForLater(widget.cartProduct
                          //     .size, widget.cartProduct.id);
                          // saveforlater();
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 4, right: 30),
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 1, color: Color(0xFFDEDEDE)),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.white,
                          ),
                          child: FittedBox(
                            child: Text(
                              'save for later',
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w500),
                            ),
                          ),
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          widget.cartController.remove(widget.cartProduct.id,widget.cartProduct.variationid,
                              widget.cartProduct.size);
                          remove();
                        },
                        child: Container(
                          margin: EdgeInsets.only(bottom: 4),
                          padding: EdgeInsets.all(6),
                          decoration: BoxDecoration(
                            border: Border.all(
                                width: 1, color: Color(0xFFDEDEDE)),
                            borderRadius: BorderRadius.all(Radius.circular(10)),
                            color: Colors.white,
                          ),
                          child: FittedBox(
                            child: Text(
                              'Remove',
                              style: TextStyle(
                                  fontSize: 13, fontWeight: FontWeight.w500),
                            ),
                          ),
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
    )
        : SizedBox(); // Return an empty widget when the quantity is zero
  }
}

















