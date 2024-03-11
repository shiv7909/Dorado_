


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';



class Google_signin extends GetxController {
  Future<bool> signInWithGoogle( ) async {
    final FirebaseAuth firebaseAuth = FirebaseAuth.instance;
    final GoogleSignIn googleSignIn = GoogleSignIn();
    final GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();

    final GoogleSignInAuthentication? googleSignInAuthentication = await googleSignInAccount?.authentication;
    final AuthCredential credential = GoogleAuthProvider.credential(
      idToken: googleSignInAuthentication?.idToken,
      accessToken: googleSignInAuthentication?.accessToken,
    );

    UserCredential result = await firebaseAuth.signInWithCredential(credential);
    User? userDetails = result.user;

    try {
      DocumentSnapshot userSnapshot = await FirebaseFirestore.instance.collection('Users').doc(userDetails?.uid).get();

      if (userSnapshot.exists) {
        Get.snackbar(
          "Successfully logged in",
          "we are happy to see you 😊",
          backgroundColor: Colors.green,
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
        );
        return false;
      } else {
        await FirebaseFirestore.instance.collection('Users').doc(
            userDetails?.uid).set({
          'email': userDetails?.email,
          'username': userDetails?.displayName,
          'TimeStamp': FieldValue.serverTimestamp(),
        });

        // Create subcollections
        await _createSubcollectionIfNotExists(userDetails!.uid, 'Cart');
        await _createSubcollectionIfNotExists(userDetails.uid, 'Favorites');
        await _createSubcollectionIfNotExists(userDetails.uid, 'PurchasedItems');
        await _createSubcollectionIfNotExists(userDetails.uid, 'SavedForLater');
        await _createSubcollectionIfNotExists(userDetails.uid, 'SearchHistory');
        await _createSubcollectionIfNotExists(userDetails.uid, 'OrderStatus');

        Get.snackbar(
          "Account Created",
          "Your account has been successfully created 😉!",
          backgroundColor: Colors.green,
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
        );
        return true;
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        Get.snackbar(
          "Password provided is too weak",
          'Please enter a strong password',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      } else {
        Get.snackbar(
          "Account Creation Failed",
          'Please check credentials or if the account already exists, log in',
          backgroundColor: Colors.red,
          colorText: Colors.white,
        );
      }
      return false;
    }
  }
}





Future<void> _createSubcollectionIfNotExists(String userId, String subcollectionName) async {
  final subcollectionRef = FirebaseFirestore.instance.collection('Users').doc(userId).collection(subcollectionName);

  await subcollectionRef.add({});
  // Delete the initial empty document
  final querySnapshot = await subcollectionRef.get();
  final documents = querySnapshot.docs;
  for (final doc in documents) {
    await doc.reference.delete();
  }
}