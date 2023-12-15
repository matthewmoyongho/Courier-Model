import 'package:equatable/equatable.dart';

import '../../../data/models/meal.dart';

class MealsState extends Equatable {
  final List<Meal> meals;
  const MealsState({required this.meals});

  @override
  List<Object?> get props => [meals];
}

class MealsLoading extends MealsState {
  MealsLoading() : super(meals: []);
}

class MealsLoaded extends MealsState {
  final List<Meal> meals;
  final Meal? meal;
  int? code;
  MealsLoaded({required this.meals, this.code, this.meal})
      : super(meals: meals);

  @override
  List<Object?> get props => [meals, code, meal];
}
