import 'package:go_router/go_router.dart';

import 'package:home_front_pk/src/features/welcome/presentation/welcome_screen.dart';

enum AppRoute {
  welcome, // Welcome/Sign In screen for all users
  signUpClient, // Sign Up screen for clients
  signUpConstructor, // Sign Up screen for constructors
  signUpDesigner, // Sign Up screen for designers
  clientDashboard, // Dashboard screen for clients
  designerDashboard, // Dashboard screen for designers
  constructorDashboard, // Dashboard screen for constructors
  serviceDetail, // Details for a specific service
  costCalculator, // Calculator for estimating service costs
  profile, // Profile screen (common for all users, with specific sections based on role)
  jobApplications, // For constructors/designers to manage job applications
  projectManagement, // For managing ongoing projects (clients and designers)
  history, // History of jobs/services
  settings, // Settings and app preferences
  helpSupport, // Help and support section
  mapScreen, // Map screen for selecting and viewing service locations
  notifications, // Notifications list
  messages, // Messaging/chat screen
  payment, // Payment and transaction management
  viewPortfolio, // For designers to display their work
  submitBid, // For constructors to submit bids on projects
  schedule, // Calendar or schedule of upcoming projects for constructors
}

final goRouter = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: '/',
      name: AppRoute.welcome.name,
      builder: (context, state) => const WelcomeScreen(),
      // routes: [
      //   GoRoute(
      //     path: 'sign-up-client',
      //     name: AppRoute.signUpClient.name,
      //     pageBuilder: (context, state) => MaterialPage(
      //       fullscreenDialog: true,
      //       child: SignUpClientScreen(),
      //     ),
      //     routes: [
      //       GoRoute(
      //         path: 'client-dashboard',
      //         name: AppRoute.clientDashboard.name,
      //         pageBuilder: (context, state) => MaterialPage(
      //           fullscreenDialog: true,
      //           child: ClientDashboard(),
      //         ),
      //         routes: [
      //           GoRoute(
      //             path: 'service-detail',
      //             name: AppRoute.serviceDetail.name,
      //             pageBuilder: (context, state) => MaterialPage(
      //               fullscreenDialog: true,
      //               child: ServiceDetailScreen(),
      //             ),
      //           ),
      //           GoRoute(
      //             path: 'cost-calculator',
      //             name: AppRoute.costCalculator.name,
      //             pageBuilder: (context, state) => MaterialPage(
      //               fullscreenDialog: true,
      //               child: CostCalculatorScreen(),
      //             ),
      //           ),
      //           GoRoute(
      //             path: 'project-mangement',
      //             name: AppRoute.projectManagement.name,
      //             pageBuilder: (context, state) => MaterialPage(
      //               fullscreenDialog: true,
      //               child: ProjectMangementScreen(),
      //             ),
      //           ),
      //           GoRoute(
      //             path: 'profile',
      //             name: AppRoute.profile.name,
      //             pageBuilder: (context, state) => MaterialPage(
      //               fullscreenDialog: true,
      //               child: ProfileScreen(),
      //             ),
      //             routes: [
      //               GoRoute(
      //                 path: 'history',
      //                 name: AppRoute.history.name,
      //                 pageBuilder: (context, state) => MaterialPage(
      //                   fullscreenDialog: true,
      //                   child: HistoryScreen(),
      //                 ),
      //               ),
      //               GoRoute(
      //                 path: 'setting',
      //                 name: AppRoute.settings.name,
      //                 pageBuilder: (context, state) => MaterialPage(
      //                   fullscreenDialog: true,
      //                   child: SettingScreen(),
      //                 ),
      //               ),
      //             ],
      //           ),
      //         ],
      //       ),
      //     ],
      //   ),
      //   GoRoute(
      //     path: 'sign-up-constructor',
      //     name: AppRoute.signUpConstructor.name,
      //     pageBuilder: (context, state) => MaterialPage(
      //       fullscreenDialog: true,
      //       child: SignUpConstructorScreen(),
      //     ),
      //     routes: [
      //       GoRoute(
      //         path: 'constructor-dashboard',
      //         name: AppRoute.constructorDashboard.name,
      //         pageBuilder: (context, state) => MaterialPage(
      //           fullscreenDialog: true,
      //           child: ConstructorDashboard(),
      //         ),
      //       ),
      //     ],
      //   ),
      //   GoRoute(
      //     path: 'sign-up-designer',
      //     name: AppRoute.signUpDesigner.name,
      //     pageBuilder: (context, state) => MaterialPage(
      //       fullscreenDialog: true,
      //       child: SignUpDesignerScreen(),
      //     ),
      //   ),
      // ],
    ),
  ],
);
