import 'package:flutter/material.dart';



import 'package:home_front_pk/src/constants/app_sizes.dart';

import 'package:home_front_pk/src/utils/constants.dart';

class SignInScreen extends StatelessWidget {
  const SignInScreen(
      {super.key,
      required this.topText,
      required this.signInForm,
      required this.signUp});
  final String topText;
  final Widget signInForm;
  final void Function() signUp;

  Widget orDivider() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 130, vertical: 8),
      child: Row(
        children: [
          Flexible(
            child: Container(
              height: 1,
              color: kPrimaryColor,
            ),
          ),
          const Padding(
            padding: EdgeInsets.symmetric(horizontal: 16),
            child: Text(
              'or',
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w600,
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
                            top: 100, bottom: 30, left: 20, right: 20),
                        child: signInForm,
                      ),
                      gapH32,
                      orDivider(),
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
