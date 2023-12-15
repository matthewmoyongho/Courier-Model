import 'dart:convert' as convert;

import 'package:courier_app/data/models/category.dart';
import 'package:hive/hive.dart';
import 'package:http/http.dart' as http;

class CategoryRepository {
  final String Url = 'https://www.themealdb.com/api/json/v1/1/categories.php';
  final _categoryBox = Hive.box<Category>('category');

  Future<List<Category>?> fetchCategories() async {
    List<Category> categories = [];
    try {
      final response = await http.get(Uri.parse(Url));
      if (response.statusCode == 200) {
        final jsonResponse = convert.jsonDecode(response.body);
        List<Category> toBox = [];
        for (var element in jsonResponse['categories']) {
          toBox.add(
            Category(
                name: element['strCategory'],
                thumbnail: element['strCategoryThumb'],
                description: element['strCategoryDescription']),
          );
        }

        await _categoryBox.addAll(toBox);
        categories.addAll(toBox);

        return categories;
      } else {
        throw Exception('Error fetching meal: ${response.statusCode}');
      }
    } on Exception catch (error) {
      categories = Hive.box('category').get('categories');
      return categories;
    }
  }
}
