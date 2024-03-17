import 'package:flutter/material.dart';

class CustomCurvedContainer extends StatelessWidget {
  const CustomCurvedContainer({
    super.key,
    required this.child,
    required this.gradientColors,
  });

  final Widget child;
  final LinearGradient gradientColors;

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 200,
      width: double.infinity,
      decoration: BoxDecoration(
        gradient: gradientColors,
        borderRadius: const BorderRadius.only(
          bottomLeft: Radius.circular(100),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        child: child,
      ),
    );
  }
}
