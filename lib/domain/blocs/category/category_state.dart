import 'package:equatable/equatable.dart';

import '../../../data/models/category.dart';

class CategoryState extends Equatable {
  final List<Category> categories;
  const CategoryState({required this.categories});

  @override
  List<Object?> get props => [categories];
}

class CategoryLoading extends CategoryState {
  CategoryLoading() : super(categories: []);
}

class CategoryLoaded extends CategoryState {
  final List<Category> categories;
  int? code;
  CategoryLoaded({required this.categories, this.code})
      : super(categories: categories);

  @override
  List<Object?> get props => [categories, code];
}
