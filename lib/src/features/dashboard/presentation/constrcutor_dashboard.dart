import 'package:flutter/material.dart';
import 'package:home_front_pk/src/common_widgets/home_app_bar.dart';

class ConstructorDashboard extends StatefulWidget {
  const ConstructorDashboard({super.key});

  @override
  State<ConstructorDashboard> createState() => _ConstructorDashboardState();
}

class _ConstructorDashboardState extends State<ConstructorDashboard> {
  @override
  Widget build(BuildContext context) {
    return const Scaffold(
      appBar: PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: HomeAppBar(),
      ),
    );
  }
}
