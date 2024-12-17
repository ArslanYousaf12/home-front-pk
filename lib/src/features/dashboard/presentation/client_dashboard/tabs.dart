import 'package:flutter/material.dart';
import 'package:home_front_pk/src/features/client/presentation/client_screen.dart';
import 'package:home_front_pk/src/features/cost_calculator/presentation/calculatorScreen.dart';
import 'package:home_front_pk/src/features/dashboard/presentation/client_dashboard/client_dashboard.dart';
import 'package:home_front_pk/src/features/profile/presentation/profile_screen.dart';

class UserTabScreen extends StatefulWidget {
  const UserTabScreen({super.key});

  @override
  State<UserTabScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<UserTabScreen> {
  int _selectedPageIndex = 0;
  void _selectedPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    Widget activePage = const ClientDashboard();
    if (_selectedPageIndex == 1) {
      activePage = const CalculatorScreen();
    } else if (_selectedPageIndex == 2) {
      activePage = ClientProfileScreen();
    }
    return Scaffold(
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.work),
            label: 'workers',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.calculate),
            label: 'Cost calculator',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_outlined),
            label: 'Profile',
          ),
        ],
        onTap: (index) {
          _selectedPage(index);
        },
      ),
    );
  }
}
