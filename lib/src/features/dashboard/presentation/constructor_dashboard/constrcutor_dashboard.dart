// lib/src/features/dashboard/presentation/constructor_dashboard.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:home_front_pk/src/features/analytics/presentation/analytics_dashboard.dart';
import 'package:home_front_pk/src/common_widgets/alert_dialogs.dart';
import 'package:home_front_pk/src/constants/app_colors.dart';
import 'package:home_front_pk/src/constants/app_sizes.dart';
import 'package:home_front_pk/src/features/constructor_apply_job/presentation/constructor_job_screen.dart';
import 'package:home_front_pk/src/features/authentication/presentation/account/account_screen_controller.dart';
import 'package:home_front_pk/src/features/ongoing_project/presentation/ongoing_screen.dart';
import 'package:home_front_pk/src/localization/string_hardcoded.dart';
import 'package:home_front_pk/src/features/offer_sent/presentation/new_request.dart';
import 'package:home_front_pk/src/features/payment_module/presentation/wallet_screen.dart';
import 'package:home_front_pk/src/features/profile_dashboard/presentation/profile_screen.dart';
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
        backgroundColor: AppColors.kBackgroundColor,
        body: CustomScrollView(
          slivers: [
            _buildAppBar(),
            _buildDashboardGrid(),
          ],
        ),
      ),
    );
  }

  Widget _buildAppBar() {
    return SliverAppBar(
      expandedHeight: 200.0,
      floating: false,
      pinned: true,
      elevation: 0,
      automaticallyImplyLeading: false,
      backgroundColor: Colors.transparent,
      flexibleSpace: FlexibleSpaceBar(
        background: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              colors: [
                AppColors.kPrimaryColor,
                AppColors.kSecondaryColor,
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
                  _buildAppBarHeader(),
                  const Spacer(),
                  _buildWelcomeSection(),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppBarHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text(
          'Constructor Dashboard',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: AppColors.kTextDarkColor,
          ),
        ),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.notifications_outlined),
              onPressed: () => context.goNamed(AppRoute.chatScreen.name),
              color: AppColors.kTextDarkColor,
            ),
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () => _handleLogout(context),
              color: AppColors.kTextDarkColor,
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildWelcomeSection() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Welcome Back',
          style: TextStyle(
            color: AppColors.kTextDarkColor,
            fontSize: 28,
            fontWeight: FontWeight.bold,
          ),
        ),
        gapH12,
        ElevatedButton.icon(
          onPressed: () => Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const ConstructorJobsScreen(),
            ),
          ),
          icon: const Icon(Icons.search),
          label: const Text('Find Jobs'),
          style: ElevatedButton.styleFrom(
            backgroundColor: AppColors.kAccentColor,
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
    );
  }

  Widget _buildDashboardGrid() {
    return SliverPadding(
      padding: const EdgeInsets.all(16.0),
      sliver: SliverGrid(
        gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          childAspectRatio: 1.1,
          mainAxisSpacing: 16.0,
          crossAxisSpacing: 16.0,
        ),
        delegate: SliverChildListDelegate([
          _buildDashboardItem(
            icon: FontAwesomeIcons.images,
            title: 'Portfolio',
            subtitle: 'Showcase your work',
            onTap: () => context.goNamed(AppRoute.constructorPortfolio.name),
          ),
          _buildDashboardItem(
            icon: FontAwesomeIcons.briefcase,
            title: 'New Requests',
            subtitle: 'View new job requests',
            onTap: () => context.goNamed(AppRoute.newRequest.name),
          ),
          _buildDashboardItem(
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
          _buildDashboardItem(
            icon: FontAwesomeIcons.comments,
            title: 'Messages',
            subtitle: 'Chat with clients',
            onTap: () => context.goNamed(AppRoute.chatScreen.name),
          ),
          _buildDashboardItem(
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
          _buildDashboardItem(
            icon: FontAwesomeIcons.wallet,
            title: 'Payments',
            subtitle: 'Manage transactions',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const WalletScreen(),
              ),
            ),
          ),
          _buildDashboardItem(
            icon: FontAwesomeIcons.chartLine,
            title: 'Analytics',
            subtitle: 'View insights',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const AnalyticsDashboard(
                  userType: 'constructor',
                ),
              ),
            ),
          ),
          _buildDashboardItem(
            icon: FontAwesomeIcons.userPen,
            title: 'Profile',
            subtitle: 'Update details',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ProfileScreenNew(
                  userType: 'constructor',
                ),
              ),
            ),
          ),
        ]),
      ),
    );
  }

  Widget _buildDashboardItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required VoidCallback onTap,
  }) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
        side: const BorderSide(
          color: Colors.transparent,
          width: 1,
        ),
      ),
      child: InkWell(
        onTap: onTap,
        borderRadius: BorderRadius.circular(20),
        child: Container(
          padding: const EdgeInsets.all(16),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [
                Colors.white,
                AppColors.kBackgroundColor,
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
                  color: AppColors.kPrimaryColor.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: FaIcon(
                  icon,
                  color: AppColors.kTextDarkColor,
                  size: 24,
                ),
              ),
              const SizedBox(height: 12),
              Text(
                title,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.bold,
                  color: AppColors.kTextDarkColor,
                ),
                textAlign: TextAlign.center,
              ),
              const SizedBox(height: 4),
              Text(
                subtitle,
                style: const TextStyle(
                  fontSize: 12,
                  color: AppColors.kTextMediumColor,
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
