import 'package:hive/hive.dart';

part 'favorite_hive.g.dart';

@HiveType(typeId: 1)
class Favorite extends HiveObject {
  @HiveField(0)
  String title;

  @HiveField(1)
  double price;

  @HiveField(2)
  String image;
  @HiveField(3)
  String description;

  Favorite({
    required this.title,
    required this.price,
    required this.image,
    required this.description,
  });
}
