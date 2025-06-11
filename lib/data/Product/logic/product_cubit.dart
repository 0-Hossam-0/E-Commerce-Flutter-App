import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce/data/Product/repository/api.dart';

abstract class ProductState {}

class ProductInitial extends ProductState {}

class ProductLoading extends ProductState {}

class ProductLoaded extends ProductState {
}

class ProductError extends ProductState {}

class ProductCubit extends Cubit<ProductState> {
  final ProductServices apiService;
  ProductCubit(this.apiService) : super(ProductInitial());

  void fetchProduct(String username, String password) async {
    emit(ProductLoading());
    try {
      await apiService.fetchProduct();
      emit(ProductLoaded());
    } catch (e) {
      emit(ProductError());
    }
  }
}
