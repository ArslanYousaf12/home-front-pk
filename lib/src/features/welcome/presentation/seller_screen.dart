import 'package:flutter/material.dart';

import 'package:home_front_pk/src/features/welcome/presentation/seller_content.dart';

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
