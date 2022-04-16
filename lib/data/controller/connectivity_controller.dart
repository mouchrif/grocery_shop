import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:get/get.dart';
import 'package:grocery_shop/view/screens/connectivity_screen.dart';

class ConnectivityManager extends GetxController {
  bool _isDeviceConnected = true;
  bool isBack = false;
  bool get isDeviceConnected => _isDeviceConnected;
  final Connectivity _connectivity = Connectivity();
  late StreamSubscription<ConnectivityResult> _connectivitySubscription;
  ConnectivityResult connectivityResult = ConnectivityResult.none;

  @override
  void onInit() {
    super.onInit();
    checkConnection();
    _connectivitySubscription =
        _connectivity.onConnectivityChanged.listen(_upDateConnectionStatus);
  }

  void checkConnection() async {
    connectivityResult = await _connectivity.checkConnectivity();
    _upDateConnectionStatus(connectivityResult);
  }

  void _upDateConnectionStatus(ConnectivityResult result) {
    print(result);
    if (result == ConnectivityResult.none) {
      Get.to(
        () => const ConnectivityScreen(),
        transition: Transition.fade,
      );
      _isDeviceConnected = false;
      update();
    } else {
      _isDeviceConnected = true;
      isBack = true;
      update();
    }
  }

  @override
  void onClose() {
    _connectivitySubscription.cancel();
    super.onClose();
  }
}
