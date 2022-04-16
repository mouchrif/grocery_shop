import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_shop/constants.dart';
import 'package:grocery_shop/data/controller/auth_controller.dart';

class SocialAth extends GetWidget<AuthController> {
  final double width;
  final List<Map<String, dynamic>> icons;
  const SocialAth({Key? key, required this.width, required this.icons})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: List.generate(
        4,
        (index) => Material(
          color: Colors.grey.shade200,
          borderRadius: BorderRadius.circular(kDefaultBorderRadius * 1.8),
          child: InkWell(
            radius: width,
            borderRadius: BorderRadius.circular(kDefaultBorderRadius * 1.8),
            onTap: () {
              print(index);
              controller.socialAuthIcons(index, context);
            },
            child: SizedBox(
              height: width,
              width: width,
              child: Center(
                child: index != 1
                    ? Icon(
                        icons[index]['icon'],
                        color: icons[index]['color'],
                        size: 28.0,
                      )
                    : Image.asset(
                        icons[index]['icon'],
                        height: 30.0,
                      ),
              ),
            ),
          ),
        ),
      ).toList(),
    );
  }
}
