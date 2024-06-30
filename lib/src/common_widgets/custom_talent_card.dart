import 'package:flutter/material.dart';
import 'package:home_front_pk/src/constants/app_sizes.dart';
import 'package:home_front_pk/src/utils/constants.dart';

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
        elevation: 4,
        child: Padding(
          padding:
              const EdgeInsets.only(top: 30, left: 10, right: 10, bottom: 10),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                // leading: const Icon(Icons.build),
                title: Text(title),
                subtitle: Text(description),
              ),
              gapH12,
              ElevatedButton(
                onPressed: onPressed,
                child: const Text('Contact'),
                style: ElevatedButton.styleFrom(
                  elevation: 1,
                  textStyle: TextStyle(
                    fontSize: 15,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
