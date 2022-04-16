import 'dart:async';

import 'package:flutter/material.dart';
import 'package:grocery_shop/constants.dart';
import 'package:grocery_shop/view/screens/handle_screen.dart';
import 'package:lottie/lottie.dart';
import 'package:get/get.dart';

class SplashScreen extends StatefulWidget {
  final Color? backgroundColor;
  const SplashScreen({Key? key, this.backgroundColor}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  AnimationController? animController;
  Animation<double>? animation;
  Animation<Offset>? animPosition;
  late Timer timer;

  @override
  void initState() {
    super.initState();
    timer = Timer(
      const Duration(seconds: 7),
        () {
          Get.offAll(
            () => const HandleScreen(),
            transition: Transition.fade,
          );
        }
    );
    animController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1500),
    )..forward();
    animation = CurvedAnimation(parent: animController!, curve: Curves.easeIn);
    animPosition = Tween<Offset>(
            begin: const Offset(0.0, 0.5), end: const Offset(0.0, 0.0))
        .animate(
      CurvedAnimation(parent: animController!, curve: Curves.easeIn),
    );
  }

  @override
  void dispose() {
    animController!.dispose();
    timer.cancel();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      backgroundColor: widget.backgroundColor,
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: size.height,
            child: Container(
              decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                    "assets/images/splash_bg.jpg",
                  ),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: size.height,
            child: Container(
              color: Theme.of(context).primaryColor.withOpacity(0.7),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SizedBox(
                  height: size.height * 0.25,
                  child: Lottie.asset("assets/lotties/vegetable.json"),
                ),
                FadeTransition(
                  opacity: animation!,
                  child: SlideTransition(
                    position: animPosition!,
                    child: Text(
                      "Grofast",
                      style: Theme.of(context).textTheme.headline4!.copyWith(
                            color: kWhiteColor,
                            fontWeight: FontWeight.bold,
                          ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
