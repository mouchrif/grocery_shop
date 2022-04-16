import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_shop/data/controller/auth_controller.dart';
import 'package:grocery_shop/data/controller/connectivity_controller.dart';
import 'package:grocery_shop/view/screens/connectivity_screen.dart';
import 'package:grocery_shop/view/screens/my_home_screen.dart';
import 'package:grocery_shop/view/screens/on_boarding_screen.dart';

class HandleScreen extends GetWidget<AuthController> {
  const HandleScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    if (Get.find<ConnectivityManager>().isDeviceConnected) {
      return StreamBuilder<User?>(
          stream: controller.fbServices.fbAuth.userChanges(),
          builder: (context, snapshot) {
            if (snapshot.hasData && !snapshot.data!.isAnonymous) {
              return MyHomeScreen(
                user: snapshot.data!,
              );
            }
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(
                  color: Theme.of(context).primaryColor,
                ),
              );
            }
            if (snapshot.hasError) {
              return const Center(
                child: Text("Something went wrong"),
              );
            }
            return const OnBoardingScreen();
          });
    } else {
      return const ConnectivityScreen();
    }
  }
}
