import 'package:courier_app/domain/blocs/category/category_bloc.dart';
import 'package:courier_app/domain/blocs/meals/meals_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import './presentation/screens/welcome.dart';

class App extends StatelessWidget {
  App({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<CategoryBloc>(
          create: (context) => CategoryBloc(),
        ),
        BlocProvider<MealsBloc>(create: (context) => MealsBloc()),
      ],
      child: MaterialApp(
        title: 'Courier_App',
        debugShowCheckedModeBanner: false,
        home: Welcome(),
      ),
    );
  }
}
