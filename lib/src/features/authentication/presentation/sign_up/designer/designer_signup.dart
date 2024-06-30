import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:home_front_pk/src/features/authentication/presentation/sign_up/signup_form.dart';
import 'package:home_front_pk/src/features/authentication/presentation/sign_up/signup_screen.dart';
import 'package:home_front_pk/src/routing/app_router.dart';

class DesignerSignUp extends StatelessWidget {
  const DesignerSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SignUpScreen(
        topText: 'Designer Account',
        signUpform: SignUpForm(
            role: 'designer',
            onFormSubmit: (email, password) => context.goNamed(
                  AppRoute.designerDashboard.name,
                )),
      ),
    );
  }
}
