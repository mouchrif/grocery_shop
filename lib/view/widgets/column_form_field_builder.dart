import 'package:flutter/material.dart';
import 'package:grocery_shop/constants.dart';

class ColumnFormFieldBuilder extends StatelessWidget {
  final Widget child;
  final String labelText;
  final String? helperText;
  const ColumnFormFieldBuilder(
      {Key? key, required this.child, required this.labelText, this.helperText})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(labelText),
        SizedBox(height: kDefaultPadding / 3),
        child,
        helperText != null 
        ? SizedBox(height: kDefaultPadding / 3)
        : const SizedBox(),
        helperText != null 
        ? Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              helperText??"",
            ),
          ],
        )
        : Container(),
      ],
    );
  }
}
