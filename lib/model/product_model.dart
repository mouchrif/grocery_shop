class Product {
  final List<dynamic> category;
  late String name;
  final double price;
  final String imagePath;
  late bool isFavorite;
  //final double? rating;
  Product({
    required this.category,
    required this.name,
    required this.price,
    required this.imagePath,
    this.isFavorite = false,
    // this.rating,
  });

  factory Product.fromJson(Map<String, dynamic> json) => Product(
        category: json['category']??[],
        name: json['name']??"",
        price: json['price'] != null ? json['price'].toDouble() : 0.0,
        imagePath: json['imagePath']??"",
        isFavorite: json['isFavorite'] ?? false,
      );

  Map<String, dynamic> toJson(Product product) => {
    "name": product.name,
    "price": product.price,
    "isFavorite": product.isFavorite,
    "imagePath": product.imagePath,
    "category": product.category,
  };
}
