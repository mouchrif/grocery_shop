import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:grocery_shop/data/controller/auth_controller.dart';
import 'package:grocery_shop/data/controller/product_controller.dart';
import 'package:grocery_shop/data/service/firebase_services.dart';
import 'package:grocery_shop/model/bag_model.dart';

class BagController extends GetxController {
  FirebaseServices fbServices = FirebaseServices();
  final productCtrlr = Get.find<ProductController>();

  final _bags = <BagModel>[].obs;
  List<BagModel> getBags() => _bags;

  Stream<QuerySnapshot> getBagsStreamFromFirestore() {
    return fbServices.getBagsFromFirestore();
  }

  Future<void> incQty(BagModel bag) async {
    await fbServices.incBagQty(
      fbServices.fbAuth.currentUser!.uid,
      bag,
      bag.quantity,
    );
  }

  Future<void> decQty(BagModel bag) async {
    await fbServices.decBagQty(
      fbServices.fbAuth.currentUser!.uid,
      bag,
      bag.quantity,
    );
  }

  final _total = 0.0.obs;
  double getTotal() => _total.value;
  void setTotal(double ttl) => _total.value = ttl;

  final _discount = 1.0.obs;
  double getDiscount() => _discount.value;

  void totalPrice(List<BagModel> bags) {
    _total.value = 0.0;
    for (var bag in bags) {
      _total.value += bag.productPrice * bag.quantity;
    }
  }

  Future<void> addBag(String userId, BagModel bag) async {
    await fbServices.addBag(userId, bag);
  }

  Future<void> upDateBag(String productName, String operation) async {
    return await fbServices.upDateBag(productName, operation);
  }

  Future<void> removeBag(String bagId) async {
    await fbServices
        .removeBagFromFirestore(bagId)
        .then((value) => AuthController.snackbarBuilder("🙏", value));
  }

  Future<void> getBagsFromFirestore() async {
    List<Map<String, dynamic>> bagsMap =
        await fbServices.getAllBagsFromFirestore();
    if (_bags.isNotEmpty) {
      _bags.clear();
    } else {
      for (var bagMap in bagsMap) {
        _bags.add(BagModel.fromJson(bagMap));
        // totalPrice(_bags);
      }
    }
  }

  @override
  void onInit() async {
    super.onInit();
    await getBagsFromFirestore();
  }
}
