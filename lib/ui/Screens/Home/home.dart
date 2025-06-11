import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce/data/Favorite/favorite.dart';
import 'package:e_commerce/data/Home/logic/products_cubit.dart';
import 'package:e_commerce/data/Home/repository/api.dart';
import 'package:e_commerce/data/Search/logic/search_cubit.dart';
import 'package:e_commerce/data/Search/repository/api.dart';
import 'package:e_commerce/ui/Public_Widgets/app_bar.dart';
import 'package:e_commerce/ui/Public_Widgets/navbar.dart';
import 'package:e_commerce/ui/Public_Widgets/product_skeleton.dart';
import 'package:e_commerce/ui/Screens/Cart/cart.dart';
import 'package:e_commerce/ui/Screens/Home/Widgets/category.dart';
import 'package:e_commerce/ui/Screens/Home/Widgets/product.dart';
import 'package:e_commerce/ui/Screens/Search/search.dart';
import 'package:visibility_detector/visibility_detector.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int productsCount = 10;
  final _scrollController = ScrollController();
  int loadingCounter = 1;
  final List<String> categories = const [
    'Beauty',
    'Fragrances',
    'Furniture',
    'Groceries',

  ];
  final List<String> imageAssets = const [
    'beauty.jpg',
    'fragrances.jpg',
    'furniture.jpg',
    'groceries.jpg',

  ];

  final favoriteInstant = FavoriteBasket();

  final _emptyController = TextEditingController();
  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeCubit(HomeServices())..fetchHome(),
      child: Scaffold(
        backgroundColor: const Color(0xFFE6E6E6),
        floatingActionButton: FloatingActionButton(
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => CartScreen()));
          },
          elevation: 12,
          shape:
              RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
          backgroundColor: const Color(0xFF3347C4),
          child: const Icon(Icons.shopping_cart, color: Colors.white, size: 25),
        ),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        bottomNavigationBar: NavBar(currentIndex: 0),
        appBar: AppBarWidget(
          isDisabled: true,
          controller: _emptyController,
          onTapFunction: () {
            Navigator.push(context, MaterialPageRoute(builder: (context) {
              return BlocProvider(
                create: (_) => SearchCubit(SearchServices()),
                child: SearchScreen(),
              );
            }));
          },
        ),
        body: RefreshIndicator(
          color: Color(0xFF3347C4),
          onRefresh: () async {
            productsCount = 10;
              context.read<HomeCubit>().refreshProducts();
          },
          child: NestedScrollView(
            controller: _scrollController,
            headerSliverBuilder: (context, innerBoxIsScrolled) => [
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: List.generate(imageAssets.length, (index) {
                          return Row(
                            children: [
                              const SizedBox(width: 15),
                              CategoryCard(
                                  imageAsset: imageAssets[index],
                                  category: categories[index]),
                              const SizedBox(width: 15),
                            ],
                          );
                        }),
                      ),
                    ),
                    const SizedBox(height: 40),
                  ],
                ),
              ),
            ],
            body: Padding(
              padding: const EdgeInsets.all(10),
              child: BlocBuilder<HomeCubit, HomeState>(
                builder: (context, state) {
                  if (state is HomeError) {
                    return SizedBox(
                      height: MediaQuery.sizeOf(context).height * 0.5,
                      child: Center(
                        child: Column(
                          children: [
                            Icon(Icons.wifi_off),
                            Text('Internet Issue'),
                            Text('You Lost The Internet Connection')
                          ],
                        ),
                      ),
                    );
                  } else if (state is HomeLoaded) {
                    return CustomScrollView(
                      slivers: [
                        SliverGrid(
                          gridDelegate:
                              SliverGridDelegateWithFixedCrossAxisCount(
                            childAspectRatio: 0.5,
                            crossAxisCount:
                                MediaQuery.of(context).size.width ~/ 180,
                            crossAxisSpacing: 10,
                            mainAxisSpacing: 10,
                          ),
                          delegate: SliverChildBuilderDelegate(
                              childCount: state.products.length +
                                  (state.hasMore ? 1 : 0), (context, index) {
                            if (index < state.products.length) {
                              final product = state.products[index];
                              return ProductWidget(
                                key: ValueKey(product.id),
                                price: product.price,
                                images: product.images,
                                title: product.title,
                                description: product.description,
                                rate: product.rate,
                                reviews: product.reviews,
                                stock: product.stock,
                              );
                            }
                          }),
                        ),
                        SliverToBoxAdapter(
                          child: SizedBox(
                              height: 100,
                              child: Center(
                                  child: VisibilityDetector(
                                key: ValueKey(loadingCounter),
                                onVisibilityChanged: (info) {
                                  if (info.visibleFraction > 0) {
                                    loadingCounter += 1;
                                    context
                                        .read<HomeCubit>()
                                        .fetchHome(isLoadMore: true);
                                  }
                                },
                                child: CircularProgressIndicator(
                                    color: Color(0xFF3347C4)),
                              ))),
                        ),
                      ],
                    );
                  }
                  return ProductSkeleton();
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
