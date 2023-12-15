import 'package:courier_app/data/models/category.dart';
import 'package:courier_app/data/models/meal.dart';
import 'package:flutter/material.dart';
import 'package:hive_flutter/adapters.dart';

import './app.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Hive.initFlutter();
  Hive.registerAdapter(CategoryAdapter());
  Hive.registerAdapter(MealAdapter());
  await Hive.openBox<Category>('category');
  await Hive.openBox<Meal>('meal');
  runApp(App());
}
