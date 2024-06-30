import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:home_front_pk/src/common_widgets/custom_sigin.dart';
import 'package:home_front_pk/src/features/authentication/presentation/shared/email_password_sign_in_controller.dart';
import 'package:home_front_pk/src/features/authentication/presentation/sign_in/email_password_sign_in_state.dart';
import 'package:home_front_pk/src/features/authentication/presentation/sign_in/sign_in.dart';
import 'package:home_front_pk/src/routing/app_router.dart';
import 'package:home_front_pk/src/utils/async_value_ui.dart';

class ConstructorSignIn extends ConsumerStatefulWidget {
  const ConstructorSignIn({super.key});

  @override
  ConsumerState<ConstructorSignIn> createState() => _ConstructorSignInState();
}

class _ConstructorSignInState extends ConsumerState<ConstructorSignIn> {
  void _handleFormSubmit(String email, String password) {
    // Handle the form submission, e.g., authenticate and navigate
    print('Email: $email, Password: $password');
    // Example: Navigator.of(context).pushReplacementNamed('/clientDashboard');
    context.goNamed(AppRoute.constructorDashboard.name);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(
      emailPasswordSignInControllerProvider(EmailPasswordSignInFormType.signIn)
          .select((state) => state.value),
      (_, state) => state.showAlertDialogOnError(context),
    );
    return SignInScreen(
      topText: 'Constructor Login',
      signInForm: SignInForm(
        //TODO: remove and check sigin Text
        signInText: 'Constructor',
        onFormSubmit: _handleFormSubmit,
      ),
      signUp: () {
        context.goNamed(
          AppRoute.signUpConstructor.name,
        );
      },
    );
  }
}
