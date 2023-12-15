import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'meal.g.dart';

@HiveType(typeId: 1)
class Meal extends Equatable {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String category;
  @HiveField(2)
  final String area;
  @HiveField(3)
  final String thumbnail;
  @HiveField(4)
  final String instructions;

  Meal({
    required this.category,
    required this.area,
    required this.instructions,
    required this.name,
    required this.thumbnail,
  });
  @override
  // TODO: implement props
  List<Object?> get props => [name, thumbnail, instructions, area, category];

  static Meal fromSnapshot(Map map) {
    return Meal(
      category: map['strCategory'] ?? '',
      area: map['strArea'] ?? '',
      name: map['strMeal'] ?? '',
      thumbnail: map['strMealThumb'] ?? '',
      instructions: map['strInstructions'] ?? '',
    );
  }

  factory Meal.fromMap(Map map) {
    return Meal(
      category: map['strCategory'] ?? '',
      area: map['strArea'] ?? '',
      name: map['strMeal'] ?? '',
      thumbnail: map['strMealThumb'] ?? '',
      instructions: map['strInstructions'] ?? '',
    );
  }
}
