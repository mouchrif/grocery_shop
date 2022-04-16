import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grocery_shop/constants.dart';
import 'package:grocery_shop/view/widgets/text_form_field.dart';

class SearchRow extends StatelessWidget {
  final Size size;
  final String? hintText;
  final bool isRight;
  const SearchRow({Key? key, required this.size, this.hintText, required this.isRight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: rightPadding(isRight: isRight),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: (size.width - 2 * kDefaultPadding) * 0.8,
            height: (size.width - 2 * kDefaultPadding) * 0.14,
            child: TextFormFieldWidget(hintText: hintText),
          ),
          Container(
            width: (size.width - 2 * kDefaultPadding) * 0.14,
            height: (size.width - 2 * kDefaultPadding) * 0.14,
            decoration: BoxDecoration(
              color: kFieldsColor.withOpacity(0.3),
              borderRadius: BorderRadius.circular(kDefaultBorderRadius * 1.15),
            ),
            child: Center(
              child: Icon(
                FontAwesomeIcons.slidersH,
                color: Theme.of(context).primaryColorDark,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
