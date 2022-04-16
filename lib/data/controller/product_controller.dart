import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:grocery_shop/data/service/firebase_services.dart';
import 'package:grocery_shop/model/bag_model.dart';
import 'package:grocery_shop/model/product_model.dart';
import 'package:grocery_shop/view/screens/favorites_screen.dart';
import 'package:grocery_shop/view/screens/forgot_password_screen.dart';
import 'package:grocery_shop/view/screens/profile_details_screen.dart';

class ProductController extends GetxController {
  FirebaseServices fbService = FirebaseServices();
  final List<Product> _products = <Product>[].obs;
  final List<Product> _filtredProducts = <Product>[].obs;
  List<Product> _favoritesProducts = <Product>[].obs;

  final _nbrOfFavorites = 0.obs;
  int getNbrOfFavorites() => _nbrOfFavorites.value;

  final _isGrid = true.obs;
  final _quantity = 1.obs;

  List<Product> getProducts() => _products;
  List<Product> getFiltredProducts() => _filtredProducts;
  List<Product> getFavoritesProducts() => _favoritesProducts;

  bool getIsGrid() => _isGrid.value;
  void setIsGrid(bool status) => _isGrid.value = status;
  int getQuantity() => _quantity.value;

  void incQte() {
    _quantity.value++;
  }

  void decQte() {
    if (_quantity.value > 1) {
      _quantity.value--;
    } else {
      _quantity.value = 1;
    }
  }

  int getNbrOfItem(String catName) {
    List<Product> prods = _products
        .where((product) => product.category.contains(catName))
        .toList();
    return prods.length;
  }

  Stream<QuerySnapshot> getProductsFromFirestore() {
    return fbService.getProductsFromFirestore();
  }

  void resetProducts() {
    _products.clear();
  }

  void addToProducts(List<QueryDocumentSnapshot<Object?>> list) {
    resetProducts();
    for (var element in list) {
      var map = element.data() as Map<String, dynamic>;
      Product product = Product.fromJson(map);
      _products.add(product);
    }
  }

  Future<String> upDateProduct(String prodName, bool status) async {
    return await fbService.upDateProduct(prodName, status);
  }

  // List<Product> filterProducts(Category category) {
  //   return _products.where((product) => product.category.contains(category.name.toLowerCase())).toList();
  // }

  List<Product> filtredProducts(String name, String filterName) {
    List<Product> filteredProducts = _products
        .where((product) => product.category.contains(name.toLowerCase()))
        .toList();
    for (var product in filteredProducts) {
      _filtredProducts.add(product);
    }
    return filteredProducts
        .where((product) => product.name.contains(filterName))
        .toList();
  }

  void favoritesProducts() {
    _favoritesProducts =
        _products.where((product) => product.isFavorite).toList();
    _nbrOfFavorites.value = _favoritesProducts.length;
  }

  void getSpecificScreen(int index, Map<String, dynamic> link) {
    if (index == 0) {
      Get.to(
        () => const ProfileDetailsScreen(),
        transition: Transition.fade,
      );
    } else if (index == 1) {
      Get.to(() => const FavoritesScreen(),
          transition: Transition.fade,
          arguments: {
            "index": index,
            "links": link,
            "favorites": getFavoritesProducts()
          });
    } else if (index == 3) {
      Get.to(
        () => const ForgotPasswordScreen(),
        transition: Transition.fade,
      );
    } else {
      return;
    }
  }

  Future<void> addBag(String userId, BagModel bag) async {
    await fbService.addBag(userId, bag);
  }

  // List<Product> toObject(List<QueryDocumentSnapshot> list) {
  //   List<Product> products = [];
  //   for (var el in list) {
  //     Map<String, dynamic> data = el.data()! as Map<String, dynamic>;
  //     Product product = Product.fromJson(data);
  //     products.add(product);
  //   }
  //   return products;
  // }

}
