import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:home_front_pk/src/constants/app_sizes.dart';

class GridCard extends StatelessWidget {
  const GridCard(
      {super.key,
      required this.iconName,
      required this.title,
      this.gradients,
      this.color});

  final IconData iconName;
  final String title;
  final List<Color>? gradients;
  final Color? color;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        // Implement your onTap functionality here, if necessary
      },
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
                    Colors.green.shade300,
                    Colors.green.shade100,
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
                  color: color ?? Colors.white,
                ),
                gapH12, // Spacing after icon
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: color ?? Colors.white,
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
