abstract class MealsEvent {}

class LoadMeals extends MealsEvent {
  final String category;
  LoadMeals(this.category);
}

class LoadMeal extends MealsEvent {
  final String id;
  LoadMeal(this.id);
}
