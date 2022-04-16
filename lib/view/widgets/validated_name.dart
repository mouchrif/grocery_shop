import 'package:flutter/material.dart';
import 'package:grocery_shop/data/controller/auth_controller.dart';
import 'package:grocery_shop/view/widgets/column_form_field_builder.dart';
import 'package:grocery_shop/view/widgets/name_form_field.dart';

class ValidatedNameBuilder extends StatelessWidget {
  final AuthController controller;
  const ValidatedNameBuilder({Key? key, required this.controller}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ColumnFormFieldBuilder(
      labelText: "Full name",
      child: NameFormField(
        onSave: (value) {
          controller.name = value;
          print(controller.name);
        },
        validator: (value) {
          return controller.validateFullName(value);
        },
      ),
    );
  }
}
