import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:grocery_shop/constants.dart';
import 'package:grocery_shop/data/controller/auth_controller.dart';
import 'package:grocery_shop/view/widgets/profile_card.dart';
import 'package:grocery_shop/view/widgets/profile_email_form_field.dart';
import 'package:grocery_shop/view/widgets/profile_image.dart';
import 'package:grocery_shop/view/widgets/profile_name_field.dart';

class ProfileDetailsScreen extends StatelessWidget {
  const ProfileDetailsScreen({Key? key}) : super(key: key);

  get kWhiteColor => null;

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final authCtrlr = Get.find<AuthController>();
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).primaryColor,
        leading: BackButton(
          onPressed: () {
            Get.back();
          },
        ),
        title: const Text("profile"),
        centerTitle: true,
        actions: [
          IconButton(
            onPressed: () async {
              if (authCtrlr.getEnabledName() || authCtrlr.getEnabledEmail()) {
                authCtrlr.checkProfileFields();
              }
              // if (authCtrlr.getEnabledEmail()) {
              //   // authCtrlr.setEnabledEmail(false);
              //   await authCtrlr.checkProfileFields();
              // }
            },
            icon: const Icon(FontAwesomeIcons.save),
          ),
        ],
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            Container(
              color: Theme.of(context).primaryColor,
              height: size.height * 0.3,
              width: size.width,
              child: CustomPaint(
                painter: ProfileCard(context: context),
                child: Center(
                  child: ProfileImage(
                    size: size,
                    colorBg: kHeartColor,
                    colorIcon: Colors.white,
                  ),
                ),
              ),
            ),
            Padding(
              padding: EdgeInsets.symmetric(
                horizontal: size.width * 0.04,
                vertical: size.height * 0.02,
              ),
              child: Form(
                key: authCtrlr.formProfileUpdateInfos,
                autovalidateMode: AutovalidateMode.disabled,
                child: Column(
                  children: [
                    Row(
                      children: [
                        Expanded(
                          child: ProfileNameFormField(
                            user: authCtrlr.fbServices.fbAuth.currentUser!,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            if (!authCtrlr.getEnabledName()) {
                              authCtrlr.setEnabledName(true);
                            }
                          },
                          icon: const Icon(FontAwesomeIcons.pen),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.02),
                    Row(
                      children: [
                        Expanded(
                          child: ProfileEmailFormField(
                            user: authCtrlr.fbServices.fbAuth.currentUser!,
                          ),
                        ),
                        IconButton(
                          onPressed: () {
                            if (!authCtrlr.getEnabledEmail()) {
                              authCtrlr.setEnabledEmail(true);
                            }
                          },
                          icon: const Icon(FontAwesomeIcons.pen),
                        ),
                      ],
                    ),
                    SizedBox(height: size.height * 0.02),
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
