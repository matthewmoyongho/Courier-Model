import 'package:courier_app/domain/blocs/meals/meals_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../domain/blocs/meals/meals_bloc.dart';
import '../../domain/blocs/meals/meals_state.dart';

class MealDetail extends StatefulWidget {
  final String id;
  const MealDetail({Key? key, required this.id}) : super(key: key);

  @override
  State<MealDetail> createState() => _MealDetailState();
}

class _MealDetailState extends State<MealDetail> {
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
    //   context.read<MealsBloc>().add(LoadMealOnline(widget.id));
    // } else {
    //   context.read<MealsBloc>().add(LoadMealFromBox(widget.id));
    // }
    context.read<MealsBloc>().add(LoadMeal(widget.id));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              Icons.restaurant_menu,
            ),
            SizedBox(
              width: 3,
            ),
            Text(
              'Meal Detail',
              style: GoogleFonts.nunito(),
            ),
          ],
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: Colors.white,
        foregroundColor: Colors.black,
      ),
      body: BlocBuilder<MealsBloc, MealsState>(builder: (context, state) {
        if (state is MealsLoaded) {
          if (state.meal != null) {
            return Column(
              children: [
                Container(
                  height: MediaQuery.of(context).size.height * .4,
                  width: double.infinity,
                  decoration: BoxDecoration(
                      image: DecorationImage(
                          image: NetworkImage(state.meal!.thumbnail),
                          fit: BoxFit.cover)),
                  alignment: Alignment.center,
                ),
                Expanded(
                    child: Container(
                  alignment: Alignment.centerLeft,
                  padding: EdgeInsets.all(15),
                  color: Colors.white,
                  child: ListView(
                    // crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        state.meal!.name,
                        style: GoogleFonts.nunito(
                            fontSize: 30, fontWeight: FontWeight.w700),
                      ),
                      Divider(
                        thickness: 2,
                        color: Colors.grey,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: [
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.yellow),
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'Category - ${state.meal!.category}',
                              style: GoogleFonts.nunito(
                                  fontSize: 14, fontWeight: FontWeight.w700),
                            ),
                          ),
                          Container(
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(15),
                                color: Colors.red),
                            padding: EdgeInsets.all(10),
                            child: Text(
                              'Number: ${state.meal!.area}',
                              style: GoogleFonts.nunito(
                                  fontSize: 14, fontWeight: FontWeight.w700),
                            ),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 5,
                      ),
                      Text(
                        state.meal!.instructions,
                        style: GoogleFonts.nunito(
                          fontSize: 14,
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ],
                  ),
                ))
              ],
            );
          } else {
            return Center(
              child: Text('You need to connect to the internet to view this!'),
            );
          }
        }
        return Center(child: CircularProgressIndicator());
      }),
    );
  }
}
