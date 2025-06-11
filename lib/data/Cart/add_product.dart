import 'package:hive/hive.dart';
import 'package:e_commerce/data/Cart/cart_hive.dart';

class CartBasket {
  final _boxName = "cartItems";


  Future<Box<Product>> get _box async => await Hive.openBox<Product>(_boxName);


  Future<void> addProduct(Product product) async {
    var box = await _box;
    Product? existingProduct = box.values.toList().firstWhere(
          (p) => p.title == product.title,
      orElse: () => Product(title: '', quantity: 0, price: -1, image: '', selected: false, description: ''),
    );

    if (existingProduct.price != -1) {
      existingProduct.quantity += product.quantity;
      await existingProduct.save();
    } else {
      await box.add(product);
    }
  }
  Future<List<Product>> getAll() async {
    var box = await _box;
    return box.values.toList();

  }

  Future<void> deleteAll() async {
    var box = await _box;
    box.clear();
  }

  Future<void> deleteAt(int index) async {
    var box = await _box;
    box.deleteAt(index);
  }

}
