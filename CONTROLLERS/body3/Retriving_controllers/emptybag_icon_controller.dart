
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import '../../../MODELS/body3/Cart_icon_model.dart';

class Cart_Emptybag_IconController extends GetxController {
  final CollectionReference cartIconCollection =
  FirebaseFirestore.instance.collection('Carticon');



  Future<CartIcon?> getCartIcon() async {
    final documentSnapshot = await cartIconCollection.doc('Empty').get();
    if (documentSnapshot.exists) {
      final data = documentSnapshot.data() as Map<String, dynamic>;
      return CartIcon.fromMap(data);
    }
    return null; // Document doesn't exist
  }
}

