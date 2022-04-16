import 'package:flutter/material.dart';
import 'package:grocery_shop/constants.dart';

class ItemIsNotFoundWidget extends StatelessWidget {
  final Size size;
  final String text;
  final String? subText;
  const ItemIsNotFoundWidget({Key? key, required this.size, required this.text, this.subText}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: size.width - kDefaultPadding * 2,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            children: [
              Container(
                padding: EdgeInsets.all(size.height * 0.03),
                decoration: BoxDecoration(
                  color: Colors.grey.shade200,
                  borderRadius: BorderRadius.circular(kDefaultBorderRadius),
                ),
                child: const Align(
                  alignment: Alignment.center,
                  child: Text(
                    "😥",
                    style: TextStyle(
                      fontSize: 20.0,
                    ),
                  ),
                ),
              ),
              SizedBox(height: size.height * 0.01),
              Text(
                text,
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      color: Theme.of(context).primaryColor,
                    ),
              ),
              SizedBox(height: size.height * 0.01),
              Text(
                subText ?? "Try search either different keyword",
                style: Theme.of(context).textTheme.bodyText1,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
