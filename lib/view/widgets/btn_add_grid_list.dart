import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:grocery_shop/constants.dart';
import 'package:grocery_shop/model/product_model.dart';
import 'package:grocery_shop/view/screens/product_details_screen.dart';

class BtnAddGridListProduct extends StatelessWidget {
  final Product product;
  final Color color;
  final Size size;
  const BtnAddGridListProduct(
      {Key? key, required this.size, required this.product, required this.color})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.bottomRight,
      child: InkWell(
        onTap: () {
          Get.to(
            () => const ProductDetailsScreen(),
            transition: Transition.fade,
            arguments: {'product': product, 'color': color},
          );
        },
        child: Container(
          height: size.height * 0.07,
          width: size.width * 0.18,
          decoration: BoxDecoration(
            color: Theme.of(context).primaryColor,
            borderRadius: BorderRadius.only(
              topLeft: Radius.circular(kDefaultBorderRadius * 2),
              bottomRight: Radius.circular(kDefaultBorderRadius * 2),
            ),
          ),
          child: const Center(
            child: Icon(
              FontAwesomeIcons.plus,
              color: kWhiteColor,
            ),
          ),
        ),
      ),
    );
  }
}
