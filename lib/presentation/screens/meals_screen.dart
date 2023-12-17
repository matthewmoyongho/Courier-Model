import 'package:courier_app/domain/blocs/meals/meals_bloc.dart';
import 'package:courier_app/domain/blocs/meals/meals_event.dart';
import 'package:courier_app/domain/blocs/meals/meals_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:hive_flutter/adapters.dart';

import '../../data/models/meal.dart';
import '../../presentation/screens/meal_detail.dart';

class MealsScreen extends StatefulWidget {
  String category;
  MealsScreen({Key? key, required this.category}) : super(key: key);

  @override
  State<MealsScreen> createState() => _MealsScreenState();
}

class _MealsScreenState extends State<MealsScreen> {
  // late StreamSubscription internetConnectionChecker;
  // bool connected = false;
  @override
  void initState() {
    super.initState();
    // internetConnectionChecker =
    //     InternetConnectionChecker().onStatusChange.listen((status) {
    //   final connected = status == InternetConnectionStatus.connected;
    //   setState(() {
    //     this.connected = connected;
    //     internetConnectionChecker.cancel();
    //   });
    // });
    // if (connected) {
    //   context.read<MealsBloc>().add(
    //         LoadMeals(widget.category),
    //       );
    // }
    context.read<MealsBloc>().add(
          LoadMeals(widget.category),
        );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(Icons.restaurant_menu),
            Text(
              widget.category,
              style: GoogleFonts.nunito(),
            ),
          ],
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: BlocBuilder<MealsBloc, MealsState>(
        builder: (context, state) {
          if (state is MealsLoading) {
            return const Center(child: CircularProgressIndicator());
          }

          if (state is MealsLoaded) {
            if (state.meals.isEmpty) {
              return ValueListenableBuilder<Box<Meal>>(
                  valueListenable: Hive.box<Meal>('meal').listenable(),
                  builder: (context, box, _) {
                    final meals = box.values.toList().cast<Meal>();

                    return ListView(
                      children: List.generate(
                          meals.length,
                          (index) => Padding(
                                padding: const EdgeInsets.all(8.0),
                                child: InkWell(
                                  onTap: () => Navigator.of(context).push(
                                    MaterialPageRoute(
                                      builder: (context) => MealDetail(
                                        id: meals[index].area,
                                      ),
                                    ),
                                  ),
                                  child: Container(
                                    height: 200,
                                    width: double.infinity,
                                    decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(30),
                                        image: DecorationImage(
                                            image: NetworkImage(
                                                meals[index].thumbnail),
                                            fit: BoxFit.cover)),
                                    child: Column(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        const Expanded(child: SizedBox()),
                                        Text(
                                          meals[index].name,
                                          textAlign: TextAlign.center,
                                          style: GoogleFonts.nunito(
                                            fontWeight: FontWeight.w700,
                                            color: Colors.white,
                                            fontSize: 25,
                                          ),
                                        ),
                                        SizedBox(
                                          height: 50,
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                              )),
                    );
                  });
            }
            return ListView(
              children: List.generate(
                  state.meals.length,
                  (index) => Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) => MealDetail(
                                  id: state.meals[index].area,
                                ),
                              ),
                            );
                          },
                          child: Container(
                            height: 200,
                            width: double.infinity,
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(30),
                                image: DecorationImage(
                                    image: NetworkImage(
                                        state.meals[index].thumbnail),
                                    fit: BoxFit.cover)),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                const Expanded(child: SizedBox()),
                                Text(
                                  state.meals[index].name,
                                  textAlign: TextAlign.center,
                                  style: GoogleFonts.nunito(
                                    fontWeight: FontWeight.w700,
                                    color: Colors.white,
                                    fontSize: 25,
                                  ),
                                ),
                                SizedBox(
                                  height: 50,
                                )
                              ],
                            ),
                          ),
                        ),
                      )),
            );
          }

          return Text('Can not load data at the moment');
        },
      ),
    );
  }
}
