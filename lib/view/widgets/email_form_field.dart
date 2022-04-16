import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:grocery_shop/constants.dart';

class EmailFormField extends StatelessWidget {
  final void Function(String?)? onSave;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  const EmailFormField({Key? key, this.onSave, this.validator, this.controller})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      // controller: controller,
      cursorColor: Theme.of(context).primaryColor,
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.next,
      decoration: InputDecoration(
        hintText: "Enter your email",
        prefixIcon: Icon(
          FontAwesomeIcons.solidEnvelope,
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
          borderSide: const BorderSide(color: kHeartColor),
          borderRadius: BorderRadius.circular(kDefaultBorderRadius * 1.4),
        ),
      ),
      onSaved: onSave,
      validator: validator,
    );
  }
}
