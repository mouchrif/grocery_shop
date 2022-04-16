import 'package:flutter/material.dart';

class BagModel {
  final String id;
  final String productImage;
  final double productPrice;
  final String productName;
  final int quantity;
  final String color;
  final bool isFavorite;

  BagModel({
    required this.id,
    required this.productImage,
    required this.productPrice,
    required this.productName,
    required this.quantity,
    required this.color,
    required this.isFavorite,
  });

  factory BagModel.fromJson(Map<String, dynamic> map) => BagModel(
        id: map['id'],
        productImage: map['productImage'],
        productPrice: map['productPrice'],
        productName: map['productName'],
        quantity: map['quantity'],
        color: map['color'] ?? "Colors.grey.shade100",
        isFavorite: map['isFavorite'],
      );

  Map<String, dynamic> toJson(BagModel bag) => {
        "id": bag.id,
        "productImage": bag.productImage,
        "productPrice": bag.productPrice,
        "productName": bag.productName,
        "quantity": bag.quantity,
        "color": bag.color,
        "isFavorite": bag.isFavorite, 
      };
}
