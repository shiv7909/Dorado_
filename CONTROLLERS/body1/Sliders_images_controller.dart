


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

class Sliders_images extends GetxController {

  Map<String, RxList<String>> imageUrlsMap = {};

  Future<void> fetchImageUrls(String document, String carouselId) async {
    try {
      DocumentSnapshot querySnapshot = await FirebaseFirestore.instance
          .collection('Sliders')
          .doc(document)
          .get();
      if (querySnapshot.exists) {
        List<dynamic> imageUrlList = querySnapshot['Imageurls'];
        imageUrlsMap[carouselId] = imageUrlList.cast<String>().obs;
      } else {
        print('Combination document does not exist');
      }
    } catch (e) {
      print('Error fetching image URLs: $e');
    }
  }
}
