import 'package:flutter/material.dart';
import 'package:home_front_pk/src/common_widgets/action_load_button.dart';

import 'package:home_front_pk/src/constants/app_sizes.dart';
import 'package:home_front_pk/src/features/authentication/presentation/sign_in/google_signin_button.dart';

import 'package:home_front_pk/src/utils/constants.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen(
      {super.key,
      required this.topText,
      required this.signInForm,
      required this.signUp,
      required this.googleSignIn});
  final String topText;
  final Widget signInForm;
  final void Function() signUp;
  final void Function() googleSignIn;

  Widget orDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 8),
      child: Row(
        children: [
          Flexible(
            child: Container(
              height: 1,
              color: kPrimaryColor,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 12),
            child: Text(
              'or Log In With',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
                color: Colors.black45,
              ),
            ),
          ),
          Flexible(
            child: Container(
              height: 1,
              color: kPrimaryColor,
            ),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                SingleChildScrollView(
                  padding: const EdgeInsets.only(
                    top: 100,
                    left: 30,
                    right: 30,
                  ),
                  child: Column(
                    children: [
                      // gapH64,
                      // const CircularImage(imageUrl: 'assets/signin/login.jpeg'),
                      // gapH64,
                      Text(
                        topText,
                        style: const TextStyle(
                            fontSize: 30,
                            fontWeight: FontWeight.w500,
                            fontFamily: 'Montserrat'),
                      ),
                      gapH32,
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 100, bottom: 0, left: 20, right: 20),
                        child: signInForm,
                      ),
                      gapH4,
                      orDivider(),
                      gapH16,
                      GoogleLoginButton(
                        onPressed: googleSignIn,
                      ),
                    ],
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 55),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text(
                        'Already have an account?',
                        style: TextStyle(color: kPrimaryColor, fontSize: 15),
                      ),
                      TextButton(
                          style: TextButton.styleFrom(
                            foregroundColor: Colors.white,
                          ),
                          onPressed: signUp,
                          child: const Text(
                            'SignUp',
                            style: TextStyle(
                              color: kSecondaryColor,
                              fontWeight: FontWeight.w500,
                            ),
                          ))
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
