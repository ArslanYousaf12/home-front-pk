// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:home_front_pk/src/common_widgets/action_load_button.dart';
import 'package:home_front_pk/src/common_widgets/alert_dialogs.dart';
import 'package:home_front_pk/src/constants/app_sizes.dart';
import 'package:home_front_pk/src/features/authentication/presentation/account/account_screen_controller.dart';
import 'package:home_front_pk/src/localization/string_hardcoded.dart';
import 'package:home_front_pk/src/routing/app_router.dart';

class ProfileScreen extends ConsumerWidget {
  ProfileScreen({super.key});

  String? selectedValue = null;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.all(15.0),
          child: Column(
            children: [
              const Expanded(
                child:
                    Row(mainAxisAlignment: MainAxisAlignment.start, children: [
                  Flexible(
                    child: CircleAvatar(
                      maxRadius: 35,
                      backgroundImage: AssetImage('assets/person.jpeg'),
                    ),
                  ),
                  gapW16,
                  Flexible(
                    flex: 2,
                    child: ListTile(
                      title: Text(
                        'Arslan Yousaf',
                        style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.w600,
                            fontFamily: 'Montserrat'),
                      ),
                      subtitle: Text('Id#12321.USER'),
                    ),
                  ),
                ]),
              ),
              Expanded(
                  child: Column(
                children: [
                  Card(
                    elevation: 1,
                    color: Colors.white,
                    child: ListTile(
                      leading: const Icon(
                        Icons.attach_money,
                        size: 25,
                      ),
                      title: const Text(
                        'My Balance',
                        style: TextStyle(fontSize: 18),
                      ),
                      trailing: const Text(
                        '\$1540',
                        style: TextStyle(fontSize: 15),
                      ),
                      onTap: () {},
                    ),
                  ),
                  ProfileCard(
                    icon: Icons.work_history_outlined,
                    title: 'My History',
                    onTap: () {},
                  ),
                  ProfileCard(
                    title: 'Setting',
                    icon: Icons.settings,
                    onTap: () {},
                  ),
                  ProfileCard(
                    title: 'About',
                    icon: Icons.assignment_late_outlined,
                    onTap: () {},
                  ),
                ],
              )),
              Padding(
                padding: const EdgeInsets.only(bottom: 30),
                child: ActionLoadButton(
                  text: 'Logout',
                  iconData: Icons.logout_outlined,
                  onPressed: () async {
                    final logout = await showAlertDialog(
                      context: context,
                      title: 'Are your Sure'.hardcoded,
                      cancelActionText: 'Cancel'.hardcoded,
                      defaultActionText: 'Logout'.hardcoded,
                    );
                    if (logout == true) {
                      final success = await ref
                          .read(accountScreenControllerProvider.notifier)
                          .signOut();
                      if (success) {
                        goRouter.pop();
                      }
                    }
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProfileCard extends StatelessWidget {
  const ProfileCard({
    super.key,
    required this.title,
    required this.icon,
    required this.onTap,
  });

  final String title;
  final IconData icon;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 1,
      color: Colors.white,
      child: ListTile(
        leading: Icon(
          icon,
          size: 25,
        ),
        title: Text(
          title,
          style: TextStyle(fontSize: 18),
        ),
        onTap: onTap,
        // subtitle: Text(''),
      ),
    );
  }
}
