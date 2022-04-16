import 'package:flutter/material.dart';
import 'package:grocery_shop/constants.dart';

class BigBtn extends StatelessWidget {
  final double width;
  final double height;
  final String text;
  final VoidCallback onPressed;
  const BigBtn({Key? key, required this.width, required this.height, required this.text, required this.onPressed}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          padding: EdgeInsets.all(kDefaultPadding),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(kDefaultBorderRadius),
          ),
        ),
        child: Center(
          child: Text(text),
        ),
      ),
    );
  }
}
