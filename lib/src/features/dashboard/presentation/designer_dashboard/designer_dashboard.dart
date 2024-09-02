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
import 'package:home_front_pk/src/features/chat_section/presentation/chat_screen.dart';
import 'package:home_front_pk/src/localization/string_hardcoded.dart';
import 'package:home_front_pk/src/routing/app_router.dart';

class DesignerDashboard extends ConsumerStatefulWidget {
  const DesignerDashboard({super.key});

  @override
  ConsumerState<DesignerDashboard> createState() => _DesignerDashboardState();
}

class _DesignerDashboardState extends ConsumerState<DesignerDashboard> {
  @override
  Widget build(BuildContext context) {
    //using popScope to prevent user to goBack to sigin Screen
    // without logout
    return PopScope(
      canPop: false,
      child: Scaffold(
        appBar: PreferredSize(
          preferredSize: const Size.fromHeight(80),
          child: HomeAppBar(
            titles: 'Designer DashBoard',
            backColor: const Color(0xFFA1EEBD),
            userRole: 'designer',
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
                gradientColors: const LinearGradient(
                  colors: [
                    Color(0xFFA1EEBD),
                    Color(0xFFF6F7C4),
                  ],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Welcome Back',
                      style: TextStyle(
                          fontSize: 20,
                          fontWeight: FontWeight.bold,
                          color: Colors.black87),
                    ),
                    gapH8,
                    ElevatedButton(
                      onPressed: () {
                        showNotImplementedAlertDialog(context: context);
                      },
                      child: const Text('Jobs'),
                    ),
                  ],
                ),
              ),
              gapH12,
              Padding(
                padding: const EdgeInsets.all(12.0),
                child: GridView.count(
                    crossAxisCount: 2,
                    childAspectRatio: 1.5 / 1.2,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      GridCard(
                        iconName: FontAwesomeIcons.images,
                        title: 'Portfolio',
                        onPressed: () {
                          print('button pressed');
                          context.goNamed(AppRoute.designerPortfolio.name);
                        },
                      ),
                      GridCard(
                          iconName: FontAwesomeIcons.briefcase,
                          title: 'New Requests',
                          onPressed: () =>
                              context.pushNamed(AppRoute.newRequest.name)),
                      GridCard(
                        iconName: FontAwesomeIcons.listCheck,
                        title: 'Ongoing Projects',
                        onPressed: () =>
                            showNotImplementedAlertDialog(context: context),
                      ),
                      GridCard(
                          iconName: FontAwesomeIcons.comments,
                          title: 'Messages',
                          onPressed: () => context.goNamed(
                                AppRoute.chatScreen.name,
                              )),
                      GridCard(
                        iconName: FontAwesomeIcons.paperPlane,
                        title: 'Offers Sent',
                        onPressed: () =>
                            showNotImplementedAlertDialog(context: context),
                      ),
                      GridCard(
                        iconName: FontAwesomeIcons.circleCheck,
                        title: 'Completed Projects',
                        onPressed: () =>
                            showNotImplementedAlertDialog(context: context),
                      ),
                      GridCard(
                        iconName: FontAwesomeIcons.wallet,
                        title: 'Payments',
                        onPressed: () =>
                            showNotImplementedAlertDialog(context: context),
                      ),
                      GridCard(
                        iconName: FontAwesomeIcons.userPen,
                        title: 'Update Profile',
                        onPressed: () =>
                            showNotImplementedAlertDialog(context: context),
                      ),
                    ]),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
