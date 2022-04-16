import 'package:flutter/material.dart';
import 'package:grocery_shop/data/controller/auth_controller.dart';
import 'package:grocery_shop/view/widgets/column_form_field_builder.dart';
import 'package:grocery_shop/view/widgets/email_form_field.dart';

class ValidatedEmailBuilder extends StatelessWidget {
  final AuthController controller;
  const ValidatedEmailBuilder({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColumnFormFieldBuilder(
      labelText: "Email address",
      child: EmailFormField(
        // controller: controller.emailCtroller,
        onSave: (value) {
          controller.email = value;
          print(controller.email);
        },
        validator: (value) {
          return controller.validateEmail(value);
        },
      ),
    );
  }
}
