import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_front_pk/src/common_widgets/alert_dialogs.dart';
import 'package:home_front_pk/src/features/authentication/data/auth_repository.dart';
import 'package:home_front_pk/src/features/authentication/domain/app_user.dart';

import 'package:home_front_pk/src/features/authentication/presentation/account/account_screen_controller.dart';
import 'package:home_front_pk/src/localization/string_hardcoded.dart';
import 'package:flutter/material.dart';
import 'package:home_front_pk/src/common_widgets/action_text_button.dart';
import 'package:home_front_pk/src/common_widgets/responsive_center.dart';
import 'package:home_front_pk/src/constants/app_sizes.dart';
import 'package:go_router/go_router.dart';
import 'package:home_front_pk/src/routing/app_router.dart';
import 'package:home_front_pk/src/utils/async_value_ui.dart';

const logoutKey = Key('logoutButton');

/// Simple account screen showing some user info and a logout button.
class AccountScreen extends ConsumerWidget {
  const AccountScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.listen<AsyncValue<void>>(
      accountScreenControllerProvider,
      (_, state) => state.showAlertDialogOnError(context),
    );
    final state = ref.watch(accountScreenControllerProvider);
    return Scaffold(
      appBar: AppBar(
        title: state.isLoading
            ? const CircularProgressIndicator()
            : Text(
                'Account'.hardcoded,
              ),
        actions: [
          ActionTextButton(
            key: logoutKey,
            text: 'Logout'.hardcoded,
            color: Colors.black87,
            onPressed: state.isLoading
                ? null
                : () async {
                    // * Get the navigator beforehand to prevent this warning:
                    // * Don't use 'BuildContext's across async gaps.
                    // * More info here: https://youtu.be/bzWaMpD1LHY
                    final goRouter = GoRouter.of(context);
                    final logout = await showAlertDialog(
                      context: context,
                      title: 'Are you sure?'.hardcoded,
                      cancelActionText: 'Cancel'.hardcoded,
                      defaultActionText: 'Logout'.hardcoded,
                    );
                    if (logout == true) {
                      final success = await ref
                          .read(accountScreenControllerProvider.notifier)
                          .signOut();
                      if (success) {
                        goRouter.goNamed(AppRoute.welcome.name);
                      }
                    }
                  },
          ),
        ],
      ),
      body: const ResponsiveCenter(
        padding: EdgeInsets.symmetric(horizontal: Sizes.p16),
        child: AccountScreenContents(),
      ),
    );
  }
}

/// Simple user data table showing the uid and email
// class UserDataTable extends ConsumerWidget {
//   const UserDataTable({super.key});

//   @override
//   Widget build(BuildContext context, WidgetRef ref) {
//     final style = Theme.of(context).textTheme.titleSmall!;
//     final user = ref.watch(authStateChangeProvider).value;
//     return DataTable(
//       columns: [
//         DataColumn(
//           label: Text(
//             'Field'.hardcoded,
//             style: style,
//           ),
//         ),
//         DataColumn(
//           label: Text(
//             'Value'.hardcoded,
//             style: style,
//           ),
//         ),
//       ],
//       rows: [
//         _makeDataRow(
//           'uid'.hardcoded,
//           user?.uid ?? '',
//           style,
//         ),
//         _makeDataRow(
//           'email'.hardcoded,
//           user?.email ?? '',
//           style,
//         ),
//       ],
//     );
//   }

//   DataRow _makeDataRow(String name, String value, TextStyle style) {
//     return DataRow(
//       cells: [
//         DataCell(
//           Text(
//             name,
//             style: style,
//           ),
//         ),
//         DataCell(
//           Text(
//             value,
//             style: style,
//             maxLines: 2,
//           ),
//         ),
//       ],
//     );
//   }
// }
/// Simple user data table showing the uid and email
class AccountScreenContents extends ConsumerWidget {
  const AccountScreenContents({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final user = ref.watch(authStateChangeProvider).value;
    if (user == null) {
      return const SizedBox.shrink();
    }

    return Column(
      mainAxisSize: MainAxisSize.min,
      children: [
        Text(
          user.uid,
          style: Theme.of(context)
              .textTheme
              .bodySmall!
              .copyWith(color: Colors.black),
        ),
        gapH32,
        Text(
          user.email ?? '',
          style: Theme.of(context).textTheme.titleMedium,
        ),
        gapH16,
        EmailVerificationWidget(user: user),
      ],
    );
  }
}

class EmailVerificationWidget extends ConsumerWidget {
  const EmailVerificationWidget({super.key, required this.user});
  final AppUser user;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(accountScreenControllerProvider);
    if (user.emailVerified == false) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          OutlinedButton(
            onPressed: state.isLoading
                ? null
                : () async {
                    final success = await ref
                        .read(accountScreenControllerProvider.notifier)
                        .sendEmailVerification(user);
                    if (success && context.mounted) {
                      showAlertDialog(
                        context: context,
                        title: 'Sent - now check your email'.hardcoded,
                      );
                    }
                  },
            child: Text(
              'Verify email'.hardcoded,
              style: Theme.of(context).textTheme.titleLarge,
            ),
          ),
        ],
      );
    } else {
      return Row(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Text(
            'Verified'.hardcoded,
            style: Theme.of(context)
                .textTheme
                .titleMedium!
                .copyWith(color: Colors.green.shade700),
          ),
          gapW8,
          Icon(Icons.check_circle, color: Colors.green.shade700),
        ],
      );
    }
  }
}
