import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../MODELS/body1/Advertisement_mini_model.dart';



class AdvertiseMini extends GetxController {
  final RxList<String> imageUrls = <String>[].obs;
  final RxString text = ''.obs;
  final RxList<product> products = <product>[].obs;

  Future<void> fetchAnnouncementData() async {
    try {
      final snapshot = await FirebaseFirestore.instance.collection('announcement').doc('add_mini').get();
      final data = snapshot.data();

      if (data != null) {
        final List<dynamic>? imageUrlList = data['Imageurls'];
        if (imageUrlList != null) {
          imageUrls.clear();
          imageUrls.addAll(imageUrlList.cast<String>());
        }

        final List<dynamic>? productMaps = data['products'];
        if (productMaps != null) {
          products.clear();
          productMaps.forEach((productMap) {
            final productId = productMap['id'] as String;
            final variationId = productMap['variation'] as String;
            final Product = product(id: productId, variation: variationId);
            products.add(Product);
          });
        }

        text.value = data['Text'] ?? '';
      }
    } catch (e) {
      print('Error fetching announcement data: $e');
    }
  }
}
