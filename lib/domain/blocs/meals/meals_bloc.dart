import 'package:bloc/bloc.dart';
import 'package:courier_app/data/models/meal.dart';
import 'package:courier_app/data/repository/meals_repository.dart';

import 'meals_event.dart';
import 'meals_state.dart';

class MealsBloc extends Bloc<MealsEvent, MealsState> {
  late MealsRepository _repository;
  MealsBloc() : super(MealsLoading()) {
    on<LoadMeals>(_loadMeals);
    on<LoadMeal>(_loadMeal);
  }
  void _loadMeals(LoadMeals event, Emitter<MealsState> emit) async {
    _repository = MealsRepository();
    emit(MealsLoading());
    List<Meal> categories = [];

    categories.addAll(await _repository.fetchMeals(event.category) ?? []);

    emit(MealsLoaded(meals: categories));
  }

  void _loadMeal(LoadMeal event, Emitter<MealsState> emit) async {
    _repository = MealsRepository();
    emit(MealsLoading());
    Meal? meal;
    meal = await _repository.fetchMeal(event.id);

    emit(MealsLoaded(meals: state.meals, meal: meal));
  }
}
