import 'package:hive/hive.dart';

part 'cart_hive.g.dart';

@HiveType(typeId: 0)
class Product extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  double price;

  @HiveField(2)
  String image;

  @HiveField(3)
  int quantity;

  @HiveField(4)
  bool selected;

  @HiveField(5)
  String description;

  Product({
    required this.title,
    required this.price,
    required this.image,
    required this.quantity,
    required this.selected,
    required this.description,
  });
}
