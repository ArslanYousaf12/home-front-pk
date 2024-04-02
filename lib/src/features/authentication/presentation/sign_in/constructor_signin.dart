import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:home_front_pk/src/common_widgets/circular_image.dart';
import 'package:home_front_pk/src/common_widgets/custom_sigin.dart';
import 'package:home_front_pk/src/common_widgets/responsive_scrollable_card.dart';
import 'package:home_front_pk/src/constants/app_sizes.dart';
import 'package:home_front_pk/src/features/authentication/presentation/sign_in/email_password_sign_in_state.dart';
import 'package:home_front_pk/src/routing/app_router.dart';

class ConstructorSignIn extends StatefulWidget {
  const ConstructorSignIn({super.key});

  @override
  State<ConstructorSignIn> createState() => _ConstructorSignInState();
}

class _ConstructorSignInState extends State<ConstructorSignIn> {
  void _handleFormSubmit(String email, String password) {
    // Handle the form submission, e.g., authenticate and navigate
    print('Email: $email, Password: $password');
    // Example: Navigator.of(context).pushReplacementNamed('/clientDashboard');
    context.goNamed(AppRoute.constructorDashboard.name);
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            padding: const EdgeInsets.only(
              top: 30,
              left: 30,
              right: 30,
            ),
            child: Column(
              children: [
                const CircularImage(imageUrl: 'assets/signin/login.jpeg'),
                gapH4,
                const ResponsiveScrollableCard(
                  color: Color.fromARGB(99, 48, 70, 91),
                  child: Center(
                    child: Text(
                      'Constructor Login',
                      style:
                          TextStyle(fontSize: 30, fontWeight: FontWeight.w900),
                    ),
                  ),
                ),
                gapH32,
                Padding(
                    padding: const EdgeInsets.only(
                        top: 30, bottom: 30, left: 10, right: 10),
                    child: SignInForm(
                      signInText: 'Constructor',
                      onFormSubmit: _handleFormSubmit,
                    )),
                TextButton(
                    style: TextButton.styleFrom(
                      foregroundColor: Colors.white,
                    ),
                    onPressed: () {
                      context.goNamed(AppRoute.signUpConstructor.name);
                    },
                    child: const Text('SignUp'))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
