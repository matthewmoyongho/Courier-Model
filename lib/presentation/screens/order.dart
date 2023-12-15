import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';

import '../../data/models/category.dart';
import '../../domain/blocs/category/category_bloc.dart';
import '../../domain/blocs/category/category_state.dart';
import 'meals_screen.dart';

class Order extends StatelessWidget {
  const Order({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.restaurant_menu),
            SizedBox(
              width: 3,
            ),
            Text(
              'Categories',
              style: GoogleFonts.nunito(),
            ),
          ],
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: BlocBuilder<CategoryBloc, CategoryState>(
        builder: (context, state) {
          if (state is CategoryLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is CategoryLoaded) {
            List categories = [];

            if (state.categories.isEmpty) {
              return ValueListenableBuilder<Box<Category>>(
                  valueListenable: Hive.box<Category>('category').listenable(),
                  builder: (context, box, _) {
                    final categories = box.values.toList().cast<Category>();

                    return ListView(
                      children: List.generate(
                          categories.length,
                          (index) => CategoryCard(
                              description: categories[index].description,
                              name: categories[index].name,
                              thumbnail: categories[index].thumbnail)),
                    );
                  });
            }
            return ListView(
              children: List.generate(state.categories.length, (index) {
                final category = state.categories[index];
                return CategoryCard(
                  name: category.name,
                  description: category.description,
                  thumbnail: category.thumbnail,
                );
              }),
            );
          }
          return Center(
            child: Text('Cannot fetch data at the moment'),
          );
        },
      ),
    );
  }
}

class CategoryCard extends StatelessWidget {
  final String thumbnail;
  final String name;
  final String description;

  const CategoryCard({
    required this.description,
    required this.name,
    required this.thumbnail,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      onTap: () {
        Navigator.of(context).push(MaterialPageRoute(
            builder: (context) => MealsScreen(
                  category: name,
                )));
      },
      leading: CircleAvatar(
        backgroundColor: Colors.red,
        radius: 50,
        backgroundImage: NetworkImage(thumbnail),
      ),
      title: Text(name),
      subtitle: Text(description),
      trailing: Icon(Icons.favorite),
    );
  }
}
