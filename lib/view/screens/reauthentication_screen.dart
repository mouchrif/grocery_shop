import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_shop/constants.dart';
import 'package:grocery_shop/data/controller/auth_controller.dart';
import 'package:grocery_shop/view/widgets/back_btn.dart';
import 'package:grocery_shop/view/widgets/bottom_text_auth.dart';
import 'package:grocery_shop/view/widgets/btn_builder.dart';
import 'package:grocery_shop/view/widgets/social_auth.dart';
import 'package:grocery_shop/view/widgets/validated_email_builder.dart';
import 'package:grocery_shop/view/widgets/validated_password_builder.dart';

class ReauthenticationScreen extends GetWidget<AuthController> {
  const ReauthenticationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.fromLTRB(
            kDefaultPadding,
            kDefaultPadding + statusBarHeight,
            kDefaultPadding,
            kDefaultPadding,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              SizedBox(
                height: size.height * 0.05,
                child: Material(
                  borderRadius: BorderRadius.circular(kDefaultBorderRadius * 2),
                  child: InkWell(
                    borderRadius:
                        BorderRadius.circular(kDefaultBorderRadius * 2),
                    onTap: () {
                      Get.back();
                    },
                    child: BackBtn(width: size.width * 0.2),
                  ),
                ),
              ),
              SizedBox(
                height: size.height -
                    size.height * 0.05 -
                    statusBarHeight -
                    kDefaultPadding * 2,
                child: LayoutBuilder(
                  builder: (context, constraints) => Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      const Spacer(),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Welcome back",
                            style:
                                Theme.of(context).textTheme.headline5!.copyWith(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                          Text(
                            "to Grofast!",
                            style:
                                Theme.of(context).textTheme.headline5!.copyWith(
                                      color: Theme.of(context).primaryColor,
                                      fontWeight: FontWeight.bold,
                                    ),
                          ),
                        ],
                      ),
                      const Spacer(),
                      Form(
                        key: controller.formReauthenticationKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Column(
                          children: [
                            ValidatedEmailBuilder(controller: controller),
                            SizedBox(
                              height: constraints.maxHeight * 0.02,
                            ),
                            ValidatedPasswordBuilder(controller: controller),
                            SizedBox(
                              height: constraints.maxHeight * 0.02 * 2,
                            ),
                            BtnBuilder(
                              text: "Re-Sign In",
                              height: size.height * 0.075,
                              onTapFunc: () async {
                                // Get.offAll(
                                //   () => MyHomeScreen(),
                                //   transition: Transition.fade,
                                // );
                                // await controller.reCheckLogin(context);
                                // await controller.upDateUserInfos();
                                // controller.resetFields();
                              },
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: constraints.maxHeight * 0.02,
                      ),
                      SizedBox(
                        width: constraints.maxWidth,
                        child: const Text(
                          "or with",
                          textAlign: TextAlign.center,
                        ),
                      ),
                      SizedBox(
                        height: constraints.maxHeight * 0.02,
                      ),
                      SocialAth(
                        width: size.width * 0.18,
                        icons: controller.getIcons(),
                      ),
                      const Spacer(),
                      const BottomTextAuth(
                        textLeft: "New User?",
                        textRight: "Sign Up",
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}