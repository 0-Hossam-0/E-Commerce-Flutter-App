import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce/data/Search/logic/search_cubit.dart';
import 'package:e_commerce/data/Search/repository/api.dart';
import 'package:e_commerce/ui/Public_Widgets/app_bar.dart';
import 'package:e_commerce/ui/Screens/Home/Widgets/product.dart';

class SearchScreen extends StatefulWidget {
  const SearchScreen({super.key});

  @override
  State<SearchScreen> createState() => _SearchScreenState();
}

class _SearchScreenState extends State<SearchScreen> {
  final _searchController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) =>
          SearchCubit(SearchServices())..fetchSearch(_searchController.text),
      child: Scaffold(
        floatingActionButtonLocation: FloatingActionButtonLocation.startFloat,
        backgroundColor: Color(0xFFE6E6E6),
        appBar: AppBarWidget(
            isDisabled: false, controller: _searchController, isOnChange: true),
        body: Padding(
          padding: const EdgeInsets.all(10),
          child: BlocBuilder<SearchCubit, SearchState>(
            builder: (context, state) {
              if (state is SearchLoaded) {
                return GridView.builder(
                  gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                    childAspectRatio: 0.5,
                    crossAxisCount: MediaQuery.sizeOf(context).width ~/ 180,
                    crossAxisSpacing: 10,
                    mainAxisSpacing: 10,
                  ),
                  itemCount: state.products.length,
                  itemBuilder: (context, index) {
                    return ProductWidget(
                        images: state.products[index].images,
                        rate: state.products[index].rate,
                        title: state.products[index].title,
                        description: state.products[index].description,
                        price: state.products[index].price,
                        reviews: state.products[index].reviews,
                        stock: state.products[index].stock);
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
