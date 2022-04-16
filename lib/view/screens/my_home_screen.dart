import 'package:fancy_bottom_navigation/fancy_bottom_navigation.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:grocery_shop/constants.dart';
import 'package:grocery_shop/data/controller/category_controller.dart';
import 'package:grocery_shop/data/controller/connectivity_controller.dart';
import 'package:grocery_shop/view/screens/cart_screen.dart';
import 'package:grocery_shop/view/screens/home_screen.dart';
import 'package:grocery_shop/view/screens/profile_screen.dart';

class MyHomeScreen extends StatelessWidget {
  final User? user;
  MyHomeScreen({Key? key, this.user}) : super(key: key);
  final CategoryController categoriesController = Get.put(CategoryController());
  final cnxCtrlr = Get.find<ConnectivityManager>();
  @override
  Widget build(BuildContext context) {
    final List<Widget> _pages = [
      const HomeScreen(),
      const CartScreen(isBackBtn: false),
      const ProfileScreen(),
    ];
    return Obx(
      () => Scaffold(
        body:  _pages[categoriesController.getCurrentPage()],
        // GetBuilder<ConnectivityManager>(
        //   builder: (builder) => cnxCtrlr.isDeviceConnected 
        // ? _pages[categoriesController.getCurrentPage()]
        // : const ConnectivityScreen(),
        // ),
        bottomNavigationBar: FancyBottomNavigation(
          initialSelection: categoriesController.getCurrentPage(),
          circleColor: Theme.of(context).primaryColor,
          activeIconColor: kWhiteColor,
          inactiveIconColor: Theme.of(context).primaryColor,
          textColor: Theme.of(context).primaryColor,
          tabs: [
            TabData(
              iconData: FontAwesomeIcons.home,
              title: "Home",
            ),
            TabData(
              iconData: FontAwesomeIcons.shoppingBag,
              title: "Cart",
            ),
            TabData(
              iconData: FontAwesomeIcons.userAlt,
              title: "Profile",
            ),
          ],
          onTabChangedListener: (index) {
            categoriesController.setCurrentPage(index);
          },
        ),
      ),
    );
  }
}
