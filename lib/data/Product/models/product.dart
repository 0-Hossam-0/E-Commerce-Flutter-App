class Product {
  final String token;
  Product({required this.token});
  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      token: json['token'] as String,
    );
  }
}