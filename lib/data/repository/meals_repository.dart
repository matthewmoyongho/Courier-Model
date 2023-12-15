import 'dart:convert' as convert;

import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

import '../models/meal.dart';

class MealsRepository {
  // 'https://www.themealdb.com/api/json/v1/1/categories.php';
  final _mealsBox = Hive.box<Meal>('meal');

  MealsRepository();

  Future<List<Meal>?> fetchMeals(String category) async {
    List<Meal> meals = [];
    try {
      final response = await http.get(Uri.parse(
          'https://www.themealdb.com/api/json/v1/1/filter.php?c=$category'));
      if (response.statusCode == 200) {
        final jsonResponse = convert.jsonDecode(response.body);
        final List<Meal> toAdd = [];
        for (var element in jsonResponse['meals']) {
          toAdd.add(
            Meal(
                category: element['strCategory'] ?? '',
                area: element['idMeal'],
                name: element['strMeal'],
                thumbnail: element['strMealThumb'],
                instructions: element['strInstructions'] ?? ''),
          );
        }
        await _mealsBox.addAll(toAdd);
        meals.addAll(toAdd);
        return meals;
      } else {
        meals = [];
        throw Exception('Error fetching meal: ${response.statusCode}');
      }
    } on Exception catch (error) {
      meals = Hive.box('your_box_name').get('meals');
      return meals;
    }
  }

  Future<Meal?> fetchMeal(String id) async {
    Meal? meal;
    try {
      final response = await http.get(Uri.parse(
          'https://www.themealdb.com/api/json/v1/1/lookup.php?i=$id'));
      if (response.statusCode == 200) {
        final jsonResponse = convert.jsonDecode(response.body);
        meal = Meal(
            category: jsonResponse['meals'][0]['strCategory'],
            area: jsonResponse['meals'][0]['idMeal'],
            name: jsonResponse['meals'][0]['strMeal'],
            thumbnail: jsonResponse['meals'][0]['strMealThumb'],
            instructions: jsonResponse['meals'][0]['strInstructions']);
        _mealsBox.put(meal.area, meal);

        return meal;
      } else {
        meal = _mealsBox.get(id)!;
        throw Exception('Error fetching meal: ${response.statusCode}');
      }
    } on Exception catch (error) {
      return null;
    }
  }
}
