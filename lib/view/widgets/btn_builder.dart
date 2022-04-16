import 'package:flutter/material.dart';
import 'package:grocery_shop/constants.dart';

class BtnBuilder extends StatelessWidget {
  final String text;
  final double height;
  final IconData? icon;
  final VoidCallback? onTapFunc;
  const BtnBuilder(
      {Key? key,
      required this.text,
      required this.height,
      this.icon,
      this.onTapFunc})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      color: Theme.of(context).primaryColor,
      borderRadius: BorderRadius.circular(kDefaultBorderRadius * 3),
      child: InkWell(
        borderRadius: BorderRadius.circular(kDefaultBorderRadius * 3),
        onTap: onTapFunc ?? () {},
        child: SizedBox(
          height: height,
          child: Center(
            child: icon == null
                ? Text(
                    text,
                    style: Theme.of(context).textTheme.headline6!.copyWith(
                      color: kWhiteColor,
                    ),
                  )
                : Icon(
                    icon,
                    color: kWhiteColor,
                    size: 20.0,
                  ),
          ),
        ),
      ),
    );
  }
}
