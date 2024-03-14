import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import '../Retriving_controllers/cart_items_retrive_controller.dart';



class Product_incre_decre_remo_cart_controller extends GetxController {

  CartProductController pController=Get.put(CartProductController());
  final RxBool isCartEmpty = false.obs;

  void increment_cart(String size, String id,String variation_id) {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      String  selectedProductID = id;
      String  variation=variation_id;// Use it directly as an int

      // Reference to the user's cart subcollection
      CollectionReference userCartRef = FirebaseFirestore.instance
          .collection('Users')
          .doc(user.uid)
          .collection('Cart');

      userCartRef
          .where('id', isEqualTo: selectedProductID)
          .where('variance_id',isEqualTo: variation)// Use it as an int
          .where('size', isEqualTo: size) // Include the 'size' field
          .get()
          .then((querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
          // If a matching document exists, update the quantity
          DocumentSnapshot existingDoc = querySnapshot.docs.first;
          int currentQuantity = existingDoc['quantity'] ?? 0;
          DocumentReference existingDocRef = existingDoc.reference;
          existingDocRef.update({
            'quantity': FieldValue.increment(1), // Increment the quantity field
            'Timestamp': FieldValue.serverTimestamp(),
          });
        } else {
          // If no matching document exists, create a new document
          userCartRef.add({
            'id': selectedProductID,
            'variance_id':variation,
            // Use it as an int
            'size': size, // Include the 'size' field
            'quantity': 1, // Initialize quantity to 1 for a new item
            'Timestamp': FieldValue.serverTimestamp(),
          });
        }
      }).catchError((error) {
        // Handle any errors that occur while checking for existing documents
        print("Error checking for an existing item in the cart: $error");
      });

      updateUI();
    }
  }




  void updateUI() {
    update();
  }


  void decrement2_cart(String productId,String variationId, String size) {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      CollectionReference userCartRef = FirebaseFirestore.instance
          .collection('Users')
          .doc(user.uid)
          .collection('Cart');

      userCartRef
          .where('id', isEqualTo: productId)
      .where('variance_id',isEqualTo:variationId)
          .where('size', isEqualTo: size)
          .get()
          .then((querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {

          DocumentReference selectedCartItemRef = querySnapshot.docs[0].reference;
          int quantity = querySnapshot.docs[0]['quantity'];

          if (quantity > 1) {
            selectedCartItemRef.update({
              'quantity': FieldValue.increment(-1),
            }).then((_) {
              checkCartEmpty();
              print('Quantity Decremented in Cart');
            }).catchError((error) {
              print('Error Decrementing Quantity in Cart: $error');
            });
          } else {
            selectedCartItemRef.delete().then((_) {
              checkCartEmpty();
              print('Item Removed from Cart');
            }).catchError((error) {
              print('Error Removing Item from Cart: $error');
            });
          }
        } else {
          print(
              'No matching item found in the cart for productId $productId and size $size');
        }

        updateUI();
      }).catchError((error) {
        print("Error querying cart: $error");
      });
    }
  }


  void remove(String productId, String variationId, String size) {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      CollectionReference userCartRef = FirebaseFirestore.instance
          .collection('Users')
          .doc(user.uid)
          .collection('Cart');

      userCartRef
          .where('id', isEqualTo: productId)
          .where('size', isEqualTo: size)
          .where('variance_id', isEqualTo: variationId)
          .get()
          .then((querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
          DocumentReference selectedCartItemRef = querySnapshot.docs[0].reference;
          selectedCartItemRef.delete().then((_) {
            checkCartEmpty();
            updateUI();
            print('Item Removed from Cart');
          }).catchError((error) {
            print('Error Removing Item from Cart: $error');
          });
        }
      });
    }
  }






  void checkCartEmpty() async {
    final User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      CollectionReference cartCollection = FirebaseFirestore.instance
          .collection('Users')
          .doc(user.uid)
          .collection('Cart');

      QuerySnapshot cartSnapshot = await cartCollection.get(GetOptions(source: Source.server));

      if (cartSnapshot.docs.isEmpty) {
        isCartEmpty.value = true; // Set isCartEmpty to true if the cart is empty
      } else {
        isCartEmpty.value = false; // Set isCartEmpty to false if there are items in the cart
      }
    }
  }






}

