import 'package:flutter/material.dart';

import 'package:home_front_pk/src/constants/decoration_widget/bottom_decorated_widget.dart';
import 'package:home_front_pk/src/constants/decoration_widget/center_widget/center_widget.dart';
import 'package:home_front_pk/src/constants/decoration_widget/top_deocrated_widegt.dart';
import 'package:home_front_pk/src/features/welcome/presentation/seller_content.dart';
import 'package:home_front_pk/src/features/welcome/presentation/welcome_content.dart';

class SellerScreen extends StatelessWidget {
  const SellerScreen({super.key});
  //topWidget and ButtonWidget both are for screen design

  @override
  Widget build(BuildContext context) {
    final screenSize = MediaQuery.of(context).size;
    return const Scaffold(
      body: SellerContent(),
    );
  }
}
