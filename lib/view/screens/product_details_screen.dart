import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:grocery_shop/constants.dart';
import 'package:grocery_shop/data/controller/bag_controller.dart';
import 'package:grocery_shop/data/controller/product_controller.dart';
import 'package:grocery_shop/model/bag_model.dart';
import 'package:grocery_shop/model/product_model.dart';
import 'package:grocery_shop/view/widgets/custom_price_widget.dart';
import 'package:grocery_shop/view/widgets/custom_shape.dart';
import 'package:grocery_shop/view/widgets/quantity_btn.dart';
import 'package:grocery_shop/view/widgets/shopping_and_bach.dart';

class ProductDetailsScreen extends StatelessWidget {
  const ProductDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final Size size = MediaQuery.of(context).size;
    final args = Get.arguments;
    final productCtrlr = Get.find<ProductController>();
    final bagCtrlr = Get.put(BagController());
    return Scaffold(
      body: _buildProductDetails(size, args, context, productCtrlr, bagCtrlr),
    );
  }
}

Widget _buildProductDetails(Size size, dynamic args, BuildContext context,
    ProductController productCtrlr, BagController bagCtrlr) {
  return Stack(
    children: [
      Positioned(
        top: 0,
        left: 0,
        right: 0,
        child: ClipPath(
          clipper: CustomShape(),
          child: Container(
            height: size.height - size.height * 0.45 + 5*kSize10,
            color: args['color'],
            child: Stack(
              children: [
                Positioned(
                  top: MediaQuery.of(context).padding.top + size.height * 0.02,
                  left: size.width * 0.04,
                  right: size.width * 0.04,
                  child: ShoppintAndBack(isRight: false),
                ),
                Align(
                  alignment: Alignment.center,
                  child: Hero(
                    tag: args['product'].imagePath,
                    child: Image.network(
                      args['product'].imagePath,
                      height: size.height * 0.25,
                    ),
                  ),
                ),
                Positioned(
                  bottom: size.height * 0.1,
                  left: size.width / 2 - size.width / 4,
                  child: ClipOval(
                    child: Container(
                      color: Colors.grey.withOpacity(0.08),
                      height: size.height * 0.04,
                      width: size.width * 0.5,
                    ),
                  ),
                ),
                Positioned(
                  right: size.width * 0.04,
                  bottom: size.height * 0.07,
                  child: StreamBuilder(
                      stream: productCtrlr.getProductsFromFirestore(),
                      builder:
                          (context, AsyncSnapshot<QuerySnapshot> snapshot) {
                        if (snapshot.hasError) {
                          return const Text("Something went wrong...");
                        } else if (snapshot.connectionState ==
                            ConnectionState.waiting) {
                          return Center(
                            child: CircularProgressIndicator(
                              color: Theme.of(context).primaryColor,
                            ),
                          );
                        } else {
                          final List<Map<String, dynamic>> snapshotsMap =
                              snapshot.data!.docs
                                  .map((doc) =>
                                      doc.data()! as Map<String, dynamic>)
                                  .toList();
                          final productMap = snapshotsMap.firstWhere((el) {
                            return el['name'] == args['product'].name;
                          });
                          Product product = Product.fromJson(productMap);
                          return InkWell(
                            onTap: () async {
                              String message = await productCtrlr.upDateProduct(
                                  product.name,
                                  product.isFavorite ? false : true);
                              Get.snackbar(
                                "",
                                "",
                                titleText: Text(
                                  "👇",
                                  style: Theme.of(context).textTheme.headline6,
                                ),
                                messageText: Text(
                                  message,
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyText1!
                                      .copyWith(
                                        color: kWhiteColor,
                                      ),
                                ),
                                snackPosition: SnackPosition.TOP,
                                backgroundColor: message.contains("successfuly")
                                    ? Theme.of(context).primaryColor
                                    : kHeartColor,
                              );
                            },
                            child: CircleAvatar(
                              radius: size.height * 0.044,
                              backgroundColor: kHeartColor.withOpacity(0.2),
                              child: CircleAvatar(
                                radius: size.height * 0.04,
                                backgroundColor: kWhiteColor,
                                child: Center(
                                  child: CircleAvatar(
                                    radius: size.height * 0.036,
                                    backgroundColor: product.isFavorite
                                        ? kHeartColor
                                        : kWhiteColor,
                                    child: Center(
                                      child: Icon(
                                        FontAwesomeIcons.solidHeart,
                                        color: product.isFavorite
                                            ? kWhiteColor
                                            : kHeartColor,
                                      ),
                                    ),
                                  ),
                                ),
                              ),
                            ),
                          );
                        }
                      }),
                ),
              ],
            ),
          ),
        ),
      ),
      Positioned(
        left: 0,
        right: 0,
        bottom: 0,
        height: size.height * 0.45 - 5*kSize10,
        child: Container(
          color: Colors.transparent,
          child: Stack(
            children: [
              Positioned(
                top: 0,
                left: 0,
                right: 0,
                child: Container(
                  height: ((size.height * 0.45 - 5*kSize10) - size.height * 0.1),
                  padding: EdgeInsets.only(
                    left: size.width * 0.04,
                    right: size.width * 0.04,
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(
                            FontAwesomeIcons.shippingFast,
                            color: Theme.of(context).primaryColor,
                          ),
                          SizedBox(width: size.width * 0.04),
                          Text(
                            "Free Shipping",
                            style:
                                Theme.of(context).textTheme.bodyText1!.copyWith(
                                      color: kPrimaryColor,
                                    ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Text(
                        args['product'].name,
                        style: Theme.of(context).textTheme.headline5!.copyWith(
                              color: Theme.of(context).primaryColor,
                            ),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Row(
                        children: [
                          Container(
                            height: size.height * 0.04,
                            decoration: BoxDecoration(
                              border: Border.all(
                                color: kTextColorLightTheme,
                              ),
                              borderRadius:
                                  BorderRadius.circular(kDefaultBorderRadius),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(kDefaultPadding/4),
                              child: Row(
                                children: [
                                  Icon(
                                    FontAwesomeIcons.solidStar,
                                    size: kSize14,
                                    color: Colors.yellow,
                                  ),
                                  SizedBox(width: size.width * 0.02),
                                  Text(
                                    "4,7",
                                    style: Theme.of(context).textTheme.bodyText1,
                                  ),
                                ],
                              ),
                            ),
                          ),
                          SizedBox(
                            width: size.width * 0.02,
                          ),
                          Container(
                            height: size.height * 0.04,
                            decoration: BoxDecoration(
                              color: args['color'],
                              border: Border.all(
                                color: kTextColorLightTheme,
                              ),
                              borderRadius:
                                  BorderRadius.circular(kDefaultBorderRadius),
                            ),
                            child: Padding(
                              padding: EdgeInsets.all(kDefaultPadding/4),
                              child: Row(
                                children: [
                                  Image.network(
                                    args['product'].imagePath,
                                    height: size.height * 0.04,
                                  ),
                                  SizedBox(
                                    width: size.width * 0.01,
                                  ),
                                  Text(
                                    args['product'].category[0],
                                  ),
                                ],
                              ),
                            ),
                          ),
                          const Spacer(),
                          CustomPriceWidget(
                              text: "${args['product'].price}/Kg"),
                        ],
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Text(
                        "Description",
                        style: Theme.of(context).textTheme.headline6!.copyWith(
                              color: Theme.of(context).primaryColor,
                            ),
                      ),
                      SizedBox(
                        height: size.height * 0.01,
                      ),
                      Expanded(
                        child: SingleChildScrollView(
                          physics: const BouncingScrollPhysics(),
                          child: Text(
                            "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Dui id ornare arcu odio ut sem nulla. Aliquet bibendum enim facilisis gravida. Posuere lorem ipsum dolor sit amet consectetur adipiscing.",
                            style: Theme.of(context).textTheme.bodyText1,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Positioned(
                left: size.width / 2,
                right: 0,
                bottom: 0,
                child: Material(
                  color: Theme.of(context).primaryColor,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(kDefaultBorderRadius * 2),
                  ),
                  child: InkWell(
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(kDefaultBorderRadius * 2),
                    ),
                    onTap: () async {
                      await bagCtrlr.addBag(
                        productCtrlr.fbService.fbAuth.currentUser!.uid,
                        BagModel(
                          id: productCtrlr.fbService.usersRef
                              .doc(productCtrlr
                                  .fbService.fbAuth.currentUser!.uid)
                              .collection('bag')
                              .doc()
                              .id,
                          productImage: args['product'].imagePath,
                          productPrice: args['product'].price,
                          productName: args['product'].name,
                          quantity: productCtrlr.getQuantity(),
                          color: args['color'].toString(),
                          isFavorite: args['product'].isFavorite,
                        ),
                      );
                      // Get.to(
                      //   () => MyHomeScreen(),
                      //   transition: Transition.fade,
                      // );
                    },
                    child: SizedBox(
                      height: size.height * 0.08,
                      child: Center(
                        child: Text(
                          "Add To Bag",
                          style:
                              Theme.of(context).textTheme.headline6!.copyWith(
                                    color: kWhiteColor,
                                  ),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              Positioned(
                left: 0,
                right: size.width / 2,
                bottom: 0,
                child: Container(
                  color: Colors.transparent,
                  height: size.height * 0.08,
                  child: Center(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        QuantityBtn(
                          width: size.width * 0.11,
                          height: size.height * 0.055,
                          text: "-",
                          onTapFunc: () {
                            if(productCtrlr.getQuantity()!=1){
                              bagCtrlr.upDateBag(args['product'].name, "minus");
                            }
                            productCtrlr.decQte();
                          },
                        ),
                        Obx(
                          () => Text(
                            productCtrlr.getQuantity().toString(),
                            style: Theme.of(context).textTheme.headline6,
                          ),
                        ),
                        QuantityBtn(
                          width: size.width * 0.11,
                          height: size.height * 0.055,
                          text: "+",
                          onTapFunc: () {
                            productCtrlr.incQte();
                            bagCtrlr.upDateBag(args['product'].name, "plus");
                          },
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    ],
  );
}
