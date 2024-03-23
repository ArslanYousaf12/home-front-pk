import 'package:flutter/material.dart';
import 'package:home_front_pk/src/constants/app_sizes.dart';

class CustomTalentCard extends StatelessWidget {
  const CustomTalentCard({
    super.key,
    required this.title,
    required this.icon,
    required this.description,
    this.onPressed,
  });
  final String title;
  final IconData icon;
  final String description;
  final VoidCallback? onPressed;
  static const talentCardKey = Key('Talent-card');

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onPressed,
      child: Card(
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
                onPressed: onPressed,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
