import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:e_commerce/data/Cart/add_product.dart';
import 'package:e_commerce/data/Cart/cart_hive.dart';
import 'package:e_commerce/data/Favorite/favorite.dart';
import 'package:e_commerce/data/Favorite/favorite_hive.dart';
import 'package:e_commerce/ui/Screens/Cart/cart.dart';
import 'package:e_commerce/ui/Screens/Product/Widgets/color.dart';
import 'package:flutter_image_slideshow/flutter_image_slideshow.dart';
import 'package:sizer/sizer.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProductScreen extends StatefulWidget {
  final List<String> images;
  final List reviews;
  final String description;
  final String title;
  final double price;
  final double rate;

  const ProductScreen(
      {super.key,
      required this.images,
      required this.description,
      required this.title,
      required this.reviews,
      required this.price,
      required this.rate});

  @override
  State<ProductScreen> createState() => _ProductScreenState();
}

class _ProductScreenState extends State<ProductScreen> {
  int _counter = 1;
  int _currentImageIndex = 0;
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

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  void _decrementCounter() {
    setState(() {
      if (_counter != 1) {
        _counter--;
      }
    });
  }

  Future<void> _toggleFavorite() async {
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
  }

  String timeAgo(String isoDate) {
    final date = DateTime.parse(isoDate);
    final now = DateTime.now();
    final difference = now.difference(date);

    if (difference.inDays > 365) {
      final years = (difference.inDays / 365).floor();
      return '$years year${years > 1 ? 's' : ''} ago';
    } else if (difference.inDays > 30) {
      final months = (difference.inDays / 30).floor();
      return '$months month${months > 1 ? 's' : ''} ago';
    } else if (difference.inDays > 0) {
      return '${difference.inDays} day${difference.inDays > 1 ? 's' : ''} ago';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hour${difference.inHours > 1 ? 's' : ''} ago';
    } else if (difference.inMinutes > 0) {
      return '${difference.inMinutes} minute${difference.inMinutes > 1 ? 's' : ''} ago';
    } else if (difference.inSeconds > 30) {
      return '${difference.inSeconds} second${difference.inSeconds > 1 ? 's' : ''} ago';
    } else {
      return 'Just now';
    }
  }

