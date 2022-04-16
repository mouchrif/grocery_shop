import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:grocery_shop/constants.dart';

final lightThemeData = ThemeData(
  brightness: Brightness.light,
  primaryColor: kPrimaryColor,
  primaryColorDark: kGreenColor,
  inputDecorationTheme: const InputDecorationTheme(
    floatingLabelStyle: TextStyle(color: kPrimaryColor)
  ),
  //scaffoldBackgroundColor: kBackgroundColorLightTheme,
  textTheme: GoogleFonts.aBeeZeeTextTheme(
    ThemeData.light().textTheme.copyWith(
      headline6: const TextStyle(
        color: kSecondaryColorLightTheme,
        fontWeight: FontWeight.w600,
      ),
      bodyText1: const TextStyle(
        color: kBodyTextColorLightTheme,
      ),
      bodyText2: const TextStyle(
        color: kBodyTextColorLightTheme,
      ),
    ),
  ),
  iconTheme: const IconThemeData(
    color: kBodyTextColorLightTheme,
  ),
  elevatedButtonTheme: elevatedButtonThemeData,
  appBarTheme: const AppBarTheme(
    color: kPrimaryColor,
  ),
);

final darkThemeData = ThemeData(
  brightness: Brightness.dark,
  primaryColor: kPrimaryColor,
  scaffoldBackgroundColor: kBackgroundColorDarkTheme,
  inputDecorationTheme: const InputDecorationTheme(
    floatingLabelStyle: TextStyle(color: kPrimaryColor)
  ),
  iconTheme: const IconThemeData(
    color: kBodyTextColorDarkTheme,
  ),
  textTheme: GoogleFonts.robotoTextTheme(
    ThemeData.dark().textTheme.copyWith(
      headline6: const TextStyle(
        color: kSecondaryColorDarkTheme,
        fontWeight: FontWeight.w600,
      ),
      bodyText1: const TextStyle(
        color: kBodyTextColorDarkTheme,
      ),
      bodyText2: const TextStyle(
        color: kBodyTextColorDarkTheme,
      ),
    ),
  ),
  elevatedButtonTheme: elevatedButtonThemeData,
  appBarTheme: const AppBarTheme(
    color: kPrimaryColor,
  ),
);

final elevatedButtonThemeData = ElevatedButtonThemeData(
  style: TextButton.styleFrom(
    backgroundColor: kPrimaryColor,
    // padding: EdgeInsets.all(kDefaultPadding),
    // shape: RoundedRectangleBorder(
    //   borderRadius: BorderRadius.circular(kDefaultBorderRadius),
    // ),
  ),
);
