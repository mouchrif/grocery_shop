import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_shop/constants.dart';
import 'package:grocery_shop/theme.dart';
import 'package:grocery_shop/util/binding.dart';
import 'package:grocery_shop/view/screens/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Grocery shop app',
      theme: lightThemeData,
      darkTheme: darkThemeData,
      themeMode: ThemeMode.system,
      initialRoute: "/",
      initialBinding: Binding(),
      home: const SplashScreen(backgroundColor: kWhiteColor,),
      // const CategoriesScreen(),
    );
  }
}
