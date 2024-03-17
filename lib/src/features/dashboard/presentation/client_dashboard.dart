import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:home_front_pk/src/common_widgets/cutome_curved_container.dart';
import 'package:home_front_pk/src/common_widgets/home_app_bar.dart';
import 'package:home_front_pk/src/common_widgets/welcome_screen_button.dart';
import 'package:home_front_pk/src/constants/app_sizes.dart';
import 'package:home_front_pk/src/constants/ktest_constructor_card.dart';

class ClientDashboard extends StatefulWidget {
  const ClientDashboard({super.key});

  @override
  State<ClientDashboard> createState() => _ClientDashboardState();
}

class _ClientDashboardState extends State<ClientDashboard> {
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
                  Colors.green.shade100,
                  Colors.green.shade400,
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
                      onPressed: () {}, child: const Text('Cost Calculator'))
                ],
              ),
            ),
            gapH12,
            const Text(
              'Constructors',
              style: TextStyle(
                fontSize: 25, // Increased font size for emphasis
                fontWeight: FontWeight.bold, // Bold font weight for impact
                color: Colors.white, // Example color
              ),
            ),
            gapH12,
            CarouselSlider.builder(
              itemCount: ktestConstructorCard.length,
              itemBuilder: (context, index, realIndex) =>
                  ktestConstructorCard[index],
              options: CarouselOptions(
                height: 250,
                enableInfiniteScroll: true,
                autoPlay: false,
                // autoPlayInterval: Duration(seconds: 3),
                // autoPlayAnimationDuration: Duration(milliseconds: 800),
                // autoPlayCurve: Curves.fastOutSlowIn,
                enlargeCenterPage: true,
                viewportFraction: 0.8,
              ),
            ),
            gapH12,
            Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    WelcomeButton(
                      text: 'Incomming Jobs',
                      color: Colors.green.shade200,
                      onPressed: () {},
                    ),
                    gapH12,
                    WelcomeButton(
                      text: 'View Designer',
                      color: Colors.amber.shade200,
                      onPressed: () {},
                    ),
                  ],
                )),
          ],
        ),
      ),
    );
  }
}
