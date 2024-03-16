import 'package:flutter/material.dart';

import 'package:home_front_pk/src/constants/app_sizes.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
    this.notificationCallBack,
    this.messageCallBack,
  });

  final VoidCallback? notificationCallBack;
  final VoidCallback? messageCallBack;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: const Icon(
        Icons.person,
        size: 28,
      ),
      title: const Center(child: Text('Dashboard')),
      actions: [
        GestureDetector(
          child: const Icon(
            Icons.notifications_none_outlined,
            size: 28,
          ),
        ),
        gapW12,
        Padding(
          padding: const EdgeInsets.only(right: 20),
          child: GestureDetector(
            child: const Icon(
              Icons.message,
              size: 28,
            ),
          ),
        )
      ],
    );
  }
}
