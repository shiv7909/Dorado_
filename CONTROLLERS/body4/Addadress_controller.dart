import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';

class AddAddressController extends GetxController {
  // Rx<Map<String, dynamic>?> latestAddress = Rx<Map<String, dynamic>?>(null);
  RxList<Map<String, dynamic>> addressList = <Map<String, dynamic>>[].obs;
  RxInt selectedIndex = 0.obs;

  Future<void> addAddress(String name, String hno, String locality, String town,
      String state, String phoneNumber, String pincode) async {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Map<String, dynamic> newAddress = {
        'name': name,
        'house-number': hno,
        'locality/colony': locality,
        'city/town/village': town,
        'state': state,
        'phoneNumber': phoneNumber,
        'pinCode': pincode,
      };

      await FirebaseFirestore.instance
          .collection('Users')
          .doc(user.uid)
          .update({
        'addresses.${DateTime.now().millisecondsSinceEpoch}': newAddress
      }).then((value) {
        print("Address and phone number added successfully");
      }).catchError((error) {
        print("Failed to add address and phone number: $error");
      });
    } else {
      print("No user logged in");
    }
  }
  //
  // void setSelectedIndex(int index) {
  //   selectedIndex.value = index;
  // }

  Future<void> fetchLatestAddress() async {
    final User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      final DocumentSnapshot<Map<String, dynamic>> snapshot =
          await FirebaseFirestore.instance
              .collection('Users')
              .doc(user.uid)
              .get();

      if (snapshot.exists) {
        print("existssss");
        final Map<String, dynamic> userData = snapshot.data()!;
        final Map<String, dynamic>? addresses =
            userData['addresses'] as Map<String, dynamic>?;

        if (addresses != null && addresses.isNotEmpty) {
          final List<Map<String, dynamic>> tempAddressList = [];
          addresses.forEach((key, value) {
            tempAddressList.add(value as Map<String, dynamic>);
          });
          // tempAddressList.sort((a,b) =>
          //     int.parse(b['timestamp']).compareTo(int.parse(a['timestamp'])));
          addressList.value =
              tempAddressList; // Use value property to assign the list
        } else {
          addressList.clear();
        }
      } else {
        addressList.clear();
      }
    } else {
      addressList.clear();
    }
  }
}
