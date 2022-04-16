import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grocery_shop/data/controller/auth_controller.dart';
import 'package:grocery_shop/model/bag_model.dart';
import 'package:grocery_shop/model/user_model.dart';

class FirebaseServices {
  //Authentication
  final FirebaseAuth fbAuth = FirebaseAuth.instance;

  // Cloud firestore
  CollectionReference<Map<String, dynamic>> categoriesRef =
      FirebaseFirestore.instance.collection('Collections');

  CollectionReference<Map<String, dynamic>> productsRef =
      FirebaseFirestore.instance.collection('Products');

  CollectionReference<Map<String, dynamic>> usersRef =
      FirebaseFirestore.instance.collection('Users');

  Future<void> addUserToFirebase(UserModel user) async {
    await usersRef.doc(user.userId).set(user.toJson(user));
  }

  Future<Map<String, dynamic>> getUserFromFirestore() async {
    DocumentSnapshot<Map<String, dynamic>> docSnapshot =
        await usersRef.doc(fbAuth.currentUser!.uid).get();
    Map<String, dynamic> docMap = docSnapshot.data() as Map<String, dynamic>;
    return docMap;
  }

  Stream<QuerySnapshot<Map<String, dynamic>>> getCategoriesFromFirebase() {
    return categoriesRef.snapshots();
  }

  Stream<QuerySnapshot> getProductsFromFirestore() {
    return productsRef.snapshots();
  }

  Stream<QuerySnapshot> getBagsFromFirestore() {
    return usersRef.doc(fbAuth.currentUser!.uid).collection('bag').snapshots();
  }

//is used in category screen i need to change it to stream
  Future<List<dynamic>> getAllCategoriesFromFirebase() async {
    DocumentSnapshot<Map<String, dynamic>> snapshot =
        await categoriesRef.doc('collections').get();
    var data = snapshot.data() as Map<String, dynamic>;
    var categoriesData = data['collections'] as List<dynamic>;
    return categoriesData;
  }

  Future<String> upDateProduct(String prodName, bool status) async {
    String msg = "";
    QuerySnapshot snapshot = await productsRef.get();
    for (var doc in snapshot.docs) {
      Map<String, dynamic> data = doc.data()! as Map<String, dynamic>;
      var name = data['name'] ?? "";
      if (name == prodName) {
        await productsRef
            .doc(doc.id)
            .update({'isFavorite': status})
            .then((value) => msg = status
                ? "favorite product successfuly added"
                : "favorite product successfuly removed")
            .catchError((err) => msg = "Failed to update Favorite: $err");
      }
    }
    return msg;
  }

  Future<String> updateUser(UserModel userModel) async {
    String msg = "";
    await usersRef
        .doc(userModel.userId)
        .update({"name": userModel.name, "email": userModel.email})
        .then((value) => msg = "User Updated successfuly")
        .catchError((err) => msg = "Failed to update user");
    return msg;
  }

  Future<void> reauthenticationUser(String email, String password) async {
    AuthCredential credential =
        EmailAuthProvider.credential(email: email, password: password);
    await fbAuth.currentUser!.reauthenticateWithCredential(credential);
  }

  Future<void> upDateBagId(String userId, String bagId) async {
    await usersRef
        .doc(userId)
        .collection('bag')
        .doc(bagId)
        .update({"id": bagId})
        .then((value) => print("bag id successfuly updated..."))
        .catchError((err) =>
            AuthController.snackbarBuilder("😡", "Failed to update bag id"));
  }

  Future<void> addBag(String userId, BagModel bag) async {
    QuerySnapshot snapshots =
        await usersRef.doc(userId).collection('bag').get();
    bool isExist = snapshots.docs.any((doc) {
      var data = doc.data() as Map<String, dynamic>;
      return data['productName']
          .toString()
          .toLowerCase()
          .contains(bag.productName.toLowerCase());
    });
    if (!isExist) {
      return await usersRef
          .doc(userId)
          .collection('bag')
          .add(
            bag.toJson(bag),
          )
          .then((value) {
        AuthController.snackbarBuilder(
            "😍", "Product added to bag successfuly");
        upDateBagId(userId, value.id);
        // ignore: invalid_return_type_for_catch_error
      }).catchError((err) => AuthController.snackbarBuilder(
              "😡", "Failed to add product to bag"));
    }
  }

  Future<void> upDateBag(String productName, String operation) async {
    QuerySnapshot snapshots =
        await usersRef.doc(fbAuth.currentUser!.uid).collection('bag').get();
    bool isExist = snapshots.docs.any((doc) {
      var data = doc.data() as Map<String, dynamic>;
      return productName
          .toLowerCase()
          .contains(data['productName'].toString().toLowerCase());
    });
    if (isExist) {
      var myDoc = snapshots.docs.firstWhere((doc) {
        var dataDoc = doc.data() as Map<String, dynamic>;
        return productName
            .toLowerCase()
            .contains(dataDoc['productName'].toString().toLowerCase());
      });
      var map = myDoc.data() as Map<String, dynamic>;
      usersRef
          .doc(fbAuth.currentUser!.uid)
          .collection('bag')
          .doc(myDoc.id)
          .update({
        "quantity": operation.contains("plus")
            ? map['quantity'] + 1
            : map['quantity'] > 1
                ? map['quantity'] - 1
                : 1
      });
    }
  }

  Future<String> removeBagFromFirestore(String bagId) async {
    String msg = "";
    await usersRef
        .doc(fbAuth.currentUser!.uid)
        .collection('bag')
        .doc(bagId)
        .delete()
        .then((value) => msg = "Bag deleted successfuly")
        .catchError((err) => msg = "Failed to delete bag");
    return msg;
  }

  Future<void> incBagQty(String userId, BagModel bag, int qty) async {
    await usersRef.doc(userId).collection('bag').doc(bag.id).update({
      "quantity": qty + 1,
    });
  }

  Future<void> decBagQty(String userId, BagModel bag, int qty) async {
    await usersRef.doc(userId).collection('bag').doc(bag.id).update({
      "quantity": qty > 1 ? qty - 1 : 1,
    });
  }

  Future<List<Map<String, dynamic>>> getAllBagsFromFirestore() async {
    List<Map<String, dynamic>> bags = [];
    QuerySnapshot snapshots =
        await usersRef.doc(fbAuth.currentUser!.uid).collection('bag').get();
    for (var doc in snapshots.docs) {
      var data = doc.data() as Map<String, dynamic>;
      bags.add(data);
    }
    return bags;
  }
}
