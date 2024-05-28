import 'package:flutter/material.dart';

import 'package:home_front_pk/src/constants/app_sizes.dart';

class SignUpScreen extends StatelessWidget {
  const SignUpScreen(
      {super.key, required this.topText, required this.signUpform});
  final String topText;
  final Widget signUpform;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
          child: Padding(
        padding: const EdgeInsets.only(top: 0, left: 30, right: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              topText,
              style: const TextStyle(
                  fontSize: 30,
                  fontWeight: FontWeight.w500,
                  fontFamily: 'Montserrat'),
            ),
            gapH32,
            signUpform,
          ],
        ),
      )),
    );
  }
}
