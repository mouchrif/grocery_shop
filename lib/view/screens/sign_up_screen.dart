import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_shop/constants.dart';
import 'package:grocery_shop/data/controller/auth_controller.dart';
import 'package:grocery_shop/view/widgets/back_btn.dart';
import 'package:grocery_shop/view/widgets/bottom_text_auth.dart';
import 'package:grocery_shop/view/widgets/btn_builder.dart';
import 'package:grocery_shop/view/widgets/social_auth.dart';
import 'package:grocery_shop/view/widgets/validated_email_builder.dart';
import 'package:grocery_shop/view/widgets/validated_name.dart';
import 'package:grocery_shop/view/widgets/validated_password_builder.dart';

class SignUpScreen extends GetWidget<AuthController> {
  const SignUpScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final Size size = MediaQuery.of(context).size;
    return Scaffold(
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: EdgeInsets.only(
            top: kDefaultPadding + statusBarHeight,
            left: kDefaultPadding,
            right: kDefaultPadding,
            bottom: kDefaultPadding,
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
                    onTap: () {},
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
                      Text(
                        "Welcome to Grofast!",
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                              // letterSpacing: 1.15,
                              color: Theme.of(context).primaryColor,
                              fontWeight: FontWeight.bold,
                            ),
                      ),
                      const Spacer(),
                      Form(
                        key: controller.formSignUpKey,
                        autovalidateMode: AutovalidateMode.onUserInteraction,
                        child: Column(
                          children: [
                            ValidatedNameBuilder(controller: controller),
                            SizedBox(
                              height: constraints.maxHeight * 0.02,
                            ),
                            ValidatedEmailBuilder(controller: controller),
                            SizedBox(
                              height: constraints.maxHeight * 0.02,
                            ),
                            ValidatedPasswordBuilder(controller: controller),
                            SizedBox(
                              height: constraints.maxHeight * 0.02 * 2,
                            ),
                            BtnBuilder(
                              text: "Sign Up",
                              height: size.height * 0.075,
                              onTapFunc: () async {
                                await controller.checkRegisteration(context);
                                controller.resetFields();
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
                        icons: Get.find<AuthController>().getIcons(),
                      ),
                      const Spacer(),
                      const BottomTextAuth(
                        textLeft: "Already have an account?",
                        textRight: "Sign In",
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
