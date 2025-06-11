import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce/data/Categories/logic/categories_cubit.dart';
import 'package:e_commerce/data/Categories/repository/api.dart';
import 'package:e_commerce/data/Search/logic/search_cubit.dart';
import 'package:e_commerce/data/Search/repository/api.dart';
import 'package:e_commerce/ui/Public_Widgets/app_bar.dart';
import 'package:e_commerce/ui/Screens/Home/Widgets/product.dart';
import 'package:e_commerce/ui/Screens/Search/search.dart';

class CategoryScreen extends StatelessWidget {
  final String category;
  CategoryScreen({super.key, required this.category});
  final _emptyController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          CategoriesCubit(CategoriesServices())..fetchCategories(category),
      child: Scaffold(
        backgroundColor: Color(0xFFE6E6E6),
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
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: BlocBuilder<CategoriesCubit, CategoriesState>(
            builder: (context, state) {
              if (state is CategoriesLoaded) {
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.7,
                    crossAxisCount: MediaQuery.sizeOf(context).width ~/ 180,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: state.categories.length,
                  itemBuilder: (context, index) {
                    return ProductWidget(
                        images: state.categories[index].images,
                        rate: state.categories[index].rate,
                        title: state.categories[index].title,
                        description: state.categories[index].description,
                        price: state.categories[index].price,
                        reviews: state.categories[index].reviews,
                        stock: state.categories[index].stock);
                  },
                );
              }
              return Center(child: CircularProgressIndicator());
            },
          ),
        ),
      ),
    );
  }
}
