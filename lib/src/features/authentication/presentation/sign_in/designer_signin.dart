import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:home_front_pk/src/common_widgets/alert_dialogs.dart';
import 'package:home_front_pk/src/common_widgets/custom_sigin.dart';
import 'package:home_front_pk/src/features/authentication/data/auth_repository.dart';
import 'package:home_front_pk/src/features/authentication/presentation/shared/email_password_sign_in_controller.dart';
import 'package:home_front_pk/src/features/authentication/presentation/shared/google_signIn_controller.dart';
import 'package:home_front_pk/src/features/authentication/presentation/sign_in/email_password_sign_in_state.dart';
import 'package:home_front_pk/src/features/authentication/presentation/sign_in/sign_in.dart';

import 'package:home_front_pk/src/routing/app_router.dart';
import 'package:home_front_pk/src/utils/async_value_ui.dart';

class DesignerSignIn extends ConsumerStatefulWidget {
  const DesignerSignIn({super.key});

  @override
  ConsumerState<DesignerSignIn> createState() => _DesignerSignInState();
}

class _DesignerSignInState extends ConsumerState<DesignerSignIn> {
  void _handleFormSubmit(String email, String password) async {
    // Handle the form submission, e.g., authenticate and navigate
    print('Email: $email, Password: $password');
    final authRepo = ref.read(authRepositoryProvider);
    final user = authRepo.currentUser;
    final userRole = await authRepo.getUserRole(user!.uid);
    if (userRole == 'designer') {
      context.goNamed(AppRoute.designerDashboard.name);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Wrong Email or Password')));
    }
    // final userRole = ref.watch(userRoleProvider);
    // print(userRole.value);
    // userRole.when(
    //   data: (value) {
    //     if (value == 'designer') {
    //       context.goNamed(AppRoute.designerDashboard.name);
    //     }
    //   },
    //   error: (error, stackTrace) => showExceptionAlertDialog(
    //       context: context, title: 'Error', exception: error),
    //   loading: () => const Center(
    //     child: CircularProgressIndicator(),
    //   ),
    // );
    // if (userRole.value != 'designer') {
    //   ScaffoldMessenger.of(context)
    //       .showSnackBar(SnackBar(content: Text('Wrong Email or Password')));
    // }

    // Example: Navigator.of(context).pushReplacementNamed('/clientDashboard');

    // Example: Navigator.of(context).pushReplacementNamed('/clientDashboard');
    // context.goNamed(AppRoute.designerDashboard.name);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(
      emailPasswordSignInControllerProvider(EmailPasswordSignInFormType.signIn)
          .select((state) => state.value),
      (_, state) => state.showAlertDialogOnError(context),
    );
    return SignInScreen(
      topText: 'Designer Login',
      signInForm: SignInForm(
        role: 'designer',
        signInText: 'Designer',
        onFormSubmit: _handleFormSubmit,
      ),
      signUp: () {
        context.goNamed(
          AppRoute.signUpDesigner.name,
        );
      },
      googleSignIn: () async {
        final sucess = await ref
            .read(googleSigninControllerProvider.notifier)
            .signInWithGoogle();
        if (sucess) {
          context.goNamed(AppRoute.designerDashboard.name);
        }
      },
    );
  }
}
