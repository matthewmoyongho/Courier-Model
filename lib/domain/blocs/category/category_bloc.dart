import 'package:bloc/bloc.dart';
import 'package:courier_app/data/models/category.dart';

import '../../../data/repository/catgory_repository.dart';
import 'category_event.dart';
import 'category_state.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  late CategoryRepository _repository;
  CategoryBloc() : super(CategoryLoading()) {
    on<LoadCategories>(_loadCategories);
  }

  void _loadCategories(
      LoadCategories event, Emitter<CategoryState> emit) async {
    _repository = CategoryRepository();
    emit(CategoryLoading());
    List<Category> categories = [];

    categories.addAll(await _repository.fetchCategories() ?? []);

    emit(CategoryLoaded(categories: categories));
    print('New state is loaded');
  }
}
