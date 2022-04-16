import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_shop/constants.dart';
import 'package:grocery_shop/data/controller/auth_controller.dart';
import 'package:grocery_shop/view/widgets/big_btn.dart';
import 'package:grocery_shop/view/widgets/validated_password_builder.dart';

class ForgotPasswordScreen extends StatelessWidget {
  const ForgotPasswordScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final authCtrlr = Get.find<AuthController>();
    return Scaffold(
      appBar: AppBar(
        title: const Text("New Password"),
      ),
      body: Padding(
        padding: EdgeInsets.all(kDefaultPadding),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Spacer(),
            SizedBox(
              width: size.width * 0.8,
              child: const Text(
                "At least 6 character with uppercase, lowercase, numbers and special character",
                textAlign: TextAlign.center,
              ),
            ),
            const Spacer(),
            Form(
              key: authCtrlr.formChangePassword,
              autovalidateMode: AutovalidateMode.onUserInteraction,
              child: Column(
                children: [
                  ValidatedPasswordBuilder(
                    controller: authCtrlr,
                    labelText: "New Password",
                  ),
                  SizedBox(height: size.height * 0.02),
                  ValidatedPasswordBuilder(
                    controller: authCtrlr,
                    hintText: "Confirm your password",
                    labelText: "Confirm Password",
                  ),
                  SizedBox(height: size.height * 0.02 * 2),
                  BigBtn(
                    width: size.width - size.width * 0.08,
                    height: size.height * 0.075,
                    text: "Change Password",
                    onPressed: () async {
                      await authCtrlr.checkChangePassword();
                    },
                  ),
                ],
              ),
            ),
            const Spacer(flex: 4),
          ],
        ),
      ),
    );
  }
}
