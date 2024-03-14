

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';



class Product_Add_controller extends GetxController {




  void ADD(String id, String varience_id,String size) {
    // Get the current user
    final User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {


      // Reference to the user's cart subcollection
      CollectionReference userCartRef = FirebaseFirestore.instance
          .collection('Users')
          .doc(user.uid)
          .collection('Cart');

      // Check if a document with the same product ID and size already exists in the cart
      userCartRef
          .where('id', isEqualTo: id) // Use it as an int
          .where('variance_id', isEqualTo: varience_id)
          .where("size", isEqualTo: size)// Include the 'size' field
          .get()
          .then((querySnapshot) {
        if (querySnapshot.docs.isNotEmpty) {
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
            'id': id,
            'variance_id': varience_id,// Use it as an int
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
}

