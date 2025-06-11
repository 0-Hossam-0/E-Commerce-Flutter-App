import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce/data/Categories/logic/categories_cubit.dart';
import 'package:e_commerce/data/Categories/repository/api.dart';
import 'package:e_commerce/data/Product/logic/product_cubit.dart';
import 'package:e_commerce/data/Product/repository/api.dart';
import 'package:e_commerce/ui/Screens/Categories/categories.dart';
import 'package:sizer/sizer.dart';

class CategoryCard extends StatefulWidget {
  final String imageAsset;
  final String category;
  const CategoryCard({
    super.key,
    required this.imageAsset,
    required this.category,
  });

  @override
  State<CategoryCard> createState() => _CategoryCardState();
}

class _CategoryCardState extends State<CategoryCard> {
  @override
  Widget build(BuildContext context) {
    void navigateCategory() {
      Navigator.push(context, MaterialPageRoute(builder: (context) {
        return MultiBlocProvider(
          providers: [
            BlocProvider<CategoriesCubit>(
              create: (_) => CategoriesCubit(CategoriesServices()),
            ),
            BlocProvider<ProductCubit>(
                create: (_) => ProductCubit(ProductServices())),
          ],
          child: CategoryScreen(category: widget.imageAsset),
        );
      }));
    }

    return GestureDetector(
      onTap: navigateCategory,
      child: Container(
        width: 60.w,
        height: 20.h,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
            image: AssetImage('assets/images/${widget.imageAsset}'),
            fit: BoxFit.cover,
          ),
        ),
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15),
            gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Colors.black.withOpacity(0.5),
                Colors.transparent,
              ],
            ),
          ),
          padding: EdgeInsets.all(12),
          alignment: Alignment.topLeft,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.category,
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 17.sp,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
