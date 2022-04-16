import 'package:flutter/material.dart';
import 'package:get/get.dart';

const kPrimaryColor = Color(0xFF349464);
const Color kGreenLightColor = Color(0xFF8BD0B2);
const Color kGreenColor = Color(0xFF275F4E);
const kFieldsColor = kTextColorLightTheme;
const kHeartColor = Color(0xFFEC664D);
// const Color kFieldsColor = Color(0xFFE5D9CB);
const Color kWhiteColor = Color(0xFFFFFFFF);

// light theme colors
const kSecondaryColorLightTheme = Color(0xFF293137);
const kBodyTextColorLightTheme = Color(0xFF787A80);
const kTextColorLightTheme = Color(0xFFACB4B4);
const kBackgroundColorLightTheme = Color(0xFFF2F4F3);

// dark theme colors
const kSecondaryColorDarkTheme = Color(0xFF349464);
const kBodyTextColorDarkTheme = Color(0xFF787A80);
const kTextColorDarkTheme = Color(0xFFACB4B4);
const kBackgroundColorDarkTheme = Color(0xFF293137);

const kTwitterColor = Color(0xff1DA1F2);
const kFacebookColor = Color(0xff4267B2);
const kGoogleColor = Color(0xff4285F4);

// const Color kBtnColor = Color(0xFF349464);
// const Color kGreenDarkColor = Color(0xFF293137);
// const Color kGreyDarkColor = Color(0xFF787A80);
// const Color kGreyColor = Color(0xFFACB4B4);
// const Color kGreyLightColor = Color(0xFFF2F4F3);

final double kScreenHeight = Get.context!.height;
double kDefaultPadding = kScreenHeight / 50.18;
double kDefaultBorderRadius = kScreenHeight / 57.35;
double kSize6 = kScreenHeight / 133.82;
double kSize8 = kScreenHeight / 100.36;
double kSize10 = kScreenHeight / 80.29;
double kSize14 = kScreenHeight / 57.35;
double kSize18 = kScreenHeight / 44.60;
double kSize24 = kScreenHeight / 33.45;

EdgeInsets padding(double statusBarHeight, {bool rightPadding = true}) {
  return EdgeInsets.only(
    top: statusBarHeight + kDefaultPadding,
    left: kDefaultPadding,
    right: rightPadding ? kDefaultPadding : 0.0,
  );
}

EdgeInsets rightPadding({bool isRight = false}) {
  return EdgeInsets.only(right: isRight ? kDefaultPadding : 0.0);
}
