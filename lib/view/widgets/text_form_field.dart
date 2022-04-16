import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:grocery_shop/constants.dart';
import 'package:grocery_shop/data/controller/text_form_feltring_controller.dart';

class TextFormFieldWidget extends StatelessWidget {
  final String? hintText;
  final bool? isRight;
  const TextFormFieldWidget({Key? key, this.hintText, this.isRight})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(FiletringTextForm());
    return Padding(
      padding: EdgeInsets.only(right: isRight == null ? 0.0 : kDefaultPadding),
      child: TextFormField(
        // key: textFieldCtrlr.formKey,
        controller: controller.controller,
        keyboardType: TextInputType.text,
        textInputAction: TextInputAction.done,
        cursorColor: Theme.of(context).primaryColor,
        style: const TextStyle(decoration: TextDecoration.none),
        decoration: InputDecoration(
          hintText: hintText,
          filled: true,
          fillColor: kFieldsColor.withOpacity(0.3),
          prefixIcon: Icon(
            FontAwesomeIcons.search,
            color: Theme.of(context).primaryColor,
          ),
          border: InputBorder.none,
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(kDefaultBorderRadius * 1.5),
            borderSide: const BorderSide(
              color: Colors.transparent,
            ),
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(kDefaultBorderRadius * 1.5),
            borderSide: const BorderSide(
              color: kGreenColor,
            ),
          ),
        ),
        onChanged: (value) {
          controller.filteringWord.value = value;
          print(controller.filteringWord.value);
        },
      ),
    );
  }
}
