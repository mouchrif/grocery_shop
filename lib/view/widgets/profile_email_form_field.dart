import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_shop/constants.dart';
import 'package:grocery_shop/data/controller/auth_controller.dart';

class ProfileEmailFormField extends StatelessWidget {
  final User user;
  const ProfileEmailFormField({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authCtrlr = Get.find<AuthController>();
    return Obx(() => TextFormField(
      // controller: authCtrlr.profileEmailController,
      initialValue: user.email,
      focusNode: authCtrlr.emailFocusNode,
      enabled: authCtrlr.getEnabledEmail(),
      keyboardType: TextInputType.emailAddress,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        labelText: "Email Adress",
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(
            color: Theme.of(context).primaryColor,
          ),
        ),
        errorBorder: const UnderlineInputBorder(
          borderSide: BorderSide(color: kHeartColor),
        ),
      ),
      cursorColor: Theme.of(context).primaryColor,
      onSaved: (value) {
        authCtrlr.profileEmail = value;
      },
      validator: (value) {
        return authCtrlr.validateEmail(value);
      },
    ),);
  }
}
