import 'package:flutter/material.dart';
import 'package:home_front_pk/src/constants/app_sizes.dart';

class GridCard extends StatelessWidget {
  const GridCard({
    super.key,
    required this.iconName,
    required this.title,
    this.gradients,
    this.color,
    this.onPressed,
  });

  final IconData iconName;
  final String title;
  final List<Color>? gradients;
  final Color? color;
  final VoidCallback? onPressed;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(16), // Rounded corners
        ),
        elevation: 4, // Shadow effect
        child: Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: gradients ??
                  [
                    const Color(0xFFA1EEBD),
                    const Color(0xFFF6F7C4),
                  ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(
                16), // Consistent rounded corners with the card
          ),
          child: Padding(
            padding: const EdgeInsets.all(16.0), // Added padding
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Icon(
                  iconName,
                  size: 30,
                  color: color ?? Colors.black54,
                ),
                gapH12, // Spacing after icon
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: color ?? Colors.black54,
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
