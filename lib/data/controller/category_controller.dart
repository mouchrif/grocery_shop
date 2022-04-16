import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_shop/data/controller/product_controller.dart';
import 'package:grocery_shop/data/service/firebase_services.dart';
import 'package:grocery_shop/model/category_model.dart';
import 'package:grocery_shop/model/product_model.dart';

class CategoryController extends GetxController {
  final FirebaseServices fbService = FirebaseServices();
  final productCtrlr = Get.put(ProductController());

  List<Category> _categories = <Category>[].obs;
  List<Category> getCategories() => _categories;

  final RxInt _currentPage = 0.obs;
  int getCurrentPage() => _currentPage.value;
  void setCurrentPage(int index) => _currentPage.value = index;

  final _isNotMatche = false.obs;
  bool getIsNotMatch() => _isNotMatche.value;

  String? name;

  void addToCategories(List myMap) {
    List maps = myMap;
    _categories = maps.map((map) => Category.fromJson(map)).toList();
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getCategoriesFromFb() {
    return fbService.getCategoriesFromFirebase();
  }

  List<Category> filtredCategories(String name) {
    List<Category> filterCategories = _categories
        .where((category) =>
            category.name.toLowerCase().contains(name.toLowerCase()))
        .toList();
    if (filterCategories.isEmpty) {
      _isNotMatche.value = true;
    } else {
      _isNotMatche.value = false;
    }
    return filterCategories;
  }

  Color getColorOfProductCategory(List<Product> products, Product product) {
    Product mProduct = products.firstWhere((prod) => prod.name == product.name);
    Category cat = _categories.firstWhere((category) => mProduct.category.any(
        (el) => el.toString().toLowerCase() == category.name.toLowerCase()));
    return cat.color;
  }

  Future<List<Category>> getAllCategoriesFromFirebase(String name) async {
    List<Category> categories = [];
    List<dynamic> categoriesData =
        await fbService.getAllCategoriesFromFirebase();
    for (var category in categoriesData) {
      Category catObj = Category.fromJson(category);
      categories.add(catObj);
    }
    _categories =
        categories.where((category) => category.name.contains(name)).toList();
    return _categories;
  }

  // @override
  // void onInit() async {
  //   super.onInit();
  //   // await getAllCategoriesFromFirebase();
  //   // await productCtrlr.getAllProducts();
  // }
}
