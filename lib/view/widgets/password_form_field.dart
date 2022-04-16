import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:grocery_shop/constants.dart';
import 'package:grocery_shop/data/controller/auth_controller.dart';

class PasswordFormField extends StatelessWidget {
  final void Function(String?)? onSave;
  final String? Function(String?)? validator;
  final TextEditingController? controller;
  final String? hintText;
  const PasswordFormField(
      {Key? key, this.onSave, this.validator, this.controller, this.hintText = "Enter your password"})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authCtrlr = Get.find<AuthController>();
    return Obx(() => TextFormField(
          // controller: controller,
          cursorColor: Theme.of(context).primaryColor,
          obscureText: authCtrlr.getPassVisibility(),
          keyboardType: TextInputType.visiblePassword,
          textInputAction: hintText!.contains("Confirm") ? TextInputAction.done : TextInputAction.next,
          decoration: InputDecoration(
            hintText: hintText,
            prefixIcon: Icon(
              FontAwesomeIcons.lock,
              color: Theme.of(context).primaryColor,
              size: 20.0,
            ),
            suffixIcon: GestureDetector(
              onTap: () {
                authCtrlr.setPassVisibility(
                    authCtrlr.getPassVisibility() ? false : true);
              },
              child: Icon(
                authCtrlr.getPassVisibility()
                    ? FontAwesomeIcons.eyeSlash
                    : FontAwesomeIcons.eye,
                color: Theme.of(context).primaryColor,
                size: 20.0,
              ),
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
        ));
  }
}
