import 'package:e_commerce/ui/Screens/Home/Widgets/text_animation.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:e_commerce/data/Cart/add_product.dart';
import 'package:e_commerce/data/Cart/cart_hive.dart';
import 'package:e_commerce/data/Favorite/favorite.dart';
import 'package:e_commerce/data/Favorite/favorite_hive.dart';
import 'package:e_commerce/ui/Screens/Product/product.dart';
import 'package:sizer/sizer.dart';

class ProductWidget extends StatefulWidget {
  final List<String> images;
  final double rate;
  final String title;
  final String description;
  final int stock;
  final double price;
  final List reviews;
  const ProductWidget(
      {super.key,
      required this.images,
      required this.rate,
      required this.title,
      required this.description,
      required this.price,
      required this.reviews,
      required this.stock});

  @override
  State<ProductWidget> createState() => _ProductWidgetState();
}

class _ProductWidgetState extends State<ProductWidget> {
  bool _isFavorite = false;
  final cardInstant = CartBasket();
  final favoriteInstant = FavoriteBasket();
  @override
  void initState() {
    super.initState();
    _checkFavoriteStatus();
  }

  Future<void> _checkFavoriteStatus() async {
    final exists = await favoriteInstant.isExist(widget.title);
    setState(() {
      _isFavorite = exists;
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ProductScreen(
                      rate: widget.rate,
                      images: widget.images,
                      title: widget.title,
                      description: widget.description,
                      price: widget.price,
                      reviews: widget.reviews,
                    )));
      },
      child: Container(
        padding: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
            border: Border.all(width: 0.3),
            color: Color.fromARGB(255, 246, 245, 245),
            borderRadius: BorderRadius.circular(10)),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Expanded(
              child: Stack(
                children: [
                  Center(
                    child: Image.network(
                      widget.images[0],
                      loadingBuilder: (BuildContext context, Widget child,
                          ImageChunkEvent? loadingProgress) {
                        if (loadingProgress == null) {
                          return child;
                        } else {
                          return CircularProgressIndicator(
                              backgroundColor: Colors.grey,
                              value: loadingProgress.expectedTotalBytes != null
                                  ? loadingProgress.cumulativeBytesLoaded /
                                      loadingProgress.expectedTotalBytes!
                                  : null);
                        }
                      },
                      errorBuilder: (BuildContext context, Object object,
                          StackTrace? stackTrace) {
                        return const Text('Error');
                      },
                    ),
                  ),
                  Positioned(
                      right: 0,
                      top: 0,
                      child: IconButton(
                          onPressed: () async {
                            setState(() {
                              _isFavorite = !_isFavorite;
                            });
                            if (_isFavorite) {
                              await favoriteInstant.addProduct(Favorite(
                                title: widget.title,
                                price: widget.price,
                                image: widget.images[0],
                                description: widget.description,
                              ));
                            } else {
                              await favoriteInstant.deleteByTitle(widget.title);
                            }
                          },
                          iconSize: 18.sp,
                          style: ButtonStyle(
                              minimumSize: WidgetStatePropertyAll(Size(10, 10)),
                              shape: WidgetStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8))),
                              backgroundColor:
                                  WidgetStatePropertyAll(Colors.grey[300]),
                              shadowColor: WidgetStatePropertyAll(Colors.black),
                              elevation: WidgetStatePropertyAll(5)),
                          icon: _isFavorite
                              ? Icon(Icons.favorite)
                              : Icon(Icons.favorite_border))),
                  Positioned(
                      right: 0,
                      bottom: 0,
                      child: IconButton(
                          onPressed: () {
                            cardInstant.addProduct(Product(
                                image: widget.images[0],
                                price: widget.price,
                                title: widget.title,
                                description: widget.description,
                                quantity: 1,
                                selected: false));
                            Fluttertoast.showToast(
                              msg: "Product added to cart",
                              toastLength: Toast.LENGTH_SHORT,
                              gravity: ToastGravity.BOTTOM,
                              timeInSecForIosWeb: 1,
                              backgroundColor: Colors.black,
                              textColor: Colors.white,
                              fontSize: 16.0,
                            );
                          },
                          iconSize: 18.sp,
                          style: ButtonStyle(
                              minimumSize: WidgetStatePropertyAll(Size(10, 10)),
                              shape: WidgetStatePropertyAll(
                                  RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(8))),
                              backgroundColor:
                                  WidgetStatePropertyAll(Colors.grey[300]),
                              shadowColor: WidgetStatePropertyAll(Colors.black),
                              elevation: WidgetStatePropertyAll(5)),
                          icon: Icon(Icons.add_shopping_cart_sharp))),
                  Positioned(
                      left: 6,
                      bottom: 0,
                      child: Container(
                        padding: EdgeInsets.all(3),
                        decoration: BoxDecoration(
                            color: Colors.grey[300],
                            borderRadius: BorderRadius.circular(10)),
                        child: Row(
                          children: [
                            Text(
                              widget.rate.toString(),
                              style: TextStyle(fontSize: 14.sp),
                            ),
                            SizedBox(width: 2),
                            Icon(
                              Icons.star_outlined,
                              size: 16.sp,
                              color: Color(0xFFf3ac30),
                            ),
                            SizedBox(width: 3),
                            Text(
                              widget.reviews.length.toString(),
                              style: TextStyle(
                                  fontSize: 14.sp, color: Colors.grey[600]),
                            )
                          ],
                        ),
                      )),
                ],
              ),
            ),
            SizedBox(height: 10),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    widget.title,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style:
                        TextStyle(fontSize: 14.sp, fontWeight: FontWeight.w600),
                  ),
                  Text(
                    '\$${widget.price}',
                    style: TextStyle(
                        color: Color(0xFF3347C4),
                        fontWeight: FontWeight.w700,
                        fontSize: 15.sp),
                  ),
                  SizedBox(height: 10),
                  AnimateText(
                      firstText: '${widget.stock} In Stock',
                      secondsText: 'Free Delivery'),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
