import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:home_front_pk/src/common_widgets/cutome_curved_container.dart';
import 'package:home_front_pk/src/common_widgets/grid_card.dart';
import 'package:home_front_pk/src/common_widgets/home_app_bar.dart';
import 'package:home_front_pk/src/constants/app_sizes.dart';

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
        preferredSize: Size.fromHeight(80),
        child: HomeAppBar(),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomCurvedContainer(
              gradientColors: LinearGradient(
                colors: [
                  Colors.green.shade800,
                  Colors.green.shade100,
                ],
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Welcome Back',
                    style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                  ),
                  gapH8,
                  ElevatedButton(
                    onPressed: () {},
                    child: const Text('Jobs'),
                  ),
                ],
              ),
            ),
            gapH12,
            Padding(
              padding: const EdgeInsets.all(12.0),
              child: GridView.count(
                  crossAxisCount: 2,
                  childAspectRatio: 1.5 / 1.2,
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    GridCard(
                        iconName: FontAwesomeIcons.images, title: 'Portfolio'),
                    GridCard(
                        iconName: FontAwesomeIcons.briefcase,
                        title: 'New Requests'),
                    GridCard(
                        iconName: FontAwesomeIcons.tasks,
                        title: 'Ongoing Projects'),
                    GridCard(
                        iconName: FontAwesomeIcons.comments, title: 'Messages'),
                    GridCard(
                        iconName: FontAwesomeIcons.paperPlane,
                        title: 'Offers Sent'),
                    GridCard(
                        iconName: FontAwesomeIcons.checkCircle,
                        title: 'Completed Projects'),
                    GridCard(
                        iconName: FontAwesomeIcons.wallet, title: 'Payments'),
                    GridCard(
                        iconName: FontAwesomeIcons.userEdit,
                        title: 'Update Profile'),
                  ]),
            ),
          ],
        ),
      ),
    );
  }
}
