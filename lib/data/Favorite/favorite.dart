import 'package:hive/hive.dart';
import 'package:e_commerce/data/Favorite/favorite_hive.dart';

class FavoriteBasket {
  final _boxName = "favoriteItems";

  Future<Box<Favorite>> get _box async =>
      await Hive.openBox<Favorite>(_boxName);
  Future<void> addProduct(Favorite product) async {
    var box = await _box;

    Favorite? existingProduct = box.values.toList().firstWhere(
          (p) => p.title == product.title,
          orElse: () =>
              Favorite(title: '', price: -1, image: '', description: ''),
        );

    if (existingProduct.title.isNotEmpty) {
      await existingProduct.save();
    } else {
      await box.add(product);
    }
  }

  Future<List<Favorite>> getAll() async {
    var box = await _box;
    return box.values.toList();
  }

 Future<bool> isExist(String title) async {
    final box = await _box;
    return box.values.any((product) => product.title == title);
  }

  Future<void> deleteAll() async {
    var box = await _box;
    box.clear();
  }

  Future<void> deleteByTitle(String title) async {
    var box = await _box;
    final products = box.values.toList();
    final index = products.indexWhere((product) => product.title == title);

    if (index != -1) {
      await box.deleteAt(index);
    }
  }
}
