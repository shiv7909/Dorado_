import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

import 'CONTROLLERS/body2/product_retriving/product_controller.dart';
import 'CONTROLLERS/body4/Addadress_controller.dart';
import 'CONTROLLERS/body2/Categories_navigation.dart';
import 'CONTROLLERS/body1/Title_retriver_controller.dart';
import 'CONTROLLERS/body1/Advertisement_controller.dart';
import 'CONTROLLERS/body4/auth_controller.dart';
import 'MODELS/constants.dart';

import 'VIEWS/signin,login,intro/Login_page.dart';
import 'VIEWS/MainHome.dart';
import 'VIEWS/signin,login,intro/introvedio.dart';
import 'VIEWS/signin,login,intro/splashbind.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
      options: FirebaseOptions(
          apiKey: "AIzaSyBFHE8yzqsMfWqKiuAQW7QSo937JGQAn9o",
          appId: "1:50613708252:android:6c126f64d1cd288d131b19",
          messagingSenderId: "50613708252",
          projectId: "groots-77ea3"));

  NavigationController _navigationController = Get.put(NavigationController());
  _navigationController.fetchNavigationItems();

  ProductController productController = Get.put(ProductController());
   productController.fetchProductsFromPanel('Featuring_panel');

  AddAddressController fetchaddress = Get.put(AddAddressController());
  fetchaddress.fetchLatestAddress();

  Title_retriever titleRetriever = Get.put(Title_retriever());

  Advertisement_controller announcementController = Get.put(Advertisement_controller());

  final authController = Auth_controller();
  Get.put(authController, permanent: true);

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'DORADO',
      theme: ThemeData(
        scaffoldBackgroundColor: kBackgroundcolor,
        primaryColor: kPrimarycolor,
        textTheme: Theme.of(context).textTheme.apply(bodyColor: kTextcolor),
        visualDensity: VisualDensity.adaptivePlatformDensity,
      ),
      initialBinding: UserCheckBinding(), //Use the SplashBinding
      initialRoute: '/splash',
      getPages: [
        GetPage(
          name: '/splash',
          page: () => VideoSplashScreen(),
        ),
        GetPage(name: '/login', page: () => SignInScreen()),
        GetPage(name: '/home', page: () => Main_Homes_builder()),
      ],
    );
  }
}
