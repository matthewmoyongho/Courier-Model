import 'package:courier_app/domain/blocs/category/category_bloc.dart';
import 'package:courier_app/domain/blocs/category/category_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../presentation/screens/history.dart';
import '../../presentation/screens/home.dart';
import '../../presentation/screens/order.dart';
import '../../presentation/screens/profile.dart';
import '../../presentation/screens/wallet.dart';
import '../widgets/bottom_nav_bar.dart';

class Welcome extends StatefulWidget {
  @override
  State<Welcome> createState() => _WelcomeState();
}

class _WelcomeState extends State<Welcome> {
  int navIndex = 1;

  List<Widget> screens = [
    Wallet(),
    History(),
    Home(),
    Order(),
    Profile(),
  ];

  @override
  void initState() {
    super.initState();

    context.read<CategoryBloc>().add(LoadCategories());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[navIndex],
      bottomNavigationBar: BottomNavBar(
        navIndex: navIndex,
        onTap: (index) {
          setState(() {
            navIndex = index;
          });
        },
      ),
      extendBody: true,
    );
  }
}
