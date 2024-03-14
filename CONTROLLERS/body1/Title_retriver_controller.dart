


import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../MODELS/body1/Title_with_more_button_model.dart';

class Title_retriever extends GetxController {
  final Map<String, PageTitle> titles = {};

  Future<String> fetchTitle(String documentId) async {
    try {
      final DocumentSnapshot snapshot =
      await FirebaseFirestore.instance.collection('Titles').doc(documentId).get();
      if (snapshot.exists) {
        final Map<String, dynamic> data = snapshot.data() as Map<String, dynamic>;
        titles[documentId] = PageTitle.fromJson(data);
        return titles[documentId]?.title ?? '';
      }
      else {
        return '    ';
      }
    } catch (e) {
      print('Error fetching title: $e');
      return '';
    }
  }
}

