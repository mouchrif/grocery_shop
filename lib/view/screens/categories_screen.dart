import 'package:flutter/material.dart';
import 'package:grocery_shop/animations/delayed_animation.dart';
import 'package:grocery_shop/constants.dart';
import 'package:grocery_shop/view/widgets/categories_grid_view.dart';
import 'package:grocery_shop/view/widgets/keyboard_hider.dart';
import 'package:grocery_shop/view/widgets/menu_icon_row.dart';
import 'package:grocery_shop/view/widgets/search_row.dart';
import 'package:grocery_shop/view/widgets/shopping_and_bach.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final Size size = MediaQuery.of(context).size;
    const int durationInMilliseconds = 500;
    const Duration initialDelay =
        Duration(milliseconds: durationInMilliseconds);
    const double coefficient = 1.8;
    return Scaffold(
      body: KeyBoardHider(
        child: Padding(
            padding: padding(statusBarHeight),
            child: Column(
              children: [
                Column(
                  children: [
                    DelayedAnimation(
                      delay: Duration(
                          milliseconds: initialDelay.inMilliseconds +
                              0 * (durationInMilliseconds ~/ coefficient)),
                      child: ShoppintAndBack(
                        isRight: false,
                      ),
                    ),
                    SizedBox(
                      height: size.height*0.01,
                    ),
                    DelayedAnimation(
                      delay: Duration(
                          milliseconds: initialDelay.inMilliseconds +
                              1 * (durationInMilliseconds ~/ coefficient)),
                      child: SearchRow(
                        size: size,
                        hintText: "Search Fresh Grocery",
                        isRight: false,
                      ),
                    ),
                    SizedBox(
                      height: size.height*0.01,
                    ),
                    DelayedAnimation(
                      delay: Duration(
                          milliseconds: initialDelay.inMilliseconds +
                              2 * (durationInMilliseconds ~/ coefficient)),
                      child: const AllAndMenuIconRowWidget(
                        text: "All Categories",
                        isIconExist: false,
                        txt: "",
                      ),
                    ),
                  ],
                ),
                const Expanded(
                  child: CategoriesGridViewBuilder(),
                ),
                // Expanded(
                //   child: DelayedAnimation(
                //     delay: Duration(
                //         milliseconds: initialDelay.inMilliseconds +
                //             3 * (durationInMilliseconds ~/ coefficient)),
                //     child: const CategoriesGridViewBuilder(),
                //   ),
                // ),
              ],
            ),
          ),
      ),
    );
  }
}
