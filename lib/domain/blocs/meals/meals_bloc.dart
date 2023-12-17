import 'package:bloc/bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
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
    List<Meal> meals = [];
    var connectivity = await Connectivity().checkConnectivity();
    if (connectivity == ConnectivityResult.wifi ||
        connectivity == ConnectivityResult.mobile) {
      meals.addAll(await _repository.fetchMeals(event.meals) ?? []);
    } else {
      meals = [];
    }

    emit(MealsLoaded(meals: meals));
  }

  void _loadMeal(LoadMeal event, Emitter<MealsState> emit) async {
    _repository = MealsRepository();
    emit(MealsLoading());
    Meal? meal;
    var connectivity = await Connectivity().checkConnectivity();
    if (connectivity == ConnectivityResult.wifi ||
        connectivity == ConnectivityResult.mobile) {
      meal = await _repository.fetchMealOnline(event.id);
    } else {
      await _repository.fetchMealFromBox(event.id);
    }
    emit(MealsLoaded(meals: state.meals, meal: meal));
  }
}
