import 'package:flutter/material.dart';
import 'package:get/get.dart';

class FiletringTextForm extends GetxController {
  final formKey = GlobalKey<FormState>();
  final formKey1 = GlobalKey<FormState>();
  final controller = TextEditingController();
  final filteringWord = "".obs;

  void clearTextField() {
    controller.clear();
  }

  @override
  void onClose() {
    controller.dispose();
    super.onClose();
  }
}
