import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:grocery_shop/constants.dart';
import 'package:grocery_shop/data/controller/auth_controller.dart';
import 'package:grocery_shop/data/controller/category_controller.dart';
import 'package:grocery_shop/data/controller/product_controller.dart';
import 'package:grocery_shop/view/screens/categories_screen.dart';
import 'package:grocery_shop/view/widgets/app_bar_builder.dart';
import 'package:grocery_shop/view/widgets/horizontal_list_categories.dart';
import 'package:grocery_shop/view/widgets/horizontal_list_view.dart';
import 'package:grocery_shop/view/widgets/menu_icon_row.dart';
import 'package:grocery_shop/view/widgets/text_form_field.dart';

class HomeScreen extends GetWidget<CategoryController> {
  const HomeScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final Size size = MediaQuery.of(context).size;
    final productCtrlr = Get.find<ProductController>();
    final authCtrlr = Get.find<AuthController>();
    return Padding(
      padding: padding(statusBarHeight, rightPadding: false),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          AppBarBuilder(
            leading: CircleAvatar(
              radius: size.height * 0.03,
              backgroundImage: const AssetImage("assets/images/profile.png"),
            ),
            title: FutureBuilder(
                future: authCtrlr.getUserFromFireStore(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.hasData) {
                    return Text(
                      "${snapshot.data.name}'s Home",
                      style: Theme.of(context).textTheme.headline6!.copyWith(
                            color: Colors.grey.shade500,
                            fontSize: kSize18,
                          ),
                    );
                  } else {
                    return const Text("");
                  }
                }),
            // Obx(
            //   () => Text(
            //     "${authCtrlr.getUser().name}'s Home",
            //     style: Theme.of(context).textTheme.headline6!.copyWith(
            //           color: Colors.grey.shade500,
            //           fontSize: 18.0,
            //         ),
            //   ),
            // ),
            action: IconButton(
              onPressed: () {},
              icon: const Icon(FontAwesomeIcons.solidBell),
            ),
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          Row(
            children: [
              FutureBuilder(
                  future: authCtrlr.getUserFromFireStore(),
                  builder: (context, AsyncSnapshot snapshot) {
                    if (snapshot.hasData) {
                      return Text(
                        "Hey ${snapshot.data.name}",
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                      );
                    } else {
                      return const Text("");
                    }
                  }),
              // Obx(
              //   () => Text(
              //     "Hey ${authCtrlr.getUser().name}",
              //     style:
              //         Theme.of(context).textTheme.headline5!.copyWith(
              //               color: Theme.of(context).primaryColor,
              //               fontWeight: FontWeight.bold,
              //             ),
              //   ),
              // ),
              SizedBox(width: kSize6),
              Text(
                "👏",
                style: Theme.of(context).textTheme.headline5,
              ),
            ],
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          Text(
            "Find fresh groceries you want",
            style: Theme.of(context).textTheme.bodyText2,
          ),
          SizedBox(
            height: size.height * 0.02,
          ),
          const TextFormFieldWidget(
            hintText: "Search fresh groceries",
            isRight: true,
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          AllAndMenuIconRowWidget(
            text: "Categories",
            txt: "See all",
            isRight: true,
            onPressed: () {
              Get.to(
                () => const CategoriesScreen(),
                transition: Transition.fade,
              );
            },
          ),
          SizedBox(
            height: size.height * 0.01,
          ),
          CategoriesHorizontalList(
            controller: controller,
            size: size,
          ),
          const AllAndMenuIconRowWidget(
            text: "Popular",
            isIconExist: false,
            txt: "",
          ),
          Expanded(
            child: Padding(
              padding: EdgeInsets.only(
                // right: kDefaultPadding,
                bottom: kDefaultPadding,
              ),
              child: SizedBox(
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
                      return productCtrlr.getFavoritesProducts().isNotEmpty
                          ? HorizontalListView(
                              products: productCtrlr.getFavoritesProducts(),
                              size: size,
                              controller: controller,
                            )
                          // ProductsGridViewWidget(
                          //     products:productCtrlr.getFavoritesProducts(),
                          //     size: size,
                          //     controller: controller,
                          //   )
                          : SizedBox(
                              width: size.width,
                              child: Center(
                                child: Text(
                                  "Your favorites is not added yet",
                                  textAlign: TextAlign.center,
                                  style: Theme.of(context).textTheme.bodyText1,
                                ),
                              ),
                            );
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
