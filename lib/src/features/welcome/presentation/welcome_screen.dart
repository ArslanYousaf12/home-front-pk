import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:home_front_pk/src/common_widgets/circular_image.dart';

import 'package:home_front_pk/src/common_widgets/decorated_box_with_shadow.dart';
import 'package:home_front_pk/src/common_widgets/responsive_center.dart';
import 'package:home_front_pk/src/common_widgets/responsive_scrollable_card.dart';
import 'package:home_front_pk/src/common_widgets/welcome_screen_button.dart';
import 'package:home_front_pk/src/constants/app_sizes.dart';
import 'package:home_front_pk/src/routing/app_router.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ResponsiveCenter(
          padding: const EdgeInsets.only(
            top: 40,
            left: 30,
            right: 30,
          ),
          child: Column(
            children: [
              const CircularImage(imageUrl: 'assets/logo.jpeg'),
              gapH4,
              const ResponsiveScrollableCard(
                color: Color.fromARGB(99, 48, 70, 91),
                child: Center(
                  child: Text(
                    'Welcome',
                    style: TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
                  ),
                ),
              ),
              gapH64,
              const Padding(
                padding: EdgeInsets.only(left: 20, right: 20),
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    DecoratedBoxWithShadow(
                      child: CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/welcome/image.jpeg'),
                      ),
                    ),
                    gapW32,
                    DecoratedBoxWithShadow(
                      child: CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/welcome/designer.jpg'),
                      ),
                    ),
                    gapW32,
                    DecoratedBoxWithShadow(
                      child: CircleAvatar(
                        backgroundImage:
                            AssetImage('assets/welcome/constructor.jpg'),
                      ),
                    ),
                  ],
                ),
              ),
              gapH64,
              Column(
                children: [
                  WelcomeButton(
                    text: 'Client Login',
                    color: Colors.green,
                    onPressed: () {
                      context.goNamed(AppRoute.signInClient.name);
                    },
                  ),
                  gapH16,
                  WelcomeButton(
                    text: 'Constructor Login',
                    color: const Color.fromARGB(245, 228, 186, 62),
                    onPressed: () {
                      context.goNamed(AppRoute.signInConstructor.name);
                    },
                  ),
                  gapH16,
                  WelcomeButton(
                    text: 'Designer Login',
                    color: const Color.fromARGB(255, 129, 199, 132),
                    onPressed: () {
                      context.goNamed(AppRoute.signInDesigner.name);
                    },
                  ),
                  gapH4,
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
