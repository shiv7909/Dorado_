// //



import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:untitled1/MODELS/cart_products_model.dart';

class Fav_Retrive_Controller extends GetxController {


  var isLoading = true.obs;
  var imageUrl = ''.obs;
  RxBool isCartEmpty = true.obs;
  var FavProducts = <CartProduct>[].obs;



  Future<void> fetchProducts() async {
    FavProducts.clear();
    FavProducts.clear();

    final User? user = FirebaseAuth.instance.currentUser;
    if (user == null) {
      print("user unauthenticated");
      isCartEmpty.value = true;
      isLoading.value=false;
      // Product_incre_decre.isCartEmpty.value=true;
      return;
    }

    CollectionReference cartCollection = FirebaseFirestore.instance
        .collection('Users')
        .doc(user.uid)
        .collection('Favorites');

    try {
      QuerySnapshot cartSnapshot = await cartCollection.get();
      if (cartSnapshot.docs.isEmpty) {
        isCartEmpty.value = true;
        isLoading.value=false;
        return;
      } else {
        // isCartEmpty.value = false;

        for (QueryDocumentSnapshot cartDoc in cartSnapshot.docs) {
          final productId = cartDoc['id'] as String;
          final variationId = cartDoc['variance_id'] as String;
          final size = cartDoc['size'];
          await findProductDocument(productId, variationId, size);
          updateUI();
        }
        isLoading.value=false;
        isCartEmpty.value=false;
      }
    } catch (error) {
      print('Error fetching products from panel: $error');
      // Handle errors
    }
  }


  Future<void> findProductDocument(String productId, String variationId,String size) async {
    try {
      final parts = productId.split('-');
      final gender = parts[0][0] == '1' ? 'Men' : 'Women';
      print(parts[0]);
      print(parts[1]);
      print(parts[2]);
      print(parts[3]);
      final categoryCode = parts[1];
      String documentCode=parts[2];
      String category=parts[3];

      switch (categoryCode) {
        case '21':
          category = 'Footwear';
          switch (parts[2]) {
            case '001':
              documentCode = 'Casual';
              break;
            case '002':
              documentCode = 'Running';
              break;
            case '003':
              documentCode = 'Sliders';
              break;
            case '004':
              documentCode = 'Sneakers';
              break;
            default:
            // Handle unknown document code for footwear
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
        default:
          break;
      }

      final productDocRef = FirebaseFirestore.instance
          .collection('Total_Products')
          .doc(gender)
          .collection(category)
          .doc(documentCode)
          .collection('products')
          .doc(productId); // Directly access the document using productId as the document ID

      final productDocSnapshot = await productDocRef.get();

      if (productDocSnapshot.exists) {
        print('product exists hureyyyyyyyyyyyyyyy');
        final productData = productDocSnapshot.data() as Map<String, dynamic>;

        final id = productData['id'] ?? '';
        final title = productData['Title'] ?? '';
        final description = productData['Description'] ?? '';

        final variationRef = productDocRef.collection('variations').doc(variationId);

        final variationDocSnapshot = await variationRef.get();

        if (variationDocSnapshot.exists) {

          final variationData = variationDocSnapshot.data() as Map<
              String,
              dynamic>;


          int getAvailableQuantityForSize(Map<String, dynamic> variationData, String size) {
            final sizes = variationData['sizes'] as Map<String, dynamic>?;

            if (sizes != null) {
              for (final entry in sizes.entries) {
                final sizeData = entry.value as Map<String, dynamic>;
                if (sizeData['size'] == size) {
                  return sizeData['availableItems'] ?? 0;
                }
              }
            }
            return 0;
          }

          int item_count = getAvailableQuantityForSize(variationData,size);
          print(item_count);


          final oprice = variationData['oprice'] ?? 0;
          final nprice = variationData['nprice'] ?? 0;
          final color = variationData['color'] ?? '';
          final discount = variationData['discount'] ?? 0;
          final image = variationData['image'] ?? ''; // Assuming image is a single string URL

          final Favproduct = CartProduct(
            id: id,
            oprice: oprice,
            nprice: nprice,
            discount: discount,
            color: color,
            imagepath: image,
            Title:title,
            Description: description,
            variationid: variationId,
            Quantity_in_cart: 0,
            size:size,
            Quantity_in_stock: item_count,
          );



          FavProducts.add(Favproduct);
          updateUI();
          // printProductDetails(Favproduct);
        } else {
          print('Variation document not found');
        }
      } else {
        print('Product document not found');
      }
    }
    catch (error) {
      print('Error finding product document: $error');
      // Handle errors
    }
  }



  void updateUI() {
    update();
  }


}

//
// void printProductDetails(CartProduct product) {
//   print('Product ID: ${product.id}');
//   print('Title: ${product.Title}');
//   print('Description: ${product.Description}');
//   print('colors: ${product.colors}');
//   print('OPrice: ${product.oprice}');
//   print('NPrice: ${product.nprice}');
//   print('Discount: ${product.discount}');
//   print('Color: ${product.color}');
//   print('Image Path: ${product.imagepath}');
//   print('Quantity: ${product.Quantity}');
//   print("colors: ${product.colors}");
//   print('----------------------------------------');
// }