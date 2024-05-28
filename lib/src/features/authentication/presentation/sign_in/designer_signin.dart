import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:home_front_pk/src/common_widgets/circular_image.dart';
import 'package:home_front_pk/src/common_widgets/custom_sigin.dart';
import 'package:home_front_pk/src/common_widgets/responsive_scrollable_card.dart';
import 'package:home_front_pk/src/constants/app_sizes.dart';
import 'package:home_front_pk/src/features/authentication/presentation/shared/email_password_sign_in_controller.dart';
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
  void _handleFormSubmit(String email, String password) {
    // Handle the form submission, e.g., authenticate and navigate
    print('Email: $email, Password: $password');
    // Example: Navigator.of(context).pushReplacementNamed('/clientDashboard');
    context.goNamed(AppRoute.designerDashboard.name);
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
        signInText: 'Designer',
        onFormSubmit: _handleFormSubmit,
      ),
      signUp: () {
        context.goNamed(
          AppRoute.signUpDesigner.name,
        );
      },
    );
  }
}
