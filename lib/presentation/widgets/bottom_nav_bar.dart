import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class BottomNavBar extends StatelessWidget {
  int navIndex;
  Function(int) onTap;
  BottomNavBar({
    required this.navIndex,
    required this.onTap,
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Material(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(15),
        topRight: Radius.circular(15),
      ),
      color: Colors.white,
      child: NavigationBarTheme(
        data: NavigationBarThemeData(
          indicatorColor: Colors.black,
          labelTextStyle: MaterialStateProperty.all(
            GoogleFonts.nunito(fontSize: 14),
          ),
        ),
        child: NavigationBar(
          onDestinationSelected: onTap,
          selectedIndex: navIndex,
          backgroundColor: Colors.transparent,
          destinations: const [
            NavigationDestination(
              icon: Icon(Icons.wallet),
              label: 'Wallet',
              selectedIcon: Icon(
                Icons.wallet,
                color: Colors.white,
              ),
            ),
            NavigationDestination(
              icon: Icon(Icons.history),
              label: 'History',
              selectedIcon: Icon(
                Icons.history,
                color: Colors.white,
              ),
            ),
            NavigationDestination(
                selectedIcon: Icon(
                  Icons.offline_bolt_outlined,
                  color: Colors.white,
                ),
                icon: Icon(Icons.offline_bolt_outlined),
                label: 'Home'),
            NavigationDestination(
              icon: Icon(
                Icons.bar_chart,
              ),
              label: 'Orders',
              selectedIcon: Icon(
                Icons.bar_chart,
                color: Colors.white,
              ),
            ),
            NavigationDestination(
              icon: Icon(Icons.account_circle),
              label: 'Profile',
              selectedIcon: Icon(
                Icons.account_circle,
                color: Colors.white,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
