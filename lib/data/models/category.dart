import 'package:equatable/equatable.dart';
import 'package:hive/hive.dart';

part 'category.g.dart';

@HiveType(typeId: 0)
class Category extends Equatable {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String thumbnail;
  @HiveField(2)
  final String description;

  Category(
      {required this.name, required this.thumbnail, required this.description});
  @override
  // TODO: implement props
  List<Object?> get props => [name, thumbnail, description];

  static Category fromSnapshot(Map map) {
    return Category(
      name: map['strCategory'] ?? '',
      thumbnail: map['strCategoryThumb'],
      description: map['strCategoryDescription'] ?? '',
    );
  }

  factory Category.fromMap(Map map) {
    return Category(
      name: map['strCategory'] ?? '',
      thumbnail: map['strCategoryThumb'],
      description: map['strCategoryDescription'] ?? '',
    );
  }
}
