import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:home_front_pk/src/common_widgets/cutome_curved_container.dart';
import 'package:home_front_pk/src/common_widgets/grid_card.dart';
import 'package:home_front_pk/src/common_widgets/home_app_bar.dart';
import 'package:home_front_pk/src/constants/app_sizes.dart';

class ConstructorDashboard extends StatefulWidget {
  const ConstructorDashboard({super.key});

  @override
  State<ConstructorDashboard> createState() => _ConstructorDashboardState();
}

class _ConstructorDashboardState extends State<ConstructorDashboard> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const PreferredSize(
        preferredSize: Size.fromHeight(80),
        child: HomeAppBar(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomCurvedContainer(
              gradientColors: LinearGradient(
                colors: [Colors.amber.shade300, Colors.amber.shade100],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Text(
                    'Welcome Back',
                    style: TextStyle(
                      color: Colors.black87,
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  gapH8,
                  ElevatedButton(
                      onPressed: () {}, child: const Text('Find Jobs')),
                ],
              ),
            ),
            gapH12,
            GridView.count(
              crossAxisCount: 2,
              childAspectRatio: 2 / 1.5,
              shrinkWrap: true,
              physics: const NeverScrollableScrollPhysics(),
              children: [
                GridCard(
                  iconName: FontAwesomeIcons.images,
                  title: 'Portfolio',
                  gradients: [Colors.amber.shade300, Colors.amber.shade100],
                  color: Colors.black54,
                ),
                GridCard(
                  iconName: FontAwesomeIcons.briefcase,
                  title: 'New Requests',
                  gradients: [Colors.amber.shade300, Colors.amber.shade100],
                  color: Colors.black54,
                ),
                GridCard(
                  iconName: FontAwesomeIcons.listCheck,
                  title: 'Ongoing Projects',
                  gradients: [Colors.amber.shade300, Colors.amber.shade100],
                  color: Colors.black54,
                ),
                GridCard(
                  iconName: FontAwesomeIcons.comments,
                  title: 'Messages',
                  gradients: [Colors.amber.shade300, Colors.amber.shade100],
                  color: Colors.black54,
                ),
                GridCard(
                  iconName: FontAwesomeIcons.paperPlane,
                  title: 'Offers Sent',
                  gradients: [Colors.amber.shade300, Colors.amber.shade100],
                  color: Colors.black54,
                ),
                GridCard(
                  iconName: FontAwesomeIcons.circleCheck,
                  title: 'Completed Projects',
                  gradients: [Colors.amber.shade300, Colors.amber.shade100],
                  color: Colors.black54,
                ),
                GridCard(
                  iconName: FontAwesomeIcons.wallet,
                  title: 'Payments',
                  gradients: [Colors.amber.shade300, Colors.amber.shade100],
                  color: Colors.black54,
                ),
                GridCard(
                  iconName: FontAwesomeIcons.userPen,
                  title: 'Update Profile',
                  gradients: [Colors.amber.shade300, Colors.amber.shade100],
                  color: Colors.black54,
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
