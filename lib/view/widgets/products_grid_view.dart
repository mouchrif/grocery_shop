import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:grocery_shop/constants.dart';
import 'package:grocery_shop/data/controller/category_controller.dart';
import 'package:grocery_shop/model/product_model.dart';
import 'package:grocery_shop/view/widgets/btn_add_grid_list.dart';
import 'package:grocery_shop/view/widgets/custom_price_widget.dart';
import 'package:grocery_shop/view/widgets/heart_widget.dart';

class ProductsGridViewWidget extends StatelessWidget {
  final List<Product> products;
  final CategoryController? controller;
  final Size size;
  const ProductsGridViewWidget({
    Key? key,
    required this.products,
    required this.size,
    this.controller,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StaggeredGridView.countBuilder(
      padding: const EdgeInsets.only(top: 10),
      physics: const BouncingScrollPhysics(),
      crossAxisCount: 2,
      crossAxisSpacing: 14,
      mainAxisSpacing: 14,
      itemCount: products.length,
      itemBuilder: (context, index) {
        return LayoutBuilder(
          builder: (context, constraints) => Container(
            decoration: BoxDecoration(
              color: controller!
                  .getColorOfProductCategory(products, products[index]),
              borderRadius: BorderRadius.circular(kDefaultBorderRadius * 2),
            ),
            child: Stack(
              children: [
                Positioned(
                  top: constraints.maxHeight*0.04,
                  right: constraints.maxWidth*0.06,
                  child: HeartIconWidget(
                    product: products[index],
                  ),
                ),
                BtnAddGridListProduct(
                    size:size,
                    product: products[index],
                    color: controller!
                        .getColorOfProductCategory(products, products[index])),
                Positioned(
                  top: constraints.maxHeight/3 - constraints.maxHeight*0.5/2,
                  left: size.width*0.1,
                  right: size.width*0.1,
                  child: Hero(
                    tag: products[index].imagePath,
                    child: Image.network(
                      products[index].imagePath,
                      height: constraints.maxHeight*0.5,
                    ),
                  ),
                ),
                Positioned(
                  left: constraints.maxWidth*0.06,
                  bottom: constraints.maxHeight*0.08,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        products[index].name,
                        style: Theme.of(context).textTheme.headline6,
                      ),
                      SizedBox(height: constraints.maxHeight*0.02,),
                      CustomPriceWidget(text: "${products[index].price}/Kg"),
                    ],
                  ),
                ),
              ],
            ),
          ), 
        );
      },
      staggeredTileBuilder: (index) {
        return StaggeredTile.count(1, index.isOdd ? 1.7 : 1.5);
      },
    );
  }
}
