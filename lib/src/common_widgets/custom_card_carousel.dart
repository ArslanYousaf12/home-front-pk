import 'package:flutter/material.dart';
import 'package:home_front_pk/src/constants/app_sizes.dart';

class CustomeCardCarousel extends StatelessWidget {
  const CustomeCardCarousel(
      {super.key,
      required this.title,
      required this.icon,
      required this.description});
  final String title;
  final IconData icon;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Card(
      color: Colors.amber.shade300,
      child: Padding(
        padding: const EdgeInsets.only(top: 30, left: 10, right: 10),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            ListTile(
              leading: const Icon(Icons.build),
              title: Text(title),
              subtitle: Text(description),
            ),
            gapH12,
            ElevatedButton(
              child: const Text('Contact'),
              onPressed: () {/* Do something */},
            ),
          ],
        ),
      ),
    );
  }
}
