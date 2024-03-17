import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class GridCard extends StatelessWidget {
  const GridCard({super.key, required this.iconName, required this.title});

  final IconData iconName;
  final String title;

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
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Theme.of(context)
                    .colorScheme
                    .background, // Use theme colors for better consistency
                Theme.of(context).primaryColor,
              ],
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
                  color: Colors.white,
                ),
                SizedBox(height: 12), // Spacing after icon
                Text(
                  title,
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    color: Colors.white,
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
