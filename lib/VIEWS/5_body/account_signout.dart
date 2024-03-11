
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../../11.dart';
import '../../CONTROLLERS/Cart/Retriving_controllers/cart_items_retrive_controller.dart';
import '../MainHome.dart';
import '../signin,login,intro/Login_page.dart';


class USER_CHECK extends GetxController {

  final Rx<User?> _user = Rx<User?>(null);

  User? get user => _user.value;

  @override
  void onInit() {
    super.onInit();
    _user.bindStream(FirebaseAuth.instance.authStateChanges());
  }

  Future<void> logOut() async {
    try {
      await FirebaseAuth.instance.signOut();
      _user.value = null;
    } catch (e) {
      print('Error signing out: $e');
    }
  }
}


class SignOut extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    CartProductController cartproductcontroller=Get.put(CartProductController());
    return Stack(
      children:[

    // Container(
    // width: MediaQuery.of(context).size.width,
    // height: MediaQuery.of(context).size.height,
    // decoration: BoxDecoration(
    // gradient: LinearGradient(
    // colors: [Colors.blue[50]!, Colors.blueAccent, Colors.purple[300]!],
    // begin: Alignment.topCenter,
    // end: Alignment.bottomCenter),
    // ),
    // ),

        Center(
        child: GetX<USER_CHECK>(
          builder: (USER_CHECK controller) {
            if (controller.user != null) {

              print(controller.user);
              // User is logged in, show the sign-out button
              return GestureDetector(
                onTap: () async {
               //   Get.to(()=>Main_Homes_builder());//dart Navigate to the Login screen
                },
                  child:ECommerceApp(),
              );
            } else  {
              // User is not logged in, show a dialog to log in
              return Row(
                children: [
                  ElevatedButton(
                    onPressed: () {
                      Get.to(SignInScreen()); // Navigate to the Login screen
                    },
                    child: Text('Log In'),
                  ),

                ],
              );
            }
          },
        ),
      ),
    ]
    );

  }
}
