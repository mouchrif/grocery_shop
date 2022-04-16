import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_shop/constants.dart';
import 'package:grocery_shop/data/controller/product_controller.dart';

class CustomPriceWidget extends StatelessWidget {
  final String text;
  final Color? textColor;
  const CustomPriceWidget({Key? key, required this.text, this.textColor})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final str = text.contains("/") ? text.split('/') : [text, ""];
    final strPrice = str.first.split(".");
    final productCtrlr = Get.put(ProductController());
    return Obx(
      () => RichText(
        text: TextSpan(
          children: [
            TextSpan(
              text: "\$" + strPrice.first,
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: textColor ?? kPrimaryColor,
                    fontSize: productCtrlr.getIsGrid() ? 24 : 28,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            TextSpan(
              text: ".${strPrice.last.substring(0, 1)}",
              style: Theme.of(context).textTheme.headline6!.copyWith(
                    color: textColor ?? kPrimaryColor,
                    fontSize: productCtrlr.getIsGrid() ? 20 : 24,
                    fontWeight: FontWeight.bold,
                  ),
            ),
            TextSpan(
              text: text.contains('/') ? "/" + str.last : str.last,
              style: Theme.of(context).textTheme.bodyText1,
            ),
          ],
        ),
      ),
    );
  }
}
