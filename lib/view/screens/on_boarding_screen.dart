import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:grocery_shop/constants.dart';
import 'package:grocery_shop/data/controller/on_boarding_controller.dart';
import 'package:grocery_shop/view/screens/sign_in_screen.dart';
import 'package:grocery_shop/view/widgets/btn_builder.dart';
import 'package:grocery_shop/view/widgets/custom_shape.dart';

class OnBoardingScreen extends GetWidget<OnBoardingController> {
  const OnBoardingScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    const double heightCoefficent = 0.55;
    return Scaffold(
      body: PageView.builder(
        controller: controller.pageController,
        physics: const BouncingScrollPhysics(),
        onPageChanged: (index) => controller.setCurrentPage(index),
        itemCount: controller.getPages().length,
        itemBuilder: (context, index) => Stack(
          children: [
            Positioned(
              left: 0,
              right: 0,
              bottom: 0,
              height: size.height * (1 - heightCoefficent),
              child: LayoutBuilder(
                builder: (context, constraints) => Container(
                  color: Colors.transparent,
                  child: Padding(
                    padding: EdgeInsets.only(
                      top: kDefaultPadding * 2,
                      left: kDefaultPadding,
                      right: kDefaultPadding,
                      bottom: kDefaultPadding,
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            ...List.generate(3, (index) {
                              return Row(
                                children: [
                                  Obx(
                                    () => Container(
                                      width:
                                          controller.getCurrentPage() == index
                                              ? constraints.maxWidth * 0.1
                                              : kSize6*2,
                                      height: kSize6,
                                      decoration: BoxDecoration(
                                        color:
                                            controller.getCurrentPage() == index
                                                ? Theme.of(context).primaryColor
                                                : Theme.of(context)
                                                    .primaryColor
                                                    .withOpacity(0.4),
                                        borderRadius: BorderRadius.circular(kSize8),
                                      ),
                                    ),
                                  ),
                                  SizedBox(width: kSize6),
                                ],
                              );
                            }).toList(),
                          ],
                        ),
                        SizedBox(height: constraints.maxHeight * 0.08),
                        Text(
                          controller.getPages()[index]['title'],
                          style:
                              Theme.of(context).textTheme.headline5!.copyWith(
                                    letterSpacing: 1.1,
                                    color: Theme.of(context).primaryColor,
                                    fontWeight: FontWeight.bold,
                                  ),
                        ),
                        SizedBox(height: constraints.maxHeight * 0.06),
                        SizedBox(
                          width: constraints.maxWidth * 0.8,
                          child: Text(
                            controller.getPages()[index]['text'],
                            textAlign: TextAlign.center,
                            textScaleFactor: 1.02,
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                        SizedBox(height: constraints.maxHeight * 0.12),
                        Container(
                          padding: EdgeInsets.all(kDefaultPadding / 2),
                          decoration: BoxDecoration(
                            color: Theme.of(context)
                                .primaryColor
                                .withOpacity(0.05),
                            border: Border.all(
                              width: 2,
                              color: Colors.grey.shade300,
                            ),
                            borderRadius:
                                BorderRadius.circular(kDefaultPadding * 3),
                          ),
                          child: SizedBox(
                            width: constraints.maxWidth * 0.4,
                            child: Obx(
                              () => BtnBuilder(
                                  text: controller.getCurrentPage() == 2
                                      ? "Get Started"
                                      : "",
                                  height: constraints.maxHeight * 0.2,
                                  icon: controller.getCurrentPage() == 2
                                      ? null
                                      : FontAwesomeIcons.arrowRight,
                                  onTapFunc: () {
                                    if (controller.getCurrentPage() == 2) {
                                      Get.off(
                                        () => const SignInScreen(),
                                        // binding: Bind(),
                                        transition: Transition.fade,
                                      );
                                    } else {
                                      controller.onTap();
                                    }
                                  }),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              height: size.height * heightCoefficent + 5*kSize10,
              child: ClipPath(
                clipper: CustomShape(),
                child: Stack(
                  children: [
                    Positioned(
                      top: 0,
                      left: 0,
                      right: 0,
                      height: size.height * heightCoefficent + 5*kSize10,
                      child: Container(
                        color: kBackgroundColorLightTheme,
                        child: Image.asset(
                          controller.getPages()[index]['imagePath'],
                          scale: 4.5,
                          // height: size.height*0.2,
                          // fit: BoxFit.fitHeight,
                        ),
                      ),
                    ),
                    // Positioned(
                    //   top: 0,
                    //   left: 0,
                    //   right: 0,
                    //   height: size.height * heightCoefficent + 50,
                    //   child: Container(
                    //     color: Theme.of(context).primaryColor.withOpacity(0.25),
                    //   ),
                    // ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
