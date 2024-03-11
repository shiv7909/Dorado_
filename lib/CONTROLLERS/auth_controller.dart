import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../VIEWS/signin,login,intro/introvedio.dart';





class Auth_controller extends GetxController {

  static Auth_controller instance = Get.find();
  FirebaseAuth auth = FirebaseAuth.instance;
  late Rx<User?> _user;


  @override

  void onReady() {
    super.onReady();
    _user = Rx<User?>(auth.currentUser);
    _user.bindStream(auth.userChanges());
    ever(_user, _initialScreen);
  }


  _initialScreen(User? user) {
      Get.offAll(() => VideoSplashScreen());
    }


  Future<void> register(String email, String password, String username) async {
    try {
      final UserCredential userCredential = await auth.createUserWithEmailAndPassword(email: email, password: password,
      );

      final User? user = userCredential.user;
      if (user != null) {
        // Create a user document in the 'Users' collection
        await FirebaseFirestore.instance.collection('Users').doc(user.uid).set({
          'email': email,
          'username': username,
          'TimeStamp': FieldValue.serverTimestamp(),
        });

        await _createSubcollectionIfNotExists(user.uid, 'Cart');
        await _createSubcollectionIfNotExists(user.uid, 'Favorites');
        await _createSubcollectionIfNotExists(user.uid, 'PurchasedItems');
        await _createSubcollectionIfNotExists(user.uid, 'SavedForLater');
        await _createSubcollectionIfNotExists(user.uid, 'SearchHistory');
        await _createSubcollectionIfNotExists(user.uid, 'OrderStatus');

        Get.snackbar(
          "Account Created",
          "Your account has been successfully created!",
          backgroundColor: Colors.green,
          snackPosition: SnackPosition.BOTTOM,
          colorText: Colors.white,
        );
      }
    } on FirebaseAuthException catch (e) {
      if(e.code=='weak-password')
        {
          Get.snackbar(
            "Password provided is too weak",
            'please enter strong password',
            backgroundColor: Colors.red,
            colorText: Colors.white,
          );
        }
      else if(e.code=="email-already-in-use") {
        Get.snackbar(
          "Email already exists",
          'please login ',
          backgroundColor: Colors.red,
          colorText: Colors.white,

        );
      }

      else {
        Get.snackbar(
          "Account Creation Failed",
          'please check credentials or account already exists login ',
          backgroundColor: Colors.red,
          colorText: Colors.white,

        );
      }
    }
  }



  Future<void> _createSubcollectionIfNotExists(String userId, String subcollectionName) async {
    final subcollectionRef = FirebaseFirestore.instance.collection('Users').doc(userId).collection(subcollectionName);

    await subcollectionRef.add({});
    final querySnapshot = await subcollectionRef.get();
    final documents = querySnapshot.docs;
    for (final doc in documents) {
      await doc.reference.delete();
    }
  }


  Future<void> login(String email, password) async {
    try {
      await auth.signInWithEmailAndPassword(email: email, password: password);
      Get.snackbar(
        "Login Successful",
        "You are now logged in!",
        backgroundColor: Colors.green,
        snackPosition: SnackPosition.BOTTOM,
        colorText: Colors.white,
      );
    } catch (e) {
      Get.snackbar("About Login", "Login message",
          backgroundColor: Colors.redAccent,
          snackPosition: SnackPosition.BOTTOM,
          titleText: Text(
            "Login Failed",
            style:   GoogleFonts.plusJakartaSans(
            fontSize: 14,
            fontWeight: FontWeight.w500,
             color: Colors.white
          ),
          ),
          messageText: Text(
            "please check entered details",
            style: GoogleFonts.plusJakartaSans(
            fontSize: 14,
            fontWeight: FontWeight.w500,
                color: Colors.white
            // color: AppColor.kWhite
          ),
          ),
      );
    }
  }

  void logOut() async {
    await auth.signOut();
  }


  getCurrentUser()async{
    return await auth.currentUser;
  }




}




