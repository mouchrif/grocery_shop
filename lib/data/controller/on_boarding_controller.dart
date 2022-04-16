import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

class OnBoardingController extends GetxController {
  PageController pageController = PageController();
  final List<Map<String, dynamic>> _pages = [
    {
      "title": "Easy Shopping",
      "imagePath": "assets/images/shopping.png",
      "text": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque dignissim.",
    },
    {
      "title": "Secure Payment", 
      "imagePath": "assets/images/payment.png",
      "text": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque dignissim.",
    },
    {
      "title": "Quick Delivery", 
      "imagePath": "assets/images/shipping.png",
      "text": "Lorem ipsum dolor sit amet, consectetur adipiscing elit. Quisque dignissim.",
    },
  ];
  List<Map<String, dynamic>> getPages() => _pages;
  final _currentPage = 0.obs;
  void setCurrentPage(int index) => _currentPage.value = index;
  int getCurrentPage() => _currentPage.value;

  void onTap() {
    pageController.animateToPage(
      _currentPage.value == 2 ? 2 : _currentPage.value + 1,
      duration: const Duration(milliseconds: 250),
      curve: Curves.easeInOut,
    );
  }

  @override
  void onClose() {
    pageController.dispose();
    super.onClose();
  }
}
