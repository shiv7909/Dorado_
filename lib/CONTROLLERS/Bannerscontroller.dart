


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';

class bannerUrl extends GetxController {
  Future<String> getCurrentImageUrl(String banner) async {
    try {
      final DocumentSnapshot snapshot = await FirebaseFirestore.instance.collection('announcement').doc(banner).get();
      if (snapshot.exists) {
        final Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        final String imageUrl = data['imageurl'];
        return imageUrl;
      } else {
        return 'Something went wrong please try again later'; // Handle the case where no URL is found.
      }
    } catch (e) {
      return ''; // Handle errors
    }
  }
}
