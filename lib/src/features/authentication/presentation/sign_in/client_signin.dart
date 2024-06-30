import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'package:home_front_pk/src/common_widgets/custom_sigin.dart';

import 'package:home_front_pk/src/features/authentication/presentation/shared/email_password_sign_in_controller.dart';
import 'package:home_front_pk/src/features/authentication/presentation/sign_in/email_password_sign_in_state.dart';
import 'package:home_front_pk/src/features/authentication/presentation/sign_in/sign_in.dart';
import 'package:home_front_pk/src/routing/app_router.dart';
import 'package:home_front_pk/src/utils/async_value_ui.dart';

class ClientSignInScreen extends ConsumerStatefulWidget {
  const ClientSignInScreen({super.key});
  // * Keys for testing using find.byKey()
  static const emailKey = Key('email');
  static const passwordKey = Key('password');

  @override
  ConsumerState<ClientSignInScreen> createState() => _ClientSignInScreenState();
}

class _ClientSignInScreenState extends ConsumerState<ClientSignInScreen> {
  void _handleFormSubmit(String email, String password) {
    // Handle the form submission, e.g., authenticate and navigate
    print('Email: $email, Password: $password');
    // Example: Navigator.of(context).pushReplacementNamed('/clientDashboard');
    context.goNamed(AppRoute.clientDashboard.name);
  }

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(
      emailPasswordSignInControllerProvider(EmailPasswordSignInFormType.signIn)
          .select((state) => state.value),
      (_, state) => state.showAlertDialogOnError(context),
    );
    return SignInScreen(
      topText: 'Buyer Login',
      signInForm: SignInForm(
        role: 'buyer',
        signInText: 'Client',
        onFormSubmit: _handleFormSubmit,
      ),
      signUp: () {
        context.goNamed(
          AppRoute.signUpClient.name,
        );
      },
    );
  }
}


// GestureDetector(
//       onTap: () => FocusScope.of(context).unfocus(),
//       child: Scaffold(
//         body: SafeArea(
//           child: Column(
//             mainAxisAlignment: MainAxisAlignment.spaceBetween,
//             children: [
//               SingleChildScrollView(
//                 padding: const EdgeInsets.only(
//                   top: 100,
//                   left: 30,
//                   right: 30,
//                 ),
//                 child: Column(
//                   children: [
//                     // gapH64,
//                     // const CircularImage(imageUrl: 'assets/signin/login.jpeg'),
//                     // gapH64,
//                     const Text(
//                       'Buyer Login',
//                       style: TextStyle(
//                           fontSize: 30,
//                           fontWeight: FontWeight.w500,
//                           fontFamily: 'Montserrat'),
//                     ),
//                     gapH32,
//                     Padding(
//                         padding: const EdgeInsets.only(
//                             top: 100, bottom: 30, left: 20, right: 20),
//                         child: SignInForm(
//                           signInText: 'Client',
//                           onFormSubmit: _handleFormSubmit,
//                         )),
//                     gapH32,
//                     orDivider(),
//                   ],
//                 ),
//               ),
//               Padding(
//                 padding: const EdgeInsets.only(bottom: 55),
//                 child: Row(
//                   mainAxisAlignment: MainAxisAlignment.center,
//                   children: [
//                     const Text(
//                       'Already have an account?',
//                       style: TextStyle(color: kPrimaryColor, fontSize: 15),
//                     ),
//                     TextButton(
//                         style: TextButton.styleFrom(
//                           foregroundColor: Colors.white,
//                         ),
//                         onPressed: () {
//                           context.goNamed(
//                             AppRoute.signUpClient.name,
//                           );
//                           // GoRouter.of(context).go('/client-dashboard');
//                           // GoRouter.of(context).replace('/client-dashboard');
//                         },
//                         child: const Text(
//                           'SignUp',
//                           style: TextStyle(
//                             color: kSecondaryColor,
//                             fontWeight: FontWeight.w500,
//                           ),
//                         ))
//                   ],
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );