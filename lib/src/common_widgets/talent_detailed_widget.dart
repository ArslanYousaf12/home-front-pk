import 'package:flutter/material.dart';
import 'package:home_front_pk/src/common_widgets/circular_image.dart';
import 'package:home_front_pk/src/common_widgets/primary_button.dart';
import 'package:home_front_pk/src/common_widgets/responsive_scrollable_card.dart';
import 'package:home_front_pk/src/constants/app_sizes.dart';

class TalentDetailedWidget extends StatelessWidget {
  const TalentDetailedWidget(
      {super.key,
      required this.imageUrl,
      required this.name,
      required this.description,
      required this.onpressed,
      required this.title});

  final String imageUrl;
  final String name;
  final String description;
  final VoidCallback onpressed;
  final String title;

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        ResponsiveScrollableCard(
          child: CircularImage(
            imageUrl: imageUrl,
            width: 250,
            height: 250,
          ),
        ),
        gapH12,
        Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 35,
                fontWeight: FontWeight.w100,
              ),
            ),
            gapH12,
            Text(
              name,
              style: const TextStyle(
                fontSize: 25,
                fontWeight: FontWeight.w200,
              ),
            ),
            gapH24,
            Text(
              description,
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.w200,
              ),
            ),
            gapH32,
            PrimaryButton(
              text: 'CONTACT',
              onPressed: onpressed,
            )
          ],
        )
      ],
    );
  }
}
