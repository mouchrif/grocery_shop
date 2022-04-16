import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:grocery_shop/view/screens/sign_in_screen.dart';
import 'package:grocery_shop/view/screens/sign_up_screen.dart';

class BottomTextAuth extends StatelessWidget {
  final String textLeft;
  final String textRight;
  const BottomTextAuth({Key? key, required this.textLeft, required this.textRight}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          textLeft,
          style: Theme.of(context).textTheme.bodyText1,
        ),
        TextButton(
          onPressed: () {
            if(textRight == "Sign Up"){
              Get.offAll(() => const SignUpScreen(), transition: Transition.fade);
            }else{
              Get.offAll(() => const SignInScreen(), transition: Transition.fade);
            }
          },
          child: Text(
            textRight,
            style: Theme.of(context).textTheme.bodyText1!.copyWith(
              color: Theme.of(context).primaryColor,
              fontSize: 16.0,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}
