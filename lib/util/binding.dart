import 'package:get/get.dart';
import 'package:grocery_shop/data/controller/auth_controller.dart';
import 'package:grocery_shop/data/controller/bag_controller.dart';
import 'package:grocery_shop/data/controller/connectivity_controller.dart';
import 'package:grocery_shop/data/controller/on_boarding_controller.dart';
import 'package:grocery_shop/data/controller/product_controller.dart';

class Binding implements Bindings {
  @override
  void dependencies() {
    Get.put(ConnectivityManager());
    Get.lazyPut(() => OnBoardingController());
    Get.put(AuthController());
    Get.put(ProductController());
    Get.lazyPut(() => BagController());
    // Get.lazyPut(() => CategoryController());
    // Get.lazyPut(() => FiletringTextForm());
    // Get.lazyPut(() => ProductController());
  }
}
