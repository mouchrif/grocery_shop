import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:grocery_shop/constants.dart';
import 'package:grocery_shop/data/controller/product_controller.dart';

class AllAndMenuIconRowWidget extends StatelessWidget {
  final String? text;
  final String? txt;
  final Widget? prefix;
  final bool? isRight;
  final bool? isIconExist;
  final VoidCallback? onPressed;
  const AllAndMenuIconRowWidget(
      {Key? key, this.text, this.prefix, this.txt, this.isRight, this.isIconExist = false, this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productCtrlr = Get.find<ProductController>();
    return Padding(
      padding: EdgeInsets.only(right: isRight == null ? 0.0 : kDefaultPadding),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Row(
            children: [
              prefix ?? Container(),
              prefix == null
                  ? const SizedBox(width: 0.0)
                  : const SizedBox(width: 6),
              Text(
                text ?? "",
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      color: Theme.of(context).primaryColor,
                    ),
              ),
            ],
          ),
          txt == null && isIconExist == true
              ? IconButton(
                  onPressed: () {
                    productCtrlr
                        .setIsGrid(productCtrlr.getIsGrid() ? false : true);
                  },
                  icon: Obx(
                    () => Icon(
                      productCtrlr.getIsGrid()
                          ? FontAwesomeIcons.thLarge
                          : FontAwesomeIcons.thList,
                      color: kGreenColor,
                      size: 20,
                    ),
                  ),
                )
              : TextButton(
                onPressed: onPressed, 
                child: Text(
                  txt!,
                  style: Theme.of(context).textTheme.bodyText1!.copyWith(
                    color: Theme.of(context).primaryColor,
                  ),
                ),
              ),
        ],
      ),
    );
  }
}
