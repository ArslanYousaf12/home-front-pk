import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:home_front_pk/src/common_widgets/action_text_button.dart';
import 'package:home_front_pk/src/common_widgets/more_menu_button.dart';

import 'package:home_front_pk/src/constants/app_sizes.dart';
import 'package:home_front_pk/src/features/authentication/data/fake_auth_repository.dart';
import 'package:home_front_pk/src/localization/string_hardcoded.dart';
import 'package:home_front_pk/src/routing/app_router.dart';

class HomeAppBar extends ConsumerWidget {
  HomeAppBar({
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
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateChangeProvider).value;
    // TODO: Add role-based authorization
    final isAdminUser = user != null;
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
            Icons.message,
            size: 28,
          ),
        ),
        gapW12,
        MoreMenuButton(
          userRole: userRole,
          isAdminUser: true,
        ),
        if (isAdminUser)
          ActionTextButton(
            key: MoreMenuButton.adminKey,
            text: 'Admin'.hardcoded,
            onPressed: () => context.pushNamed(AppRoute.admin.name),
          ),
      ],
    );
  }
}
