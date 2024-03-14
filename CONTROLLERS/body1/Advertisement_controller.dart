



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../MODELS/body1/Advertisement_model.dart';



class Advertisement_controller extends GetxController {

  Future<List<AdvertisementData>?> getCurrentImageData(String DocumentId, String Subcollection) async {
    try {
      final QuerySnapshot subcollectionSnapshot = await FirebaseFirestore.instance
          .collection('announcement')
          .doc(DocumentId)
          .collection(Subcollection)
          .get();

      if (subcollectionSnapshot.docs.isNotEmpty) {
        List<AdvertisementData> dataList = subcollectionSnapshot.docs
            .map((doc) => AdvertisementData(
          imageUrl: doc['imageurl'] as String,
          variationId: doc['variationId'] as String,
          id: doc['id'] as String ,
        ))

            .toList();
        print("--------------------------------------------------------------------------------------");
        return dataList;

      } else {
        return null;
      }
    } catch (e) {
      print('Error: $e');
      return null;
    }
  }
}


