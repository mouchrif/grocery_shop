import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:grocery_shop/constants.dart';
import 'package:grocery_shop/data/controller/bag_controller.dart';
import 'package:grocery_shop/model/bag_model.dart';
import 'package:grocery_shop/view/widgets/back_btn.dart';
import 'package:grocery_shop/view/widgets/big_btn.dart';
import 'package:grocery_shop/view/widgets/custom_price_widget.dart';
import 'package:grocery_shop/view/widgets/quantity_btn.dart';

class CartScreen extends StatelessWidget {
  final bool isBackBtn;
  const CartScreen({Key? key, required this.isBackBtn}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    final controller = Get.put(BagController());
    return Scaffold(
      body: Padding(
        padding: EdgeInsets.only(
            top: statusBarHeight + size.height * 0.02,
            left: size.width * 0.04,
            right: size.width * 0.04,
            bottom: size.height * 0.02),
        child: Stack(
          children: [
            StreamBuilder(
                stream: controller.getBagsStreamFromFirestore(),
                builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(
                      child: CircularProgressIndicator(
                        color: Theme.of(context).primaryColor,
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return const Center(
                      child: Text("Something went wrong..."),
                    );
                  } else {
                    var data = snapshot.data!;
                    List<BagModel> bags = data.docs.map((doc) {
                      var map = doc.data() as Map<String, dynamic>;
                      return BagModel.fromJson(map);
                    }).toList();
                    controller.totalPrice(bags);
                    return Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        isBackBtn
                            ? SizedBox(
                                height: size.height * 0.045,
                                child: BackBtn(width: size.width * 0.2),
                              )
                            : const SizedBox(),
                        isBackBtn
                            ? SizedBox(
                                height: size.height * 0.02,
                              )
                            : const SizedBox(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            Text(
                              "My Bag",
                              style: Theme.of(context)
                                  .textTheme
                                  .headline5!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: Theme.of(context).primaryColor,
                                  ),
                            ),
                            Text(
                              "${bags.length} items",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText1!
                                  .copyWith(
                                    fontWeight: FontWeight.bold,
                                  ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: size.height * 0.02,
                        ),
                        Expanded(
                          flex: 1,
                          child: bags.isEmpty
                              ? const Center(
                                  child: Text("no product added to your bag"),
                                )
                              : ListView.builder(
                                  padding: EdgeInsets.only(
                                      top: 0, bottom: size.height * 0.01),
                                  physics: const BouncingScrollPhysics(),
                                  itemCount: bags.length,
                                  itemBuilder: (context, index) {
                                    return Dismissible(
                                      key: Key(
                                          "card ${bags[index].productName}"),
                                      background: Container(
                                        padding: EdgeInsets.only(
                                            right: size.width * 0.04),
                                        decoration: BoxDecoration(
                                          color: Colors.transparent,
                                          borderRadius: BorderRadius.circular(
                                              kDefaultBorderRadius),
                                        ),
                                      ),
                                      secondaryBackground: Container(
                                        padding: EdgeInsets.only(
                                            right: size.width * 0.04),
                                        decoration: BoxDecoration(
                                          color: kHeartColor.withOpacity(0.8),
                                          borderRadius: BorderRadius.circular(
                                              kDefaultBorderRadius),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.end,
                                          children: const [
                                            Icon(
                                              FontAwesomeIcons.solidTrashAlt,
                                              color: kWhiteColor,
                                            ),
                                          ],
                                        ),
                                      ),
                                      onDismissed:
                                          (DismissDirection direction) {
                                        if (direction ==
                                            DismissDirection.endToStart) {
                                          controller.removeBag(bags[index].id);
                                        }
                                      },
                                      child: Card(
                                        color: Color(int.parse(bags[index]
                                            .color
                                            .split('(')[1]
                                            .split(')')[0])),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                              kDefaultBorderRadius),
                                        ),
                                        child: Padding(
                                          padding: EdgeInsets.symmetric(
                                            vertical: size.height * 0.02,
                                            horizontal: size.width * 0.04,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Image.network(
                                                bags[index].productImage,
                                                height: size.height * 0.08,
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.start,
                                                children: [
                                                  Text(
                                                    bags[index].productName,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .headline6,
                                                  ),
                                                  Text(
                                                    "${bags[index].quantity} Kg",
                                                  ),
                                                  CustomPriceWidget(
                                                    text: (bags[index]
                                                                .productPrice *
                                                            bags[index]
                                                                .quantity)
                                                        .toString(),
                                                  ),
                                                ],
                                              ),
                                              Column(
                                                crossAxisAlignment:
                                                    CrossAxisAlignment.end,
                                                children: [
                                                  CircleAvatar(
                                                    radius: size.height * 0.015,
                                                    backgroundColor:
                                                        bags[index].isFavorite
                                                            ? kHeartColor
                                                            : kWhiteColor,
                                                    child: Icon(
                                                      FontAwesomeIcons
                                                          .solidHeart,
                                                      color:
                                                          bags[index].isFavorite
                                                              ? kWhiteColor
                                                              : kHeartColor,
                                                      size: size.height * 0.015,
                                                    ),
                                                  ),
                                                  SizedBox(
                                                      height:
                                                          size.height * 0.01),
                                                  Row(
                                                    children: [
                                                      QuantityBtn(
                                                        width: size.width *
                                                            0.11 /
                                                            1.5,
                                                        height: size.height *
                                                            0.055 /
                                                            1.5,
                                                        borderRadius:
                                                            kDefaultBorderRadius /
                                                                2,
                                                        text: "-",
                                                        color: Theme.of(context)
                                                            .primaryColor
                                                            .withOpacity(0.6),
                                                        textColor: kWhiteColor,
                                                        onTapFunc: () async {
                                                          await controller
                                                              .decQty(
                                                                  bags[index]);
                                                        },
                                                      ),
                                                      SizedBox(
                                                          width: size.width *
                                                              0.01),
                                                      Text(
                                                        bags[index]
                                                            .quantity
                                                            .toString(),
                                                        style: Theme.of(context)
                                                            .textTheme
                                                            .headline6,
                                                      ),
                                                      SizedBox(
                                                          width: size.width *
                                                              0.01),
                                                      QuantityBtn(
                                                        width: size.width *
                                                            0.11 /
                                                            1.5,
                                                        height: size.height *
                                                            0.055 /
                                                            1.5,
                                                        borderRadius:
                                                            kDefaultBorderRadius /
                                                                2,
                                                        text: "+",
                                                        color: Theme.of(context)
                                                            .primaryColor
                                                            .withOpacity(0.6),
                                                        textColor: kWhiteColor,
                                                        onTapFunc: () async {
                                                          await controller
                                                              .incQty(
                                                                  bags[index]);
                                                        },
                                                      ),
                                                    ],
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                        ),
                        SizedBox(
                          height: size.height * 0.01,
                        ),
                        Expanded(
                          flex: 1,
                          child: SingleChildScrollView(
                            physics: const BouncingScrollPhysics(),
                            child: Column(
                              // mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Card(
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(
                                        kDefaultBorderRadius * 1.4),
                                  ),
                                  color: Colors.grey.shade200,
                                  child: Padding(
                                    padding:
                                        EdgeInsets.all(kDefaultPadding / 2.5),
                                    child: Row(
                                      children: [
                                        Expanded(
                                          flex: 2,
                                          child: TextFormField(
                                            keyboardType: TextInputType.text,
                                            textInputAction:
                                                TextInputAction.done,
                                            cursorColor:
                                                Theme.of(context).primaryColor,
                                            decoration: InputDecoration(
                                              border: InputBorder.none,
                                              hintText: "Enter your coupon"
                                                  .toUpperCase(),
                                            ),
                                          ),
                                        ),
                                        SizedBox(width: size.width * 0.02),
                                        Expanded(
                                          child: ElevatedButton(
                                            onPressed: () {},
                                            style: ElevatedButton.styleFrom(
                                              padding: EdgeInsets.all(kDefaultPadding),
                                              shape: RoundedRectangleBorder(
                                              borderRadius: BorderRadius.circular(kDefaultBorderRadius),
                                            ),
                                            ),
                                            child: const Text("Apply"),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                                SizedBox(
                                  height: size.height * 0.01,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("Total"),
                                    Obx(() => CustomPriceWidget(
                                        text: "${controller.getTotal()}")),
                                  ],
                                ),
                                SizedBox(
                                  height: size.height * 0.01,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Text(
                                      "Discount",
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText1!
                                          .copyWith(
                                            color: kHeartColor,
                                          ),
                                    ),
                                    Obx(
                                      () => CustomPriceWidget(
                                          text: "${controller.getDiscount()}",
                                          textColor: kHeartColor),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: size.height * 0.02,
                                ),
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    const Text("Total"),
                                    Obx(() => CustomPriceWidget(
                                        text:
                                            "${controller.getTotal() - controller.getDiscount() < 0 ? 0.0 : (controller.getTotal() - controller.getDiscount())}")),
                                  ],
                                ),
                                // SizedBox(
                                //   height: size.height * 0.02,
                                // ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                }),
            Align(
              alignment: Alignment.bottomCenter,
              child: BigBtn(
                width: size.width - size.width * 0.08, 
                height: size.height * 0.075, 
                text: "Proceed To Checkout",
                onPressed: (){},
              )
            ),
          ],
        ),
      ),
    );
  }
}

/*

*/