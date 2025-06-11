import 'package:collection/collection.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive/hive.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:e_commerce/data/Cart/add_product.dart';
import 'package:e_commerce/data/Cart/cart_hive.dart';
import 'package:e_commerce/data/Favorite/favorite.dart';
import 'package:e_commerce/data/Favorite/favorite_hive.dart';
import 'package:e_commerce/ui/Public_Widgets/navBar.dart';
import 'package:e_commerce/ui/Screens/Cart/cart.dart';
import 'package:e_commerce/ui/Screens/Home/home.dart';
import 'package:sizer/sizer.dart';

class FavoriteScreen extends StatefulWidget {
  const FavoriteScreen({super.key});

  @override
  State<FavoriteScreen> createState() => _WishListScreenState();
}

class _WishListScreenState extends State<FavoriteScreen> {
  late Box<Favorite> favoriteBox;

  final favoriteInstant = FavoriteBasket();
  final cartInstant = CartBasket();

  @override
  void initState() {
    super.initState();
    favoriteBox = Hive.box<Favorite>('favoriteItems');

    groupBy(favoriteBox.values, (Favorite item) => item.title);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF4F4F4),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
              context, MaterialPageRoute(builder: (context) => CartScreen()));
        },
        elevation: 12,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
        backgroundColor: const Color(0xFF3347C4),
        child: const Icon(Icons.shopping_cart, color: Colors.white, size: 25),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      bottomNavigationBar: NavBar(currentIndex: 1),
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        title: Text(
          "Favorite List",
          style: TextStyle(color: Colors.black, fontSize: 18.sp),
        ),
        leading: IconButton(
          icon:
              Icon(Icons.arrow_back_ios_new, color: Colors.black, size: 18.sp),
          onPressed: () {
            Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => HomeScreen()),
              (Route<dynamic> route) => false,
            );
          },
        ),
      ),
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 4.w, vertical: 1.5.h),
            child: Container(
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(12),
              ),
            ),
          ),
          Expanded(
            child: ValueListenableBuilder(
              valueListenable: favoriteBox.listenable(),
              builder: (BuildContext context, Box<Favorite> products,
                  Widget? child) {
                return ListView.builder(
                  padding: EdgeInsets.symmetric(horizontal: 4.w),
                  itemCount: products.length,
                  itemBuilder: (context, index) {
                    Favorite product = products.getAt(index)!;
                    return Container(
                      margin: EdgeInsets.only(bottom: 1.5.h),
                      padding: EdgeInsets.all(2.h),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Row(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Container(
                            width: 15.w,
                            height: 8.h,
                            margin: EdgeInsets.only(right: 4.w),
                            decoration: BoxDecoration(
                              color: const Color(0xFFF4F4F4),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: product.image.isNotEmpty
                                ? Image.network(product.image,
                                    fit: BoxFit.contain)
                                : const SizedBox(),
                          ),
                          Expanded(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  product.title,
                                  style: TextStyle(
                                    fontSize: 16.sp,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                                SizedBox(height: 0.5.h),
                                Text(
                                  '\$${product.price.toStringAsFixed(0)}',
                                  style: TextStyle(
                                    color: const Color(0xFF3347C4),
                                    fontWeight: FontWeight.w700,
                                    fontSize: 17.sp,
                                  ),
                                ),
                                SizedBox(height: 1.h),
                                ElevatedButton(
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: const Color(0xFFFF7A00),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                    padding: EdgeInsets.symmetric(
                                      horizontal: 6.w,
                                      vertical: 1.2.h,
                                    ),
                                  ),
                                  onPressed: () {
                                    Fluttertoast.showToast(
                                      msg: "Product added to cart",
                                      toastLength: Toast.LENGTH_SHORT,
                                      gravity: ToastGravity.BOTTOM,
                                      timeInSecForIosWeb: 1,
                                      backgroundColor: Colors.black,
                                      textColor: Colors.white,
                                      fontSize: 16.0,
                                    );
                                    cartInstant.addProduct(Product(
                                        title: product.title,
                                        price: product.price,
                                        image: product.image,
                                        quantity: 1,
                                        selected: false,
                                        description: product.description));
                                  },
                                  child: Text(
                                    'Add to Cart',
                                    style: TextStyle(
                                      fontSize: 15.sp,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          SizedBox(width: 3.w),
                          IconButton(
                            icon: Icon(Icons.delete,
                                color: Colors.red, size: 22.sp),
                            onPressed: () => _showDeleteDialog(product.title),
                          ),
                        ],
                      ),
                    );
                  },
                );
              },
            ),
          ),
        ],
      ),
    );
  }

  void _showDeleteDialog(String title) {
    showDialog(
      context: context,
      builder: (BuildContext ctx) {
        return AlertDialog(
          title: Text(
            "Delete Item?",
            style: TextStyle(fontSize: 16.sp),
          ),
          content: Text(
            "Are you sure you want to remove ${title} from the favorite list?",
            style: TextStyle(fontSize: 15.sp),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(ctx).pop(),
              child: Text("Cancel", style: TextStyle(fontSize: 15.sp)),
            ),
            TextButton(
              onPressed: () {
                setState(() {
                  favoriteInstant.deleteByTitle(title);
                });
                Navigator.of(ctx).pop();
              },
              child: Text("Delete", style: TextStyle(fontSize: 15.sp)),
            ),
          ],
        );
      },
    );
  }
}

class WishListItem {
  final String title;
  final double price;
  final String image;

  WishListItem({
    required this.title,
    required this.price,
    required this.image,
  });
}
