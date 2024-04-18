import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:home_front_pk/src/common_widgets/alert_dialogs.dart';
import 'package:home_front_pk/src/common_widgets/cutome_curved_container.dart';
import 'package:home_front_pk/src/common_widgets/grid_card.dart';
import 'package:home_front_pk/src/common_widgets/home_app_bar.dart';
import 'package:home_front_pk/src/constants/app_sizes.dart';
import 'package:home_front_pk/src/features/authentication/presentation/account/account_screen_controller.dart';
import 'package:home_front_pk/src/localization/string_hardcoded.dart';
import 'package:home_front_pk/src/routing/app_router.dart';

class ConstructorDashboard extends ConsumerStatefulWidget {
  const ConstructorDashboard({super.key});

  @override
  ConsumerState<ConstructorDashboard> createState() =>
      _ConstructorDashboardState();
}

class _ConstructorDashboardState extends ConsumerState<ConstructorDashboard> {
  @override
  Widget build(BuildContext context) {
    //using popScope to prevent user to goBack to sigin Screen
    // without logout
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: Size.fromHeight(80),
          child: HomeAppBar(
            userRole: 'constructor',
            titles: 'Constructor Dashboard',
            notificationCallBack: () =>
                showNotImplementedAlertDialog(context: context),
            logOut: () async {
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
                  goRouter.pop();
                }
              }
            },
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              CustomCurvedContainer(
                gradientColors: LinearGradient(
                  colors: [
                    Colors.amber.shade100,
                    const Color(0xFFF6F7C4),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'Welcome Back',
                      style: TextStyle(
                        color: Colors.black87,
                        fontSize: 25,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    gapH8,
                    ElevatedButton(
                        onPressed: () {
                          showNotImplementedAlertDialog(context: context);
                        },
                        child: const Text('Find Jobs')),
                  ],
                ),
              ),
              gapH12,
              GridView.count(
                crossAxisCount: 2,
                childAspectRatio: 2 / 1.5,
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                children: [
                  GridCard(
                    iconName: FontAwesomeIcons.images,
                    title: 'Portfolio',
                    gradients: [const Color(0xFFF6F7C4), Colors.amber.shade100],
                    color: Colors.black54,
                    onPressed: () =>
                        context.goNamed(AppRoute.constructorPortfolio.name),
                  ),
                  GridCard(
                      iconName: FontAwesomeIcons.briefcase,
                      title: 'New Requests',
                      gradients: [
                        const Color(0xFFF6F7C4),
                        Colors.amber.shade100
                      ],
                      color: Colors.black54,
                      onPressed: () => context.goNamed(
                            AppRoute.newRequest.name,
                          )
                      // showNotImplementedAlertDialog(context: context),
                      ),
                  GridCard(
                    iconName: FontAwesomeIcons.listCheck,
                    title: 'Ongoing Projects',
                    gradients: [const Color(0xFFF6F7C4), Colors.amber.shade100],
                    color: Colors.black54,
                    onPressed: () =>
                        showNotImplementedAlertDialog(context: context),
                  ),
                  GridCard(
                    iconName: FontAwesomeIcons.comments,
                    title: 'Messages',
                    gradients: [const Color(0xFFF6F7C4), Colors.amber.shade100],
                    color: Colors.black54,
                    onPressed: () =>
                        showNotImplementedAlertDialog(context: context),
                  ),
                  GridCard(
                    iconName: FontAwesomeIcons.paperPlane,
                    title: 'Offers Sent',
                    gradients: [const Color(0xFFF6F7C4), Colors.amber.shade100],
                    color: Colors.black54,
                    onPressed: () =>
                        showNotImplementedAlertDialog(context: context),
                  ),
                  GridCard(
                    iconName: FontAwesomeIcons.circleCheck,
                    title: 'Completed Projects',
                    gradients: [const Color(0xFFF6F7C4), Colors.amber.shade100],
                    color: Colors.black54,
                    onPressed: () =>
                        showNotImplementedAlertDialog(context: context),
                  ),
                  GridCard(
                    iconName: FontAwesomeIcons.wallet,
                    title: 'Payments',
                    gradients: [const Color(0xFFF6F7C4), Colors.amber.shade100],
                    color: Colors.black54,
                    onPressed: () =>
                        showNotImplementedAlertDialog(context: context),
                  ),
                  GridCard(
                    iconName: FontAwesomeIcons.userPen,
                    title: 'Update Profile',
                    gradients: [const Color(0xFFF6F7C4), Colors.amber.shade100],
                    color: Colors.black54,
                    onPressed: () =>
                        showNotImplementedAlertDialog(context: context),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
