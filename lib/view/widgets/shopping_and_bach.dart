import 'package:badges/badges.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:grocery_shop/constants.dart';
import 'package:grocery_shop/data/controller/bag_controller.dart';
import 'package:grocery_shop/data/controller/text_form_feltring_controller.dart';
import 'package:grocery_shop/model/bag_model.dart';
import 'package:grocery_shop/view/screens/cart_screen.dart';

class ShoppintAndBack extends StatelessWidget {
  final bool isRight;
  ShoppintAndBack({Key? key, required this.isRight}) : super(key: key);
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    final textFieldCtrlr = Get.find<FiletringTextForm>();
    final bagCtrlr = Get.find<BagController>();
    return Padding(
      padding: rightPadding(isRight: isRight),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          InkWell(
            onTap: () {
              textFieldCtrlr.clearTextField();
              Get.back();
            },
            child: Container(
              padding: EdgeInsets.symmetric(
                vertical: kDefaultPadding / 4,
                horizontal: kDefaultPadding,
              ),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(kDefaultBorderRadius * 2),
                border: Border.all(
                  color: Theme.of(context).primaryColor,
                ),
              ),
              child: const Icon(FontAwesomeIcons.longArrowAltLeft),
            ),
          ),
          StreamBuilder(
              stream: bagCtrlr.getBagsStreamFromFirestore(),
              builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                if (snapshot.hasData) {
                  List<BagModel> bags = snapshot.data!.docs.map((doc) {
                    var map = doc.data()! as Map<String, dynamic>;
                    return BagModel.fromJson(map);
                  }).toList();
                  int qty = 0;
                  for (var bag in bags) {
                    qty += bag.quantity;
                  }
                  return Badge(
                    elevation: 0,
                    position: BadgePosition.topEnd(top: 0, end: 2),
                    badgeContent: Text(
                      "$qty",
                      style: Theme.of(context).textTheme.bodyText1!.copyWith(
                            color: kWhiteColor,
                          ),
                    ),
                    child: IconButton(
                      onPressed: () {
                        Get.to(
                          () => const CartScreen(isBackBtn: true),
                          transition: Transition.fade,
                        );
                      },
                      icon: const Icon(FontAwesomeIcons.shoppingBag),
                    ),
                  );
                } else {
                  return const SizedBox();
                }
              }),
        ],
      ),
    );
  }
}
