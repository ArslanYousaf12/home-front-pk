import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:home_front_pk/src/common_widgets/action_load_button.dart';
import 'package:home_front_pk/src/features/authentication/presentation/account/account_screen.dart';
import 'package:home_front_pk/src/features/authentication/presentation/sign_in/client_signin.dart';
import 'package:home_front_pk/src/features/authentication/presentation/sign_in/constructor_signin.dart';
import 'package:home_front_pk/src/features/authentication/presentation/sign_in/designer_signin.dart';
import 'package:home_front_pk/src/features/authentication/presentation/sign_up/client/client_signup_first.dart';
import 'package:home_front_pk/src/features/authentication/presentation/sign_up/client/client_signup_second.dart';
import 'package:home_front_pk/src/features/authentication/presentation/sign_up/constructor/constructor_signup.dart';
import 'package:home_front_pk/src/features/authentication/presentation/sign_up/designer/designer_signup.dart';
import 'package:home_front_pk/src/features/dashboard/presentation/client_dashboard/client_dashboard.dart';
import 'package:home_front_pk/src/features/dashboard/presentation/client_dashboard/constructors.dart/constructor_detailed.dart';
import 'package:home_front_pk/src/features/dashboard/presentation/client_dashboard/designers_list/deigner_list_screen.dart';
import 'package:home_front_pk/src/features/dashboard/presentation/client_dashboard/designers_list/designer_detailed.dart';
import 'package:home_front_pk/src/features/dashboard/presentation/constructor_dashboard/constrcutor_dashboard.dart';
import 'package:home_front_pk/src/features/dashboard/presentation/designer_dashboard/designer_dashboard.dart';
import 'package:home_front_pk/src/features/portfolio/presentation/constructor_portfolio.dart';
import 'package:home_front_pk/src/features/portfolio/presentation/designer_portfolio.dart';
import 'package:home_front_pk/src/features/welcome/presentation/welcome_screen.dart';

enum AppRoute {
  welcome, // Welcome/Sign In screen for all users

  signInClient,
  signInDesigner,
  signInConstructor,
  signUpClientFirst, // Sign Up screen for clients
  signUpClientSecond,
  signUpConstructor, // Sign Up screen for constructors
  signUpDesigner, // Sign Up screen for designers
  clientDashboard, // Dashboard screen for clients
  clientAccount,
  clientMessage,
  constructorDetailed,
  designerList,
  designerDetailed,
  designerDashboard, // Dashboard screen for designers
  designerAccount,
  designerPortfolio,
  designerMessage,
  constructorDashboard, // Dashboard screen for constructors
  constructorAccount,
  constructorPortfolio,
  constructorMessage,
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

final goRouter =
    GoRouter(initialLocation: '/', debugLogDiagnostics: true, routes: [
  GoRoute(
    path: '/',
    name: AppRoute.welcome.name,
    builder: (context, state) => const WelcomeScreen(),
    routes: [
      GoRoute(
          path: 'sign-In-client',
          name: AppRoute.signInClient.name,
          pageBuilder: (context, state) => const MaterialPage(
                fullscreenDialog: false,
                child: ClientSignInScreen(),
              ),
          routes: [
            GoRoute(
                path: 'client-dashboard',
                name: AppRoute.clientDashboard.name,
                builder: (context, state) => const ClientDashboard(),
                routes: [
                  GoRoute(
                    path: 'account',
                    name: AppRoute.clientAccount.name,
                    builder: (context, state) => const AccountScreen(),
                  ),
                  GoRoute(
                    path: 'constructor-detailed-screen/:id',
                    name: AppRoute.constructorDetailed.name,
                    builder: (context, state) {
                      final constructorId = state.pathParameters['id']!;
                      return ConstructorDetailedScreen(
                          constructorId: constructorId);
                    },
                  ),
                  GoRoute(
                      path: 'designer-list',
                      name: AppRoute.designerList.name,
                      builder: (context, state) => const DesignerListScreen(),
                      routes: [
                        GoRoute(
                            path: 'designer-detailed-screen/:id',
                            name: AppRoute.designerDetailed.name,
                            builder: (context, state) {
                              final designerId = state.pathParameters['id']!;
                              return DesignerDetailedScreen(
                                  designerId: designerId);
                            }),
                      ])
                ]),
            GoRoute(
              path: 'sign-up-client',
              name: AppRoute.signUpClientFirst.name,
              builder: (context, state) => const ClientSignUp(),
              routes: [
                GoRoute(
                  path: 'sign-up-client-second',
                  name: AppRoute.signUpClientSecond.name,
                  builder: (context, state) => const ClientSignUpSecond(),
                ),
              ],
            ),
          ]),
      GoRoute(
        path: 'sign-in-constructor',
        name: AppRoute.signInConstructor.name,
        pageBuilder: (context, state) => const MaterialPage(
          fullscreenDialog: false,
          child: ConstructorSignIn(),
        ),
        routes: [
          GoRoute(
              path: 'constructor-dashboard',
              name: AppRoute.constructorDashboard.name,
              builder: (context, state) => const ConstructorDashboard(),
              routes: [
                GoRoute(
                  path: 'constructor-account',
                  name: AppRoute.constructorAccount.name,
                  builder: (context, state) => const AccountScreen(),
                ),
                GoRoute(
                  path: 'constructor-portfolio',
                  name: AppRoute.constructorPortfolio.name,
                  builder: (context, state) => const ConstructorPortfolio(),
                ),
              ]),
          GoRoute(
            path: 'sign-up-constructor',
            name: AppRoute.signUpConstructor.name,
            builder: (context, state) => const ConstructorSignUp(),
          ),
        ],
      ),
      GoRoute(
        path: 'sign-in-designer',
        name: AppRoute.signInDesigner.name,
        pageBuilder: (context, state) => const MaterialPage(
          fullscreenDialog: false,
          child: DesignerSignIn(),
        ),
        routes: [
          GoRoute(
              path: 'designer-dashboard',
              name: AppRoute.designerDashboard.name,
              builder: (context, state) => const DesignerDashboard(),
              routes: [
                GoRoute(
                  path: 'designer-account',
                  name: AppRoute.designerAccount.name,
                  builder: (context, state) => const AccountScreen(),
                ),
                GoRoute(
                  path: 'designer-portfolio',
                  name: AppRoute.designerPortfolio.name,
                  builder: (context, state) => const DesignerPortfolio(),
                ),
              ]),
          GoRoute(
            path: 'sign-up-designer',
            name: AppRoute.signUpDesigner.name,
            builder: (context, state) => const DesignerSignUp(),
          ),
        ],
      ),
      // ],
      // ),
    ],
  )
]);
