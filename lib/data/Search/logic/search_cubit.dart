import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:e_commerce/data/Search/models/search.dart';
import 'package:e_commerce/data/Search/repository/api.dart';

abstract class SearchState {}

class SearchInitial extends SearchState {}

class SearchLoading extends SearchState {}

class SearchLoaded extends SearchState {
  final List<Search> products;
  SearchLoaded(this.products);
}

class SearchError extends SearchState {}

class SearchCubit extends Cubit<SearchState> {
  final SearchServices apiService;
  SearchCubit(this.apiService) : super(SearchInitial());

  void fetchSearch(String search) async {
    emit(SearchLoading());
    try {
      final data = await apiService.fetchSearch(search);
      emit(SearchLoaded(data));
    } catch (e) {
      emit(SearchError());
    }
  }
}
