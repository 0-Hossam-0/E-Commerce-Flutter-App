import 'dart:async';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce/data/Home/models/home.dart';
import 'package:e_commerce/data/Home/repository/api.dart';

abstract class HomeState {}

class HomeInitial extends HomeState {}

class HomeLoading extends HomeState {}

class HomeLoaded extends HomeState {
  final List<Home> products;
  final bool hasMore;

  HomeLoaded({required this.products, required this.hasMore});
}

class HomeError extends HomeState {}

class HomeCubit extends Cubit<HomeState> {
  final HomeServices apiService;
  int limit = 10;
  num skip = 0;
  bool hasMore = true;
  List<Home> _allProducts = [];
  HomeCubit(this.apiService) : super(HomeInitial());
  Future<void> fetchHome({bool isLoadMore = false}) async {
    try {
      if (!isLoadMore) {
        skip = 0;
        hasMore = true;
        _allProducts.clear();
        emit(HomeLoading());
      }
      if (!hasMore) return;
      final newProducts = await apiService.fetchHome(limit: limit, skip: skip);
      hasMore = newProducts.length >= limit;
      skip += limit;
      _allProducts.addAll(newProducts);
      emit(HomeLoaded(
        products: List.from(_allProducts),
        hasMore: hasMore,
      ));
    } catch (e) {
      print("Error :" + e.toString());
      emit(HomeError());
    }
  }
  Future<void> refreshProducts() async {
    print('refresh function');
    try{
      final newProducts = await apiService.fetchHome(limit: limit, skip: 0);
      _allProducts.addAll(newProducts);
      emit(HomeLoaded(
        products: List.from(_allProducts),
        hasMore: hasMore,
      ));
    }
    catch(e){
      print("refreshProducts:" + e.toString());
      emit(HomeError());
    }
  }
}
