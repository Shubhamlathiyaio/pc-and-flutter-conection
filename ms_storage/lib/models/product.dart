class Product {
  final int? id;
  final String name;
  final double price;
  final String category;

  Product({
    this.id,
    required this.name,
    required this.price,
    required this.category,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      id: json['id'] as int?,
      name: json['name'] as String,
      price: double.parse(json['price'].toString()),
      category: json['category'] as String,
    );
  }

  Map<String, dynamic> toJson() {
    return {'id': id, 'name': name, 'price': price, 'category': category};
  }
}
