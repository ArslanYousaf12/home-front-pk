import 'package:go_router/go_router.dart';

import 'package:home_front_pk/src/features/welcome/welcome_screen.dart';

enum AppRoute {
  welcome,
  signUpClient,
  signUpConstructor,
  signUpDesigner,
  signIn,
  home,
  searchServices,
  serviceDetail,
  costCalculator,
  clientProfile,
  constructorProfile,
  designerProfile,
  jobApplications,
  chat,
  projectManagement,
  payment,
  history,
  settings,
  helpSupport,
  mapScreen,
}

final goRouter = GoRouter(
  initialLocation: '/',
  debugLogDiagnostics: true,
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const WelcomeScreen(),
    ),
  ],
);
