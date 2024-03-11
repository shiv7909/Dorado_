


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class ImageUrlController extends GetxController {
  RxList<String> imageUrls = <String>[].obs;

  Future<void> fetchImageUrls() async {
    try {
      DocumentSnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Sliders')
          .doc('Combinations')
          .get();
      if (querySnapshot.exists) {
        print("existshjgjvfjvghgvhvbjhvufyvfftfcytftrtfgvgftrftrtrtfrf s");
        List<dynamic> imageUrlList = querySnapshot['Imageurls'];
        imageUrls.assignAll(imageUrlList.cast<String>());
      } else {
        print('Combination document does not exist');
      }
    } catch (e) {
      print('Error fetching image URLs: $e');
    }
  }
}
