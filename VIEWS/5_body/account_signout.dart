
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'Profile.dart';
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
    return Stack(
      children:[


        Center(
        child: GetX<USER_CHECK>(
          builder: (USER_CHECK controller) {
            if (controller.user != null) {
              print(controller.user);
              return GestureDetector(
                onTap: () async {
                },
                  child:Profile(),
              );
            } else  {
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
