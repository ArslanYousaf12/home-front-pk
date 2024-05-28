import 'package:flutter/material.dart';

import 'package:home_front_pk/src/constants/decoration_widget/bottom_decorated_widget.dart';
import 'package:home_front_pk/src/constants/decoration_widget/center_widget/center_widget.dart';
import 'package:home_front_pk/src/constants/decoration_widget/top_deocrated_widegt.dart';
import 'package:home_front_pk/src/features/welcome/presentation/welcome_content.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});
  //topWidget and ButtonWidget both are for screen design

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return Scaffold(
      body: Stack(
        children: [
          Positioned(
            top: -160,
            left: -30,
            child: TopDecoratedWidget(screenWidth: screenSize.width),
          ),
          Positioned(
            bottom: -180,
            left: -40,
            child: BottomDecoradeWidget(screenWidth: screenSize.width),
          ),
          // center widget is center designed
          CenterWidget(size: screenSize),
          //actual data
          const WelcomeContent(),
        ],
      ),
    );
  }
}
