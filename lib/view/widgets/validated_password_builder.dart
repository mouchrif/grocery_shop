import 'package:flutter/material.dart';
import 'package:grocery_shop/data/controller/auth_controller.dart';
import 'package:grocery_shop/view/widgets/column_form_field_builder.dart';
import 'package:grocery_shop/view/widgets/password_form_field.dart';

class ValidatedPasswordBuilder extends StatelessWidget {
  final AuthController controller;
  final String? hintText;
  final String labelText;
  const ValidatedPasswordBuilder({
    Key? key,
    required this.controller,
    this.hintText = "Enter your password",
    this.labelText="Password",
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColumnFormFieldBuilder(
      labelText: labelText,
      // helperText: isHelperText ? "Forgot password?" : "",
      child: PasswordFormField(
        // controller: controller.passwordController,
        hintText: hintText,
        onSave: (value) {
          if (labelText.toLowerCase().contains("new password")) {
            controller.newPassword = value;
            print(controller.newPassword);
          } else if (labelText.toLowerCase().contains("confirm password")) {
            controller.confirmPassword = value;
            print(controller.confirmPassword);
          }else {
            controller.password = value;
            print(controller.password);
          }
        },
        validator: (value) {
          return controller.validatePassword(value);
        },
      ),
    );
  }
}
