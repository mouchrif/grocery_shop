import 'package:flutter/material.dart';
import 'package:grocery_shop/constants.dart';
import 'package:grocery_shop/data/controller/category_controller.dart';
import 'package:grocery_shop/model/product_model.dart';
import 'package:grocery_shop/view/widgets/btn_add_grid_list.dart';
import 'package:grocery_shop/view/widgets/custom_price_widget.dart';
import 'package:grocery_shop/view/widgets/heart_widget.dart';

class HorizontalListView extends StatelessWidget {
  final List<Product> products;
  final CategoryController? controller;
  final Size size;
  const HorizontalListView(
      {Key? key, required this.products, this.controller, required this.size})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) => ListView.builder(
        scrollDirection: Axis.horizontal,
        physics: const BouncingScrollPhysics(),
        itemCount: products.length,
        itemBuilder: (context, index) => Row(
          children: [
            Container(
                // width: size.width*0.48,
                width: constraints.maxWidth*0.48,
                decoration: BoxDecoration(
                  color: controller!.getColorOfProductCategory(products, products[index]),
                  borderRadius: BorderRadius.circular(kDefaultBorderRadius * 2),
                ),
                child: Stack(
                  children: [
                    Positioned(
                      top: constraints.maxHeight*0.04,
                      right: constraints.maxWidth*0.03,
                      child: HeartIconWidget(
                        product: products[index],
                        radius: constraints.maxHeight*0.07,
                      ),
                    ),
                    BtnAddGridListProduct(
                        size:size,
                        product: products[index],
                        color: controller!.getColorOfProductCategory(products, products[index]),
                    ),
                    Positioned(
                      top: constraints.maxHeight*0.12,
                      left: constraints.maxWidth*0.1,
                      right: constraints.maxWidth*0.1,
                      child: Hero(
                        tag: products[index].imagePath,
                        child: Image.network(
                          products[index].imagePath,
                          height: constraints.maxHeight*0.35,
                        ),
                      ),
                    ),
                    Positioned(
                      left: constraints.maxWidth*0.06,
                      bottom: constraints.maxHeight*0.06,
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            products[index].name,
                            style: Theme.of(context).textTheme.headline6,
                          ),
                          // SizedBox(height: size.height*0.00),
                          CustomPriceWidget(text: "${products[index].price}/Kg"),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
              SizedBox(width: kDefaultPadding),
          ],
        ), 
      ),
    );
  }
}
