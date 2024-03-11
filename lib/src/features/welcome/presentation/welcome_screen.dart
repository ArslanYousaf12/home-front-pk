import 'package:flutter/material.dart';
import 'package:home_front_pk/src/common_widgets/custom_image.dart';
import 'package:home_front_pk/src/common_widgets/decorated_box_with_shadow.dart';
import 'package:home_front_pk/src/common_widgets/responsive_center.dart';
import 'package:home_front_pk/src/common_widgets/responsive_scrollable_card.dart';
import 'package:home_front_pk/src/common_widgets/welcome_screen_button.dart';
import 'package:home_front_pk/src/constants/app_sizes.dart';

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
              ClipOval(
                child: CustomImage(
                  imageUrl: 'assets/logo.jpeg',
                  width: 100, // Set the width to fit your layout
                  height: 100, // Set the height to fit your layout
                  boxFit: BoxFit.cover, // Cover the container's shape
                ),
              ),
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
                    onPressed: () {},
                  ),
                  gapH16,
                  WelcomeButton(
                    text: 'Constructor Login',
                    color: const Color.fromARGB(245, 228, 186, 62),
                    onPressed: () {},
                  ),
                  gapH16,
                  WelcomeButton(
                    text: 'Designer Login',
                    color: const Color.fromARGB(255, 129, 199, 132),
                    onPressed: () {},
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
