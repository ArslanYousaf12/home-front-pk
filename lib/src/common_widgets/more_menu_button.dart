import 'package:home_front_pk/src/common_widgets/alert_dialogs.dart';
import 'package:home_front_pk/src/localization/string_hardcoded.dart';
import 'package:home_front_pk/src/routing/app_router.dart';
import 'package:flutter/material.dart';
import 'package:home_front_pk/src/features/authentication/domain/app_user.dart';
import 'package:go_router/go_router.dart';

enum PopupMenuOption {
  message,
  account,
  admin,
}

class MoreMenuButton extends StatelessWidget {
  const MoreMenuButton(
      {super.key,
      this.user,
      required this.userRole,
      required this.isAdminUser});
  final AppUser? user;
  final String userRole;
  final bool isAdminUser;

  // * Keys for testing using find.byKey()
  static const messageInKey = Key('menuMessage');

  static const accountKey = Key('menuAccount');
  static const adminKey = Key('menuAdmin');

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton(
      // three vertical dots icon (to reveal menu options)
      icon: const Icon(Icons.more_vert),
      itemBuilder: (_) {
        // show all the options based on conditional logic
        return <PopupMenuEntry<PopupMenuOption>>[
          PopupMenuItem(
            key: messageInKey,
            value: PopupMenuOption.message,
            child: Text('Orders'.hardcoded),
          ),
          PopupMenuItem(
            key: accountKey,
            value: PopupMenuOption.account,
            child: Text('Account'.hardcoded),
          ),
          if (isAdminUser)
            PopupMenuItem(
              key: adminKey,
              value: PopupMenuOption.admin,
              child: Text('Admin'.hardcoded),
            ),
        ];
      },
      onSelected: (option) {
        // push to different routes based on selected option
        switch (option) {
          case PopupMenuOption.account:
            if (userRole == 'client') {
              context.goNamed(AppRoute.clientAccount.name);
            } else if (userRole == 'constructor') {
              context.goNamed(AppRoute.constructorAccount.name);
            } else if (userRole == 'designer') {
              context.goNamed(AppRoute.designerAccount.name);
            }

            break;

          case PopupMenuOption.message:
            // context.goNamed(AppRoute.messages.name);
            showNotImplementedAlertDialog(context: context);
            break;
          case PopupMenuOption.admin:
            context.goNamed(AppRoute.admin.name);
        }
      },
    );
  }
}
