import 'package:grocery_shop/model/bag_model.dart';

class UserModel {
  final String? userId;
  final String? email;
  final String? name;
  final List<BagModel>? bag;

  UserModel({
    required this.userId,
    required this.name,
    required this.email,
    this.bag,
  });

  factory UserModel.fromJson(Map<String, dynamic> json) => UserModel(
        userId: json['userId'],
        name: json['name'],
        email: json['email'],
        bag: json['bag'] ?? [],
      );

  Map<String, dynamic> toJson(UserModel user) => {
        "userId": user.userId,
        "name": user.name,
        "email": user.email,
        "bag": user.bag,
      };
}
