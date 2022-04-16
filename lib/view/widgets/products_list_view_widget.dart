import 'package:flutter/material.dart';
import 'package:grocery_shop/constants.dart';
import 'package:grocery_shop/data/controller/category_controller.dart';
import 'package:grocery_shop/model/product_model.dart';
import 'package:grocery_shop/view/widgets/btn_add_grid_list.dart';
import 'package:grocery_shop/view/widgets/custom_price_widget.dart';
import 'package:grocery_shop/view/widgets/heart_widget.dart';

class ProductListViewWidget extends StatelessWidget {
  final List<Product> products;
  final Size size;
  final CategoryController? controller;
  const ProductListViewWidget(
      {Key? key, required this.products, required this.size, this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.only(top: size.height*0.01),
      itemCount: products.length,
      itemBuilder: (context, index) => Column(
        children: [
          Container(
            width: size.width,
            height: size.height * 0.2,
            decoration: BoxDecoration(
              color: controller!.getColorOfProductCategory(products, products[index]),
              borderRadius: BorderRadius.circular(kDefaultBorderRadius * 2),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: size.height*0.015,
                  right: size.width*0.03,
                  child: HeartIconWidget(
                    product: products[index],
                  ),
                ),
                BtnAddGridListProduct(
                    size: size,
                    product: products[index],
                    color: controller!.getColorOfProductCategory(products, products[index]),
                ),
                Positioned(
                  top: (size.height * 0.2 - size.height * 0.12) / 2,
                  left: size.width*0.02,
                  child: Hero(
                    tag: products[index].imagePath,
                    child: Image.network(
                      products[index].imagePath,
                      height: size.height * 0.1,
                    ),
                  ),
                ),
                Positioned(
                  top: (size.height * 0.2) / 2 - kDefaultPadding * 2,
                  left: size.width * 0.38,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        products[index].name,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      SizedBox(height: size.height*0.01),
                      CustomPriceWidget(text: "${products[index].price}/Kg"),
                    ],
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: size.height*0.015),
        ],
      ),
    );
  }
}
