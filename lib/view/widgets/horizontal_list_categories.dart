import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_shop/constants.dart';
import 'package:grocery_shop/data/controller/category_controller.dart';
import 'package:grocery_shop/data/controller/text_form_feltring_controller.dart';
import 'package:grocery_shop/model/category_model.dart';
import 'package:grocery_shop/view/widgets/item_not_found.dart';

class CategoriesHorizontalList extends StatelessWidget {
  final CategoryController controller;
  final Size size;
  const CategoriesHorizontalList(
      {Key? key, required this.controller, required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot<Map<String, dynamic>>>(
        stream: controller.getCategoriesFromFb(),
        builder: (context,
            AsyncSnapshot<QuerySnapshot<Map<String, dynamic>>> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(
                color: Theme.of(context).primaryColor,
              ),
            );
          } else {
            var data = snapshot.data!.docs.first;
            var maps = data.data();
            var myMap = maps['collections'] as List;
            controller.addToCategories(myMap);
            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              physics: const BouncingScrollPhysics(),
              child: Obx(
                () {
                  List<Category> filtredCategories =
                      controller.filtredCategories(
                          Get.find<FiletringTextForm>().filteringWord.value);
                  return controller.getIsNotMatch()
                  ? ItemIsNotFoundWidget(
                    size:size,
                    text: "Item not Found",
                  )
                  : Row(
                    children: [
                      ...List.generate(
                        filtredCategories.length,
                        (index) {
                          return Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              Column(
                                children: [
                                  Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                      color: filtredCategories[index].color,
                                      borderRadius: BorderRadius.circular(
                                          kDefaultBorderRadius),
                                    ),
                                    child: Center(
                                      child: Image.network(
                                        filtredCategories[index].imagePath,
                                        width: size.width * 0.12,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    filtredCategories[index].name,
                                    style:
                                        Theme.of(context).textTheme.bodyText1,
                                  ),
                                ],
                              ),
                              const SizedBox(width: 6),
                            ],
                          );
                        },
                      ).toList(),
                    ],
                  );
                },
              ),
            );
          }
        });
  }
}
