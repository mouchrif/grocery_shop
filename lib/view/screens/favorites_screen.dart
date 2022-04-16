import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_shop/data/controller/category_controller.dart';
import 'package:grocery_shop/data/controller/product_controller.dart';
import 'package:grocery_shop/model/product_model.dart';
import 'package:grocery_shop/view/widgets/products_grid_view.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final args = Get.arguments as Map<String, dynamic>;
    final Size size = MediaQuery.of(context).size;
    final productCtrlr = Get.find<ProductController>();
    final catCtrlr = Get.find<CategoryController>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        leading: BackButton(
          onPressed: () {
            Get.back();
          },
        ),
        title: Text(args['links']['text']),
        centerTitle: true,
      ),
      body: Padding(
        padding: EdgeInsets.only(
          top: size.height * 0.01,
          left: size.width * 0.04,
          right: size.width * 0.04,
        ),
        child: StreamBuilder(
          stream: productCtrlr.getProductsFromFirestore(),
          builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
            if (!snapshot.hasData) {
              return Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ),
              );
            } else {
              var data = snapshot.data!.docs;
              productCtrlr.addToProducts(data);
              productCtrlr.favoritesProducts();
              List<Product> favoritesProducts = productCtrlr.getFavoritesProducts();
              return productCtrlr.getNbrOfFavorites().isEqual(0)
              ? const Center(child: Text("Favorites is empty"),)
              : ProductsGridViewWidget(
                products: favoritesProducts,
                size: size,
                controller: catCtrlr,
              );
            }
          },
        ),
      ),
    );
  }
}
