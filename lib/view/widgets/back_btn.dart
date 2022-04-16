import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:grocery_shop/constants.dart';

class BackBtn extends StatelessWidget {
  final double width;
  const BackBtn({Key? key, required this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Get.back();
      },
      child: Container(
        // padding: const EdgeInsets.symmetric(vertical: kDefaultPadding / 2),
        width: width,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(kDefaultBorderRadius * 2),
        ),
        child: Center(
          child: Icon(
            FontAwesomeIcons.longArrowAltLeft,
            color: Theme.of(context).primaryColor,
          ),
        ),
      ),
    );
  }
}
