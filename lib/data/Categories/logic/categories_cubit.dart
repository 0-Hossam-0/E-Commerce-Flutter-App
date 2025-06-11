import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce/data/Categories/models/categories.dart';
import 'package:e_commerce/data/Categories/repository/api.dart';

abstract class CategoriesState {}

class CategoriesInitial extends CategoriesState {}

class CategoriesLoading extends CategoriesState {}

class CategoriesLoaded extends CategoriesState {
  final List<Categories> categories;
  CategoriesLoaded(this.categories);
}

class CategoriesError extends CategoriesState {}

class CategoriesCubit extends Cubit<CategoriesState> {
  final CategoriesServices apiService;
  CategoriesCubit(this.apiService) : super(CategoriesInitial());

  void fetchCategories(String category) async {
    emit(CategoriesLoading());
    try {
      final data = await apiService.fetchCategories(category);
      emit(CategoriesLoaded(data));
    } catch (e) {
      emit(CategoriesError());
    }
  }

}
