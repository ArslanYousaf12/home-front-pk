import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:home_front_pk/src/analytics/presentation/analytics_dashboard.dart';
import 'package:home_front_pk/src/common_widgets/alert_dialogs.dart';
import 'package:home_front_pk/src/constants/app_sizes.dart';
import 'package:home_front_pk/src/constructor_apply_job/presentation/constructor_job_screen.dart';
import 'package:home_front_pk/src/features/authentication/presentation/account/account_screen_controller.dart';
import 'package:home_front_pk/src/features/ongoing_project/presentation/ongoing_screen.dart';
import 'package:home_front_pk/src/features/profile/presentation/profile_screen.dart';
import 'package:home_front_pk/src/localization/string_hardcoded.dart';
import 'package:home_front_pk/src/offer_sent/presentation/new_request.dart';
import 'package:home_front_pk/src/payment_module/presentation/wallet_screen.dart';
import 'package:home_front_pk/src/profile_dashboard/presentation/profile_screen.dart';
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
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.grey[100],
        body: CustomScrollView(
          slivers: [
            // Modern App Bar
            SliverAppBar(
              expandedHeight: 200.0,
              floating: false,
              pinned: true,
              elevation: 0,
              automaticallyImplyLeading: false,
              backgroundColor: Colors.transparent,
              flexibleSpace: FlexibleSpaceBar(
                background: Container(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      colors: [
                        Colors.amber.shade100,
                        const Color(0xFFF6F7C4),
                      ],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                  ),
                  child: SafeArea(
                    child: Padding(
                      padding: const EdgeInsets.all(20.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              const Text(
                                'Constructor Dashboard',
                                style: TextStyle(
                                  fontSize: 18,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.black87,
                                ),
                              ),
                              Row(
                                children: [
                                  IconButton(
                                    icon: const Icon(
                                        Icons.notifications_outlined),
                                    onPressed: () => context
                                        .goNamed(AppRoute.chatScreen.name),
                                  ),
                                  IconButton(
                                    icon: const Icon(Icons.logout),
                                    onPressed: () => _handleLogout(context),
                                  ),
                                ],
                              ),
                            ],
                          ),
                          const Spacer(),
                          const Text(
                            'Welcome Back',
                            style: TextStyle(
                              color: Colors.black87,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          gapH12,
                          ElevatedButton.icon(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) =>
                                      const ConstructorJobsScreen(),
                                ),
                              );
                            },
                            icon: const Icon(Icons.search),
                            label: const Text('Find Jobs'),
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.black87,
                              foregroundColor: Colors.white,
                              padding: const EdgeInsets.symmetric(
                                horizontal: 24,
                                vertical: 12,
                              ),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),

            // Dashboard Grid
            SliverPadding(
              padding: const EdgeInsets.all(16.0),
              sliver: SliverGrid(
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 1.1,
                  mainAxisSpacing: 16.0,
                  crossAxisSpacing: 16.0,
                ),
                delegate: SliverChildListDelegate([
                  _buildModernGridCard(
                    icon: FontAwesomeIcons.images,
                    title: 'Portfolio',
                    subtitle: 'Showcase your work',
                    onTap: () =>
                        context.goNamed(AppRoute.constructorPortfolio.name),
                  ),
                  _buildModernGridCard(
                    icon: FontAwesomeIcons.briefcase,
                    title: 'New Requests',
                    subtitle: 'View new job requests',
                    onTap: () => context.goNamed(AppRoute.newRequest.name),
                  ),
                  _buildModernGridCard(
                    icon: FontAwesomeIcons.listCheck,
                    title: 'Ongoing Projects',
                    subtitle: 'Track your projects',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const OngoingProjectsScreen(),
                      ),
                    ),
                  ),
                  _buildModernGridCard(
                    icon: FontAwesomeIcons.comments,
                    title: 'Messages',
                    subtitle: 'Chat with clients',
                    onTap: () => context.goNamed(AppRoute.chatScreen.name),
                  ),
                  _buildModernGridCard(
                    icon: FontAwesomeIcons.paperPlane,
                    title: 'Offers Sent',
                    subtitle: 'Track your proposals',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const NewRequestScreen(),
                      ),
                    ),
                  ),
                  _buildModernGridCard(
                    icon: FontAwesomeIcons.wallet,
                    title: 'Payments',
                    subtitle: 'Manage transactions',
                    onTap: () => Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const WalletScreen()),
                    ),
                  ),
                  _buildModernGridCard(
                      icon: FontAwesomeIcons.chartLine,
                      title: 'Analytics',
                      subtitle: 'View insights',
                      onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AnalyticsDashboard(
                                  userType: 'constructor'),
                            ),
                          )),
                  _buildModernGridCard(
                      icon: FontAwesomeIcons.userPen,
                      title: 'Profile',
                      subtitle: 'Update details',
                      onTap: () => Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ProfileScreenNew(
                                userType: 'constructor', // or 'designer'
                              ),
                            ),
                          )),
                ]),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildModernGridCard({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: BorderSide(
          color: Colors.grey.shade200,
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: LinearGradient(
              colors: [
                Colors.white,
                Colors.grey.shade50,
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Container(
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: Colors.amber.shade50,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: FaIcon(
                  icon,
                  color: Colors.black87,
                  size: 24,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: Colors.black87,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: TextStyle(
                  fontSize: 12,
                  color: Colors.grey.shade600,
                ),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _handleLogout(BuildContext context) async {
    final logout = await showAlertDialog(
      context: context,
      title: 'Are you sure?'.hardcoded,
      cancelActionText: 'Cancel'.hardcoded,
      defaultActionText: 'Logout'.hardcoded,
    );

    if (logout == true) {
      final success =
          await ref.read(accountScreenControllerProvider.notifier).signOut();
      if (success && mounted) {
        context.pop();
      }
    }
  }
}
