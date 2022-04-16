import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_shop/constants.dart';
import 'package:grocery_shop/data/controller/auth_controller.dart';

class ProfileNameFormField extends StatelessWidget {
  final User user;
  const ProfileNameFormField({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final authCtrlr = Get.find<AuthController>();
    return Obx(() => TextFormField(
      initialValue: user.displayName ?? authCtrlr.getUser().name,
      enabled: authCtrlr.getEnabledName(),
      focusNode: authCtrlr.nameFocusNode,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.done,
      decoration: InputDecoration(
        labelText: "Username",
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
      onChanged: (value) {
        authCtrlr.profileName = value;
      },
      validator: (value) {
        return authCtrlr.validateFullName(value);
      },
    ),);
  }
}
