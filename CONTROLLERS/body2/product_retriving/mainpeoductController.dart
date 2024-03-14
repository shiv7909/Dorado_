




import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';

import '../../../MODELS/body2.dart/mainproductModel.dart';


class ParticularProductController extends GetxController {
  final RxList<ParticularProduct> products = <ParticularProduct>[].obs;
  final RxBool isLoading = true.obs;
  final RxBool hasError = false.obs;
  final RxString errorMsg = ''.obs;


  @override
  void onInit() {
    super.onInit();
    ever(products, (_) {
      // Handle product list changes
      updateUI();
    });
  }

  void updateUI() {
    isLoading.value = false; // Update loading state
    hasError.value = false; // Reset error state
  }

  Future<void> findProductDocument(String productId, String variationId) async {
    try {
      final parts = productId.split('-');
      final gender = parts[0][0] == '1' ? 'Men' : 'Women';
      final categoryCode = parts[1];
      String documentCode = parts[2];
      String category = parts[3];
      products.clear();

      switch (categoryCode) {
        case '21':
          category = 'Footwear';
          switch (parts[2]) {
            case '001':
              documentCode = 'All';
            default:
              break;
          }
          break;



        case '22':
          category = 'Overlays';
          switch (parts[2]) {
            case '001':
              documentCode = 'Hoodies';
              break;
            case '002':
              documentCode = 'Jackets';
              break;
            case '003':
              documentCode = 'Sweatshirts';
              break;
          // Add cases for other overlay subcategories if needed
            default:
            // Handle unknown document code for overlays
              break;
          }
          break;


        case '24':
          category = 'Pants';
          switch (parts[2]) {
            case '001':
              documentCode = 'Cargo';
              break;
            case '002':
              documentCode = 'Formal';
              break;
            case '003':
              documentCode = 'Jeans';
              break;
            case '004':
              documentCode = 'Joggers';
              break;
            default:
            // Handle unknown document code for footwear
              break;
          }
          break;


        case '25':
          category = 'Shirts';
          switch (parts[2]) {
            case '001':
              documentCode = 'Checks';
              break;
            case '002':
              documentCode = 'Oversize';
              break;
            case '003':
              documentCode = 'Overshirt';
              break;
            case '004':
              documentCode = 'Plain';
              break;
            default:
            // Handle unknown document code for footwear
              break;
          }
          break;


        case '23':
          category = 'TShirts';
          switch (parts[2]) {
            case '001':
              documentCode = 'Basic';
              break;
            case '002':
              documentCode = 'Graphic';
              break;
            case '003':
              documentCode = 'Oversize';
              break;
            case '004':
              documentCode = 'Polo';
              break;
            default:
            // Handle unknown document code for footwear
              break;
          }
          break;

        case '26':
          category = 'Perfumes';
          switch (parts[2]) {
            case '001':
              documentCode = 'All';
            default:
            // Handle unknown document code for footwear
              break;
          }
          break;


        default:
          break;
      }



      final productDocRef = FirebaseFirestore.instance
          .collection('Total_Products')
          .doc(gender)
          .collection(category)
          .doc(documentCode)
          .collection('products')
          .doc(productId);

      final productDocSnapshot = await productDocRef.get();

      if (productDocSnapshot.exists) {
        final productData = productDocSnapshot.data() as Map<String, dynamic>;

        final id = productData['id'] ?? '';
        final title = productData['Title'] ?? '';
        final description = productData['Description'] ?? '';
        final colorsDynamic = productData['Colors'] ?? <dynamic>[];
        final List<String> colors = colorsDynamic.cast<String>();

        final variationRef = productDocRef.collection('variations').doc(variationId);
        final variationDocSnapshot = await variationRef.get();

        if (variationDocSnapshot.exists) {
          final variationData = variationDocSnapshot.data() as Map<String, dynamic>;
          final Varid = variationData['vid'] ?? '';
          final oprice = variationData['oprice'] ?? 0;
          final nprice = variationData['nprice'] ?? 0;
          final color = variationData['color'] ?? '';
          final discount = variationData['discount'] ?? 0;
          final DimensionalModle = variationData['DimensionalModle'] ?? 0;
          final List<String> images = variationData['images'] != null ? List.from(variationData['images']) : [];
          final quantity = variationData['Quantity'] ?? 0;
          final Map<String, dynamic> sizesData = variationData['sizes'] ?? {};
          final List<SizeInfo> sizesList = sizesData.entries.map((entry) {
            final sizeInfo = entry.value as Map<String, dynamic>;
            final size = sizeInfo['size'] as String;
            final availableItems = sizeInfo['availableItems'] as int;
            return SizeInfo(
              size: size,
              availableItems: availableItems,
            );
          }).toList();

          final product = ParticularProduct(
            id: id,
            oprice: oprice,
            nprice: nprice,
            discount: discount,
            color: color,
            Quantity: quantity,
            Title: title,
            Description: description,
            images: images,
            sizes: sizesList,
            varid: Varid,
            colors: colors,
              DimensionalModle:DimensionalModle,
          );

          products.add(product);
          isLoading.value = false;
        } else {
          print('Variation document not found');
        }
      } else {
        print('Product document not found');
      }
    } catch (error) {
      print('Error finding product document: $error');
      // Handle errors
    }
  }




}