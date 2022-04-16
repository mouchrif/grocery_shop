import 'package:flutter/material.dart';

class Category {
  final String name;
  final String imagePath;
  final Color color;

  Category({required this.name, required this.imagePath, required this.color});

  factory Category.fromJson(Map<String, dynamic> json) => Category(
    name : json['name'],
    color : Color(int.parse(json['color'])),
    imagePath : json['imagePath'],
  );
}