  @override
  Widget build(BuildContext context) {
    return AnnotatedRegion<SystemUiOverlayStyle>(
      value: SystemUiOverlayStyle(
        statusBarIconBrightness: Brightness.dark,
      ),
      child: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
          child: SizedBox(
            height: double.infinity,
            child: Stack(
              children: [
                SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.max,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Center(
                            child: ImageSlideshow(
                                indicatorPadding: 10,
                                height: 50.h,
                                autoPlayInterval: 6000,
                                isLoop: true,
                                indicatorColor: Color(0xFF3347C4),
                                children: [
                                  for (String image in widget.images)
                                    Image.network(
                                      image,
                                      loadingBuilder: (BuildContext context,
                                          Widget child,
                                          ImageChunkEvent? loadingProgress) {
                                        if (loadingProgress == null) {
                                          return child;
                                        } else {
                                          return Center(
                                            child: CircularProgressIndicator(
                                                backgroundColor: Colors.grey,
                                                value: loadingProgress
                                                            .expectedTotalBytes !=
                                                        null
                                                    ? loadingProgress
                                                            .cumulativeBytesLoaded /
                                                        loadingProgress
                                                            .expectedTotalBytes!
                                                    : null),
                                          );
                                        }
                                      },
                                    ),
                                ]),
                          ),
                          Container(
                            width: double.infinity,
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(20),
                            ),
                            padding: EdgeInsets.only(
                              left: 20,
                              top: 20,
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          width: 70.w,
                                          child: Text(
                                            widget.title,
                                            style: TextStyle(
                                                fontWeight: FontWeight.w800,
                                                fontSize: 18.sp),
                                          ),
                                        ),
                                        Text(
                                          '\$${widget.price}',
                                          style: TextStyle(
                                              color: Color(0xFF3347C4),
                                              fontWeight: FontWeight.w700,
                                              fontSize: 24.sp),
                                        ),
                                      ],
                                    ),
                                    Container(
                                      padding: EdgeInsets.symmetric(
                                          vertical: 8, horizontal: 14),
                                      decoration: BoxDecoration(
                                        color: Color(0xFFFFF7B2),
                                        borderRadius: BorderRadius.only(
                                          topLeft: Radius.circular(10),
                                          bottomLeft: Radius.circular(10),
                                        ),
                                      ),
                                      child: Row(
                                        children: [
                                          Text(
                                            widget.rate.toStringAsFixed(1),
                                            style: TextStyle(fontSize: 17.sp),
                                          ),
                                          SizedBox(width: 3),
                                          Icon(
                                            Icons.star,
                                            color: Colors.yellow[800],
                                            size: 22.sp,
                                          ),
                                        ],
                                      ),
                                    )
                                  ],
                                ),
                                SizedBox(
                                  width: 90.w,
                                  child: Text(
                                    widget.description,
                                    style: TextStyle(fontSize: 15.sp),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Container(
                            padding: EdgeInsets.all(20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                Row(
                                  children: [
                                    CounterWidget(
                                      color: Colors.white,
                                      icon: Icons.remove,
                                      onTap: _decrementCounter,
                                    ),
                                    SizedBox(width: 15.sp),
                                    Text(
                                      _counter.toString(),
                                      style: TextStyle(
                                          fontSize: 16.sp,
                                          fontWeight: FontWeight.w600),
                                    ),
                                    SizedBox(width: 15.sp),
                                    CounterWidget(
                                      color: Colors.white,
                                      icon: Icons.add,
                                      onTap: _incrementCounter,
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                          Divider(indent: 50, endIndent: 50, thickness: 3),
                          ListView.builder(
                            physics: const NeverScrollableScrollPhysics(),
                            shrinkWrap: true,
                            itemCount: widget.reviews.length,
                            itemBuilder: (context, index) {
                              return Row(
                                children: [
                                  Image.asset(
                                      'assets/images/profile_comment.png',
                                      width: 20.w,
                                      height: 20.h),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    mainAxisAlignment:
                                        MainAxisAlignment.start,
                                    children: [
                                      Text(
                                        widget.reviews[index]['reviewerName']
                                            .toString(),
                                        style: TextStyle(
                                            fontWeight: FontWeight.bold),
                                      ),
                                      Text(
                                        timeAgo(widget.reviews[index]['date']
                                            .toString()),
                                        style: TextStyle(color: Colors.grey),
                                      ),
                                      Row(
                                        children: [
                                          Icon(Icons.star,
                                              color: int.parse(widget
                                                              .reviews[index]
                                                          ['rating']) >
                                                      0
                                                  ? Colors.yellow[800]
                                                  : Colors.grey),
                                          Icon(Icons.star,
                                              color: int.parse(widget
                                                              .reviews[index]
                                                          ['rating']) >
                                                      1
                                                  ? Colors.yellow[800]
                                                  : Colors.grey),
                                          Icon(Icons.star,
                                              color: int.parse(widget
                                                              .reviews[index]
                                                          ['rating']) >
                                                      2
                                                  ? Colors.yellow[800]
                                                  : Colors.grey),
                                          Icon(Icons.star,
                                              color: int.parse(widget
                                                              .reviews[index]
                                                          ['rating']) >
                                                      3
                                                  ? Colors.yellow[800]
                                                  : Colors.grey),
                                          Icon(Icons.star,
                                              color: int.parse(widget
                                                              .reviews[index]
                                                          ['rating']) >
                                                      4
                                                  ? Colors.yellow[800]
                                                  : Colors.grey),
                                        ],
                                      ),
                                      SizedBox(height: 20),
                                      Text(widget.reviews[index]['comment']
                                          .toString()),
                                    ],
                                  ),
                                ],
                              );
                            },
                          ),
                          SizedBox(height: 170),
                        ],
                      ),
                    ],
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 0,
                  right: 0,
                  child: Container(
                    width: double.infinity,
                    padding: EdgeInsets.symmetric(vertical: 30),
                    color: Colors.white,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                          style: ButtonStyle(
                            shape: WidgetStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(20))),
                            iconSize: WidgetStatePropertyAll(22.sp),
                            padding: WidgetStatePropertyAll(
                                EdgeInsets.symmetric(
                                    horizontal: 8.w, vertical: 1.8.h)),
                            backgroundColor:
                                WidgetStatePropertyAll(Color(0xFFD2D9FF)),
                          ),
                          icon: Icon(Icons.shopping_cart),
                          color: Color(0xFF3347C4),
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => CartScreen()),
                            );
                          },
                        ),
                        ElevatedButton(
                          onPressed: () {
                            cardInstant.addProduct(Product(
                                image: widget.images[0],
                                price: widget.price,
                                title: widget.title,
                                description: widget.description,
                                quantity: _counter,
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
                          style: ButtonStyle(
                            padding: WidgetStatePropertyAll(
                                EdgeInsets.symmetric(
                                    horizontal: 16.w, vertical: 1.5.h)),
                            shape: WidgetStatePropertyAll(
                                RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(12))),
                            backgroundColor:
                                WidgetStatePropertyAll(Color(0xFF3347C4)),
                          ),
                          child: Text(
                            'Add to Cart',
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 20.sp,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 0,
                  right: 0,
                  child: Padding(
                    padding: const EdgeInsets.all(20),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        IconButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          icon:
                              Icon(Icons.arrow_back_ios_new_sharp, size: 20.sp),
                          style: ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(Colors.white),
                            shadowColor: WidgetStatePropertyAll(Colors.black),
                            elevation: WidgetStatePropertyAll(7),
                          ),
                        ),
                        IconButton(
                          onPressed: _toggleFavorite,
                          icon: Icon(
                            _isFavorite
                                ? Icons.favorite
                                : Icons.favorite_border,
                            size: 20.sp,
                          ),
                          style: ButtonStyle(
                            backgroundColor:
                                WidgetStatePropertyAll(Colors.white),
                            shadowColor: WidgetStatePropertyAll(Colors.black),
                            elevation: WidgetStatePropertyAll(7),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
