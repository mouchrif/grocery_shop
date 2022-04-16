import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_shop/animations/flip_card_animation.dart';
import 'package:grocery_shop/constants.dart';
import 'package:grocery_shop/data/controller/category_controller.dart';
import 'package:grocery_shop/data/controller/product_controller.dart';
import 'package:grocery_shop/data/controller/text_form_feltring_controller.dart';
import 'package:grocery_shop/view/screens/category_products_screen.dart';

class CategoriesGridViewBuilder extends StatelessWidget {
  const CategoriesGridViewBuilder({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categoryCtrlr = Get.find<CategoryController>();
    final productctrlr = Get.find<ProductController>();
    final textFieldCtrlr = Get.find<FiletringTextForm>();
    return GridView.builder(
      padding: const EdgeInsets.only(top: 0),
      physics: const BouncingScrollPhysics(),
      itemCount: categoryCtrlr.getCategories().length,
      gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        mainAxisSpacing: kDefaultPadding / 2,
        crossAxisSpacing: kDefaultPadding / 2,
      ),
      itemBuilder: (context, index) => LayoutBuilder(
        builder: (context, constraints) => GestureDetector(
          onTap: () {
            textFieldCtrlr.clearTextField();
            Get.to(
              () => const CategoryProductsScreen(),
              transition: Transition.fade,
              arguments: {"index": index},
            );
          },
          child: DelayedFlipCardItemsAnimation(
            delay: index,
            child: Card(
              color: categoryCtrlr.getCategories()[index].color,
              shape: RoundedRectangleBorder(
                borderRadius:
                    BorderRadius.circular(kDefaultBorderRadius * 1.8),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: constraints.maxHeight*0.12,
                  horizontal: constraints.maxWidth*0.08,
                ),
                child: Stack(
                  children: [
                    Align(
                      alignment: Alignment.topCenter,
                      child: SizedBox(
                        height: constraints.maxHeight * 0.45,
                        child: Image.network(
                          categoryCtrlr.getCategories()[index].imagePath,
                        ),
                      ),
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        Text(
                          categoryCtrlr.getCategories()[index].name,
                          style: Theme.of(context)
                              .textTheme
                              .headline6
                              ?.copyWith(
                                fontSize: 16,
                              ),
                        ),
                        Text(
                          productctrlr
                                  .getNbrOfItem(categoryCtrlr
                                      .getCategories()[index]
                                      .name
                                      .toLowerCase())
                                  .toString() +
                              " items",
                          style: Theme.of(context).textTheme.bodyText1,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
    /*
    StreamBuilder(
        stream: categoryCtrlr.getCategoriesFromFb(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            );
          } else {
              var data = snapshot.data?.docs.first;
              var maps = data!.data();
              var myMap = maps['collections'] as List;
              categoryCtrlr.addToCategories(myMap);
            return GridView.builder(
              padding: const EdgeInsets.only(top: 0),
              physics: const BouncingScrollPhysics(),
              itemCount: categoryCtrlr.getCategories().length,
              gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: kDefaultPadding / 2,
                crossAxisSpacing: kDefaultPadding / 2,
              ),
              itemBuilder: (context, index) => LayoutBuilder(
                builder: (context, constraints) => GestureDetector(
                  onTap: () {
                    textFieldCtrlr.clearTextField();
                    Get.to(
                      () => const CategoryProductsScreen(),
                      transition: Transition.fade,
                      arguments: {
                        "categories": categoryCtrlr.getCategories(),
                        "index": index
                      },
                    );
                  },
                  child: Card(
                    color: categoryCtrlr.getCategories()[index].color,
                    shape: RoundedRectangleBorder(
                      borderRadius:
                          BorderRadius.circular(kDefaultBorderRadius * 1.8),
                    ),
                    child: Padding(
                      padding: const EdgeInsets.all(kDefaultPadding / 1.2),
                      child: Stack(
                        children: [
                          Align(
                            alignment: Alignment.topCenter,
                            child: SizedBox(
                              height: constraints.maxHeight * 0.5,
                              child: Image.network(
                                categoryCtrlr.getCategories()[index].imagePath,
                              ),
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                categoryCtrlr.getCategories()[index].name,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline6
                                    ?.copyWith(
                                      fontSize: 16,
                                    ),
                              ),
                              Text(
                                productctrlr
                                        .getNbrOfItem(categoryCtrlr
                                            .getCategories()[index]
                                            .name
                                            .toLowerCase())
                                        .toString() +
                                    " items",
                                style: Theme.of(context).textTheme.bodyText1,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            );
          }
        }
      );
      */
    /*
    Obx(
      () => FutureBuilder(
          future: categoryCtrlr
              .getAllCategoriesFromFirebase(textFieldCtrlr.filteringWord.value),
          builder: (context, AsyncSnapshot snapshot) {
            if (snapshot.hasError) {
              return const Text("Something went wrong...");
            } else if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                    color: Theme.of(context).primaryColor),
              );
            } else {
              return GridView.builder(
                padding: const EdgeInsets.only(top: 0),
                physics: const BouncingScrollPhysics(),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  mainAxisSpacing: kDefaultPadding / 2,
                  crossAxisSpacing: kDefaultPadding / 2,
                ),
                itemCount: snapshot.data.length,
                itemBuilder: (context, index) => LayoutBuilder(
                  builder: (context, constraints) => GestureDetector(
                    onTap: () {
                      textFieldCtrlr.clearTextField();
                      Get.to(
                        () => const CategoryProductsScreen(),
                        transition: Transition.fade,
                        arguments: {
                          "categories": snapshot.data,
                          "index": index
                        },
                      );
                    },
                    child: Card(
                      color: snapshot.data[index].color,
                      shape: RoundedRectangleBorder(
                        borderRadius:
                            BorderRadius.circular(kDefaultBorderRadius * 1.8),
                      ),
                      child: Padding(
                        padding: const EdgeInsets.all(kDefaultPadding / 1.2),
                        child: Stack(
                          children: [
                            Align(
                              alignment: Alignment.topCenter,
                              child: SizedBox(
                                height: constraints.maxHeight * 0.5,
                                child: Image.network(
                                  snapshot.data[index].imagePath,
                                ),
                              ),
                            ),
                            Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Text(
                                  snapshot.data[index].name,
                                  style: Theme.of(context)
                                      .textTheme
                                      .headline6
                                      ?.copyWith(
                                        fontSize: 16,
                                      ),
                                ),
                                Obx(
                                  () => Text(
                                    productctrlr
                                            .getNbrOfItem(snapshot
                                                .data[index].name
                                                .toLowerCase())
                                            .toString() +
                                        " items",
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              );
            }
          }),
    );
    */
  }
}
