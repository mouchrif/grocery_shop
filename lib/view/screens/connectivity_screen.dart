import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:grocery_shop/constants.dart';
import 'package:grocery_shop/data/controller/connectivity_controller.dart';
import 'package:grocery_shop/view/screens/handle_screen.dart';
import 'package:lottie/lottie.dart';

class ConnectivityScreen extends StatelessWidget {
  const ConnectivityScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final cnxCtrlr = Get.find<ConnectivityManager>();
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          leading: GetBuilder<ConnectivityManager>(
            builder: (builder) => SizedBox(
              child: !cnxCtrlr.isDeviceConnected
                  ? null
                  : IconButton(
                      onPressed: () async {
                        if (cnxCtrlr.isBack) {
                          if (Get.previousRoute.length == 1) {
                            Get.offAll(
                              () => const HandleScreen(),
                              transition: Transition.fade,
                            );
                          } else {
                            Get.back();
                          }
                        }
                      },
                      icon: const Icon(FontAwesomeIcons.arrowLeft),
                    ),
            ),
          ),
          automaticallyImplyLeading: false,
          title: const Text("No Internet Connection"),
          centerTitle: true,
        ),
        body: Stack(
          // crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(
              height: double.infinity,
              child: LottieBuilder.asset(
                  "assets/lotties/no-internet-connection.json"),
            ),
            Positioned(
              bottom: size.height * 0.1,
              width: size.width,
              child: GetBuilder<ConnectivityManager>(
                builder: (builder) => Text(
                  cnxCtrlr.isDeviceConnected
                      ? "Internet Connection OK,\n Please press back button in the top"
                      : "No Internet Connection",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headline5!.copyWith(
                        color: cnxCtrlr.isDeviceConnected
                            ? kPrimaryColor
                            : kHeartColor,
                        fontWeight: FontWeight.bold,
                      ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
