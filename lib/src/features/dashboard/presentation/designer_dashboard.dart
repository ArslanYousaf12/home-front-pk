import 'package:flutter/material.dart';
import 'package:home_front_pk/src/common_widgets/home_app_bar.dart';

class DesignerDashboard extends StatefulWidget {
  const DesignerDashboard({super.key});

  @override
  State<DesignerDashboard> createState() => _DesignerDashboardState();
}

class _DesignerDashboardState extends State<DesignerDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: const Size.fromHeight(80),
        child: HomeAppBar(),
      ),
    );
  }
}
