import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:grocery_shop/constants.dart';
import 'package:grocery_shop/data/controller/product_controller.dart';
import 'package:grocery_shop/model/product_model.dart';

class HeartIconWidget extends StatelessWidget {
  final Product product;
  final double? radius;
  const HeartIconWidget({Key? key, required this.product, this.radius})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productCtrlr = Get.find<ProductController>();
    return InkWell(
      onTap: () async {
        String message = await productCtrlr.upDateProduct(
            product.name, product.isFavorite ? false : true);
        Get.snackbar(
          "",
          "",
          titleText: const Text("👇"),
          messageText: Text(
            message,
            style: const TextStyle(color: kWhiteColor),
          ),
          snackPosition: SnackPosition.BOTTOM,
          backgroundColor:
              message.contains("successfuly") ? kPrimaryColor : kHeartColor,
        );
      },
      child: CircleAvatar(
        radius: radius,
        backgroundColor: product.isFavorite ? kHeartColor : kWhiteColor,
        child: Center(
          child: Icon(
            FontAwesomeIcons.solidHeart,
            color: product.isFavorite ? kWhiteColor : kHeartColor,
            size: radius != null ? radius! * 1.2 : kSize24,
          ),
        ),
      ),
    );
  }
}
