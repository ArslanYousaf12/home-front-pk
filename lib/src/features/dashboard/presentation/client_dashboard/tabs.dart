import 'package:flutter/material.dart';
import 'package:home_front_pk/src/features/dashboard/presentation/client_dashboard/client_dashboard.dart';
import 'package:home_front_pk/src/features/dashboard/presentation/client_dashboard/designers_list/deigner_list_screen.dart';

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
    Widget activePage = ClientDashboard();
    if (_selectedPageIndex == 1) {
      activePage = DesignerListScreen();
    }
    return Scaffold(
      body: activePage,
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _selectedPageIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.work),
            label: 'Jobs',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.history),
            label: 'History',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person_2_rounded),
            label: 'profile',
          ),
        ],
        onTap: (index) {
          _selectedPage(index);
        },
      ),
    );
  }
}
