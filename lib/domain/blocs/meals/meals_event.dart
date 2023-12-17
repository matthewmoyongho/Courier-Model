abstract class MealsEvent {}

class LoadMeals extends MealsEvent {
  final String meals;
  LoadMeals(this.meals);
}

class LoadMeal extends MealsEvent {
  final String id;
  LoadMeal(this.id);
}

class LoadMealFromBox extends MealsEvent {
  final String id;
  LoadMealFromBox(this.id);
}
