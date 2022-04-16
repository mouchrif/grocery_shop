import 'package:flutter/material.dart';
import 'package:grocery_shop/constants.dart';

class QuantityBtn extends StatelessWidget {
  final double width;
  final double height;
  final double? borderRadius;
  final String text;
  final VoidCallback onTapFunc;
  final Color? color;
  final Color? textColor;
  const QuantityBtn({
    Key? key,
    required this.width,
    required this.height,
    this.borderRadius,
    required this.text,
    required this.onTapFunc,
    this.color,
    this.textColor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTapFunc,
      child: Container(
        width: width,
        height: height,
        decoration: BoxDecoration(
          color: color ?? kBackgroundColorLightTheme,
          borderRadius:
              BorderRadius.circular(borderRadius ?? kDefaultBorderRadius),
        ),
        child: Center(
          child: Text(
            text,
            style: Theme.of(context).textTheme.headline6!.copyWith(
                  color: textColor ?? kPrimaryColor,
                ),
          ),
        ),
      ),
    );
  }
}
