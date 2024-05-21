import 'package:flutter/material.dart';
import 'package:home_front_pk/src/common_widgets/more_menu_button.dart';

import 'package:home_front_pk/src/constants/app_sizes.dart';
import 'package:home_front_pk/src/features/authentication/domain/app_user.dart';
import 'package:home_front_pk/src/features/authentication/presentation/account/account_screen.dart';

class HomeAppBar extends StatelessWidget {
  HomeAppBar({
    super.key,
    this.notificationCallBack,
    this.messageCallBack,
    this.logOut,
    required this.userRole,
    this.titles,
    this.backColor,
  });

  final VoidCallback? notificationCallBack;
  final VoidCallback? messageCallBack;
  final VoidCallback? logOut;
  final String userRole;
  String? titles;
  Color? backColor;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: backColor,
      leading: InkWell(
        onTap: logOut,
        child: const Icon(
          Icons.exit_to_app,
          size: 28,
        ),
      ),
      title: Center(child: Text(titles == null ? 'Dashboard' : titles!)),
      actions: [
        GestureDetector(
          onTap: notificationCallBack,
          child: const Icon(
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
