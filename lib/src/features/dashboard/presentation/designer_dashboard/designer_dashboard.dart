import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:go_router/go_router.dart';
import 'package:home_front_pk/src/features/analytics/presentation/analytics_dashboard.dart';
import 'package:home_front_pk/src/common_widgets/alert_dialogs.dart';
import 'package:home_front_pk/src/common_widgets/cutome_curved_container.dart';
import 'package:home_front_pk/src/common_widgets/grid_card.dart';
import 'package:home_front_pk/src/common_widgets/home_app_bar.dart';
import 'package:home_front_pk/src/constants/app_sizes.dart';
import 'package:home_front_pk/src/features/constructor_apply_job/presentation/constructor_job_screen.dart';
import 'package:home_front_pk/src/features/authentication/presentation/account/account_screen_controller.dart';
import 'package:home_front_pk/src/features/chat_section/presentation/chat_screen.dart';
import 'package:home_front_pk/src/features/ongoing_project/presentation/ongoing_screen.dart';
import 'package:home_front_pk/src/localization/string_hardcoded.dart';
import 'package:home_front_pk/src/features/offer_sent/presentation/new_request.dart';
import 'package:home_front_pk/src/features/payment_module/presentation/wallet_screen.dart';
import 'package:home_front_pk/src/features/profile_dashboard/presentation/profile_screen.dart';
import 'package:home_front_pk/src/routing/app_router.dart';

class DesignerDashboard extends ConsumerStatefulWidget {
  const DesignerDashboard({super.key});

  @override
  ConsumerState<DesignerDashboard> createState() => _DesignerDashboardState();
}

class _DesignerDashboardState extends ConsumerState<DesignerDashboard> {
  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.grey[100],
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
                Color(0xFFA1EEBD), // Your existing green color
                Color(0xFFF6F7C4), // Your existing light color
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
          'Designer Dashboard',
          style: TextStyle(
            fontSize: 18,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        Row(
          children: [
            IconButton(
              icon: const Icon(Icons.notifications_outlined),
              onPressed: () => context.goNamed(AppRoute.chatScreen.name),
              color: Colors.black87,
            ),
            IconButton(
              icon: const Icon(Icons.logout),
              onPressed: () => _handleLogout(context),
              color: Colors.black87,
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
            color: Colors.black87,
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
          label: const Text('Find Design Projects'),
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
          _buildModernGridCard(
            icon: FontAwesomeIcons.images,
            title: 'Portfolio',
            subtitle: 'Showcase your designs',
            onTap: () => context.goNamed(AppRoute.designerPortfolio.name),
          ),
          _buildModernGridCard(
            icon: FontAwesomeIcons.briefcase,
            title: 'New Requests',
            subtitle: 'View design requests',
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const ConstructorJobsScreen(),
              ),
            ),
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
              icon: FontAwesomeIcons.circleCheck,
              title: 'Analytics',
              subtitle: 'View Analytics reports',
              onTap: () => // For Designer
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          const AnalyticsDashboard(userType: 'designer'),
                    ),
                  )),
          _buildModernGridCard(
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
          _buildModernGridCard(
              icon: FontAwesomeIcons.userPen,
              title: 'Update Profile',
              subtitle: 'Modify your details',
              onTap: () => Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ProfileScreenNew(
                        userType: 'designer', // or 'designer'
                      ),
                    ),
                  )),
        ]),
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
                  color: const Color(0xFFA1EEBD).withOpacity(0.2),
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
    final goRouter = GoRouter.of(context);
    final logout = await showAlertDialog(
      context: context,
      title: 'Are you sure?'.hardcoded,
      cancelActionText: 'Cancel'.hardcoded,
      defaultActionText: 'Logout'.hardcoded,
    );
    if (logout == true) {
      final success =
          await ref.read(accountScreenControllerProvider.notifier).signOut();
      if (success) {
        goRouter.pop();
      }
    }
  }
}
