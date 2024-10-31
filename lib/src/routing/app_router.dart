import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:home_front_pk/src/features/authentication/data/auth_repository.dart';
import 'package:home_front_pk/src/features/authentication/presentation/account/account_screen.dart';
import 'package:home_front_pk/src/features/authentication/presentation/sign_in/client_signin.dart';
import 'package:home_front_pk/src/features/authentication/presentation/sign_in/constructor_signin.dart';
import 'package:home_front_pk/src/features/authentication/presentation/sign_in/designer_signin.dart';
import 'package:home_front_pk/src/features/authentication/presentation/sign_up/client/client_signup.dart';
import 'package:home_front_pk/src/features/authentication/presentation/sign_up/constructor/constructor_signup.dart';
import 'package:home_front_pk/src/features/authentication/presentation/sign_up/designer/designer_signup.dart';
import 'package:home_front_pk/src/features/chat_section/presentation/chat_screen.dart';
import 'package:home_front_pk/src/features/cost_calculator/presentation/CostBreakGraphdownScreen.dart';
import 'package:home_front_pk/src/features/cost_calculator/presentation/cost_breakdown_screen.dart';

import 'package:home_front_pk/src/features/dashboard/presentation/client_dashboard/constructors.dart/constructor_detailed.dart';
import 'package:home_front_pk/src/features/dashboard/presentation/client_dashboard/designers_list/deigner_list_screen.dart';
import 'package:home_front_pk/src/features/dashboard/presentation/client_dashboard/designers_list/designer_detailed.dart';
import 'package:home_front_pk/src/features/dashboard/presentation/client_dashboard/tabs.dart';
import 'package:home_front_pk/src/features/dashboard/presentation/constructor_dashboard/constrcutor_dashboard.dart';
import 'package:home_front_pk/src/features/dashboard/presentation/designer_dashboard/designer_dashboard.dart';

import 'package:home_front_pk/src/features/new_requests/presentation/new_request.dart';
import 'package:home_front_pk/src/features/portfolio/presentation/constructor_portfolio.dart';
import 'package:home_front_pk/src/features/portfolio/presentation/designer_portfolio.dart';

import 'package:home_front_pk/src/features/user-management/presentation/admin_product_edit_screen.dart';
import 'package:home_front_pk/src/features/user-management/presentation/admin_product_upload_screen.dart';
import 'package:home_front_pk/src/features/user-management/presentation/admin_products_add_screen.dart';
import 'package:home_front_pk/src/features/user-management/presentation/admin_products_screen.dart';
import 'package:home_front_pk/src/features/user_job_post/domain/job_post_model.dart';
import 'package:home_front_pk/src/features/user_job_post/presentation/job_post_screen.dart';
import 'package:home_front_pk/src/features/user_job_post/presentation/user_jobs_screen.dart';
import 'package:home_front_pk/src/features/welcome/presentation/seller_screen.dart';
import 'package:home_front_pk/src/features/welcome/presentation/welcome_screen.dart';

enum AppRoute {
  welcome, // Welcome/Sign In screen for all users

  signInClient,
  signInDesigner,
  signInConstructor,
  seller,
  signUpClient,
  signUpConstructor, // Sign Up screen for constructors
  signUpDesigner, // Sign Up screen for designers
  clientTabs,
  costBreakDownGraph,
  costBreakDownScreen,
  admin,
  adminAdd,
  chatScreen,
  adminUploadProduct,
  adminEditProduct,
  clientDashboard, // Dashboard screen for clients
  clientAccount,
  clientMessage,
  createJobPost,
  userJobs,
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
  newRequest,
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

final routerProvider = Provider<GoRouter>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return GoRouter(initialLocation: '/', debugLogDiagnostics: true, routes: [
    GoRoute(
      path: '/',
      name: AppRoute.welcome.name,
      builder: (context, state) => WelcomeScreen(),
      routes: [
        GoRoute(
            path: 'chat',
            name: AppRoute.chatScreen.name,
            builder: (context, state) {
              return ChatScreen();
            }),
        GoRoute(
          path: 'admin',
          name: AppRoute.admin.name,
          pageBuilder: (context, state) => const MaterialPage(
            fullscreenDialog: true,
            child: AdminProductsScreen(),
          ),
          routes: [
            GoRoute(
              path: 'add',
              name: AppRoute.adminAdd.name,
              pageBuilder: (context, state) => const MaterialPage(
                fullscreenDialog: true,
                child: AdminProductsAddScreen(),
              ),
              routes: [
                GoRoute(
                  path: ':id',
                  name: AppRoute.adminUploadProduct.name,
                  builder: (context, state) {
                    final productId = state.pathParameters['id']!;
                    return AdminProductUploadScreen(productId: productId);
                  },
                ),
              ],
            ),
            GoRoute(
              path: 'edit/:id',
              name: AppRoute.adminEditProduct.name,
              pageBuilder: (context, state) {
                final productId = state.pathParameters['id']!;
                return MaterialPage(
                  fullscreenDialog: true,
                  child: AdminProductEditScreen(constructorID: productId),
                );
              },
            ),
          ],
        ),
        GoRoute(
          path: 'seller',
          name: AppRoute.seller.name,
          builder: (context, state) => const SellerScreen(),
        ),
        GoRoute(
            path: 'new-request',
            name: AppRoute.newRequest.name,
            builder: (context, state) {
              return const NewRequest();
            }),
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
                  builder: (context, state) => const UserTabScreen(),
                  routes: [
                    GoRoute(
                      path: 'cost-break-down',
                      name: AppRoute.costBreakDownScreen.name,
                      builder: (context, state) {
                        final area = double.parse(state.extra as String);
                        debugPrint('Area: $area');
                        return CostBreakdownScreen(area: area);
                      },
                    ),
                    GoRoute(
                      path: 'user-job-post',
                      name: AppRoute.createJobPost.name,
                      builder: (context, state) {
                        return const CreateJobPostScreen();
                      },
                    ),
                    GoRoute(
                      path: 'user-jobs',
                      name: AppRoute.userJobs.name,
                      builder: (context, state) {
                        return const UserJobsScreen();
                      },
                    ),
                    GoRoute(
                      path: 'cost-break-down-graph',
                      name: AppRoute.costBreakDownGraph.name,
                      builder: (context, state) {
                        final area = double.parse(state.extra as String);
                        debugPrint('Area: $area');
                        return CostBreakdownGraphScreen(area: area);
                      },
                    ),
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
                name: AppRoute.signUpClient.name,
                builder: (context, state) => const ClientSignUp(),
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
});
