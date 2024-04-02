import 'package:flutter/material.dart';
import 'package:home_front_pk/src/common_widgets/more_menu_button.dart';

import 'package:home_front_pk/src/constants/app_sizes.dart';
import 'package:home_front_pk/src/features/authentication/domain/app_user.dart';
import 'package:home_front_pk/src/features/authentication/presentation/account/account_screen.dart';

class HomeAppBar extends StatelessWidget {
  const HomeAppBar({
    super.key,
    this.notificationCallBack,
    this.messageCallBack,
    this.logOut,
    required this.userRole,
  });

  final VoidCallback? notificationCallBack;
  final VoidCallback? messageCallBack;
  final VoidCallback? logOut;
  final String userRole;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: InkWell(
        onTap: logOut,
        child: const Icon(
          Icons.exit_to_app,
          size: 28,
        ),
      ),
      title: const Center(child: Text('Dashboard')),
      actions: [
        GestureDetector(
          onTap: notificationCallBack,
          child: Icon(
            Icons.notifications_none_outlined,
            size: 28,
          ),
        ),
        gapW12,
        MoreMenuButton(
          userRole: userRole,
        ),
      ],
    );
  }
}
