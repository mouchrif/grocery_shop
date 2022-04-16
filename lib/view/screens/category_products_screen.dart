import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_shop/constants.dart';
import 'package:grocery_shop/data/controller/category_controller.dart';
import 'package:grocery_shop/data/controller/product_controller.dart';
import 'package:grocery_shop/data/controller/text_form_feltring_controller.dart';
import 'package:grocery_shop/model/product_model.dart';
import 'package:grocery_shop/view/widgets/menu_icon_row.dart';
import 'package:grocery_shop/view/widgets/products_grid_view.dart';
import 'package:grocery_shop/view/widgets/products_list_view_widget.dart';
import 'package:grocery_shop/view/widgets/search_row.dart';
import 'package:grocery_shop/view/widgets/shopping_and_bach.dart';

class CategoryProductsScreen extends StatelessWidget {
  const CategoryProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final Size size = MediaQuery.of(context).size;
    final categoryIndexMap = Get.arguments as Map<String, dynamic>;
    final categoryIndex = categoryIndexMap['index'];
    final productCtrlr = Get.find<ProductController>();
    final textFieldCtrlr = Get.find<FiletringTextForm>();
    final catCtrlr = Get.find<CategoryController>();
    return Scaffold(
      body: Padding(
        padding: padding(statusBarHeight, rightPadding: false),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ShoppintAndBack(
              isRight: true,
            ),
            SizedBox(
              height: size.height * 0.015,
            ),
            SearchRow(
              size: size,
              hintText: "Search Fresh Fruits",
              isRight: true,
            ),
            SizedBox(
              height: size.height * 0.015,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Row(
                children: [
                  ...List.generate(
                    catCtrlr.getCategories().length,
                    (index) => Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Column(
                          children: [
                            Container(
                              padding: EdgeInsets.all(kSize10),
                              decoration: BoxDecoration(
                                color: catCtrlr.getCategories()[index].color,
                                borderRadius:
                                    BorderRadius.circular(kDefaultBorderRadius),
                              ),
                              child: Center(
                                child: Image.network(
                                  catCtrlr.getCategories()[index].imagePath,
                                  width: size.width * 0.1,
                                ),
                              ),
                            ),
                            SizedBox(height: size.height * 0.006),
                            Text(
                              catCtrlr.getCategories()[index].name,
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ],
                        ),
                        SizedBox(width: size.width * 0.02),
                      ],
                    ),
                  ),
                ],
              ),
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            AllAndMenuIconRowWidget(
              text: catCtrlr
                      .getCategories()[categoryIndex]
                      .name
                      .substring(1,
                          catCtrlr.getCategories()[categoryIndex].name.length)
                      .contains("s")
                  ? "All Fresh ${catCtrlr.getCategories()[categoryIndex].name}"
                  : "All Fresh ${catCtrlr.getCategories()[categoryIndex].name}s",
              prefix: Container(
                padding: EdgeInsets.all(kSize6),
                decoration: BoxDecoration(
                  color: catCtrlr.getCategories()[categoryIndex].color,
                  borderRadius: BorderRadius.circular(kDefaultBorderRadius),
                ),
                child: Center(
                  child: Image.network(
                    catCtrlr.getCategories()[categoryIndex].imagePath,
                    width: size.width * 0.06,
                  ),
                ),
              ),
              isIconExist: true,
            ),
            SizedBox(
              height: size.height * 0.01,
            ),
            Expanded(
              child: Padding(
                padding: rightPadding(isRight: true),
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
                      List<Product> filterProd = productCtrlr.filtredProducts(
                        catCtrlr
                            .getCategories()[categoryIndex]
                            .name
                            .toLowerCase(),
                        textFieldCtrlr.filteringWord.value,
                      );
                      return Obx(
                        () => Container(
                          child: productCtrlr.getIsGrid()
                              ? ProductsGridViewWidget(
                                  products: filterProd,
                                  size: size,
                                  controller: catCtrlr,
                                )
                              : ProductListViewWidget(
                                  products: filterProd,
                                  size: size,
                                  controller: catCtrlr,
                                ),
                        ),
                      );
                    }
                  },
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
