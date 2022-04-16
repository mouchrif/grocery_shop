import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grocery_shop/constants.dart';

class NameFormField extends StatelessWidget {
  final  void Function(String?)? onSave;
  final String? Function(String?)? validator;
  const NameFormField({Key? key, this.onSave, this.validator}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      cursorColor: Theme.of(context).primaryColor,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        hintText: "Enter your full name",
        prefixIcon: Icon(
          FontAwesomeIcons.userAlt,
          color: Theme.of(context).primaryColor,
          size: 20.0,
        ),
        filled: true,
        border: OutlineInputBorder(
          borderSide: BorderSide.none,
          borderRadius: BorderRadius.circular(kDefaultBorderRadius * 1.4),
        ),
        focusedBorder: OutlineInputBorder(
          borderSide: BorderSide(color: Theme.of(context).primaryColor),
          borderRadius: BorderRadius.circular(kDefaultBorderRadius * 1.4),
        ),
        errorBorder: OutlineInputBorder(
          borderSide: const BorderSide(color: kHeartColor,),
          borderRadius: BorderRadius.circular(kDefaultBorderRadius * 1.4),
        ),
      ),
      onSaved: onSave,
      validator: validator,
    );
  }
}
