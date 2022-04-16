import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:grocery_shop/constants.dart';
import 'package:grocery_shop/data/controller/auth_controller.dart';
import 'package:grocery_shop/data/controller/product_controller.dart';
import 'package:grocery_shop/view/widgets/custom_paint_shape.dart';
import 'package:grocery_shop/view/widgets/profile_image.dart';

class ProfileScreen extends StatelessWidget {
  final User? user;
  const ProfileScreen({Key? key, this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final authCtrlr = Get.find<AuthController>();
    final productCtrlr = Get.find<ProductController>();
    List<Map<String, dynamic>> links = [
      {
        "iconData": FontAwesomeIcons.user,
        "text": "Profile",
        "nb": false,
      },
      {
        "iconData": FontAwesomeIcons.heart,
        "text": "Favorites",
        "nb": true,
      },
      {
        "iconData": FontAwesomeIcons.firstOrder,
        "text": "Orders",
        "nb": true,
      },
      {
        "iconData": FontAwesomeIcons.key,
        "text": "Change password",
        "nb": false,
      },
    ];
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: 0,
            left: 0,
            right: 0,
            height: size.height * 0.4,
            child: CustomPaint(
              painter: CustomPaintShape(context: context),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  ProfileImage(
                    size: size,
                    // colorBg: Theme.of(context).primaryColor,
                    // colorIcon: kWhiteColor,
                  ),
                  SizedBox(height: size.height * 0.01),
                  FutureBuilder(
                      future: authCtrlr.getUserFromFireStore(),
                      builder: (context, AsyncSnapshot snapshot) {
                        if (snapshot.hasData) {
                          return Text(
                            snapshot.data.name,
                            style:
                                Theme.of(context).textTheme.headline6!.copyWith(
                                      color: Theme.of(context).primaryColor,
                                    ),
                          );
                        } else {
                          return const Text("");
                        }
                      }),
                  // Obx(() => Text(
                  //   authCtrlr.getUser().name!,
                  //   style: Theme.of(context).textTheme.headline6!.copyWith(
                  //         color: Theme.of(context).primaryColor,
                  //       ),
                  // ),),
                ],
              ),
            ),
          ),
          Positioned(
            left: 0,
            right: 0,
            bottom: 0,
            height: size.height - size.height * 0.4,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ...List.generate(
                  links.length,
                  (index) {
                    return GestureDetector(
                      onTap: () {
                        productCtrlr.getSpecificScreen(index, links[index]);
                      },
                      child: Padding(
                        padding: EdgeInsets.symmetric(
                          horizontal: size.width * 0.06,
                          vertical: size.height * 0.015,
                        ),
                        child: Row(
                          children: [
                            Icon(
                              links[index]['iconData'] as IconData,
                            ),
                            SizedBox(width: size.width * 0.08),
                            Text(
                              links[index]['text'].toString(),
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                      fontSize: 2*kSize10,
                                      fontWeight: FontWeight.w600),
                            ),
                            const Spacer(),
                            links[index]['nb']
                                ? CircleAvatar(
                                    radius: size.height * 0.02,
                                    backgroundColor:
                                        Theme.of(context).primaryColor,
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: Text(
                                        productCtrlr
                                            .getNbrOfFavorites()
                                            .toString(),
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1!
                                            .copyWith(
                                              color: kWhiteColor,
                                            ),
                                      ),
                                    ),
                                  )
                                : const SizedBox(),
                          ],
                        ),
                      ),
                    );
                  },
                ).toList(),
              ],
            ),
          ),
          Align(
            alignment: Alignment.bottomCenter,
            child: SizedBox(
              height: size.height * 0.08,
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  IconButton(
                    onPressed: () async {
                      await authCtrlr.logout();
                    },
                    icon: const Icon(
                      FontAwesomeIcons.signOutAlt,
                    ),
                  ),
                  Text(
                    "Logout",
                    style: Theme.of(context)
                        .textTheme
                        .bodyText1!
                        .copyWith(fontWeight: FontWeight.bold),
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
