


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';



class FavouritesController extends GetxController{

   RxList<String> favoriteItems = <String>[].obs;

  void updateUI() {
    update();
  }


  Future<void> addToFavorites(String productId,String variationId,String size) async {
    // Get the current user
    final User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Reference to the user's favorites subcollection
      CollectionReference favoritesRef = FirebaseFirestore.instance
          .collection('Users')
          .doc(user.uid)
          .collection('Favorites');

      // Check if the item is already in favorites
      QuerySnapshot<Object?> existingFavorites = await favoritesRef.where('id', isEqualTo: productId.toString()).where('variance_id', isEqualTo: variationId.toString()).get();
      favoriteItems.add('$productId-$variationId');
      print("successfully added id");
      if (existingFavorites.docs.isEmpty) {
        // The item is not in favorites, so add it
        await favoritesRef.add({
          'id': productId,
          'variance_id': variationId,// Use it as an int
         'size': size, // Include the 'size' field
        //  'quantity': 1, // Initialize quantity to 1 for a new item
          'Timestamp': FieldValue.serverTimestamp(),
        });

        updateUI();
      }
    }
  }

  Future<void> removeFromFavorites(String productId,String VariationId) async {
    // Get the current user
    final User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      // Reference to the user's favorites subcollection
      CollectionReference favoritesRef = FirebaseFirestore.instance
          .collection('Users')
          .doc(user.uid)
          .collection('Favorites');

      // Check if the item is in favorites
      QuerySnapshot<Object?> matchingFavorites =
      await favoritesRef.where('id', isEqualTo: productId).where('variance_id',isEqualTo: VariationId).get();

      if (matchingFavorites.docs.isNotEmpty) {
        // Remove the matching item from favorites
        await matchingFavorites.docs[0].reference.delete();
        favoriteItems.remove('$productId-$VariationId');
        updateUI();
      }
    }
  }


}