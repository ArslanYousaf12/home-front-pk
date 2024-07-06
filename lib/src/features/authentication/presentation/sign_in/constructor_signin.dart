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

class ConstructorSignIn extends ConsumerStatefulWidget {
  const ConstructorSignIn({super.key});

  @override
  ConsumerState<ConstructorSignIn> createState() => _ConstructorSignInState();
}

class _ConstructorSignInState extends ConsumerState<ConstructorSignIn> {
  void _handleFormSubmit(String email, String password) async {
    // Handle the form submission, e.g., authenticate and navigate
    print('Email: $email, Password: $password');
    // final userRole = ref.watch(userRoleProvider);
    final authRepo = ref.read(authRepositoryProvider);
    final user = authRepo.currentUser;
    final userRole = await authRepo.getUserRole(user!.uid);
    if (userRole == 'constructor') {
      context.goNamed(AppRoute.constructorDashboard.name);
    } else {
      ScaffoldMessenger.of(context)
          .showSnackBar(SnackBar(content: Text('Wrong Email or Password')));
    }
    // print(userRole.value);
    // userRole.when(
    //   data: (value) {
    //     if (value == 'constructor') {
    //       context.goNamed(AppRoute.constructorDashboard.name);
    //     }
    //   },
    //   error: (error, stackTrace) => showExceptionAlertDialog(
    //       context: context, title: 'Error', exception: error),
    //   loading: () => Center(
    //     child: CircularProgressIndicator(),
    //   ),
    // );
    // if (userRole.value != 'constructor') {
    //   ScaffoldMessenger.of(context)
    //       .showSnackBar(SnackBar(content: Text('Wrong Email or Password')));
    // }
    // Example: Navigator.of(context).pushReplacementNamed('/clientDashboard');

    // Example: Navigator.of(context).pushReplacementNamed('/clientDashboard');
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
        role: 'constructor',
        //TODO: remove and check sigin Text
        signInText: 'Constructor',
        onFormSubmit: _handleFormSubmit,
      ),
      signUp: () {
        context.goNamed(
          AppRoute.signUpConstructor.name,
        );
      },
      googleSignIn: () async {
        final sucess = await ref
            .read(googleSigninControllerProvider.notifier)
            .signInWithGoogle();
        if (sucess) {
          context.goNamed(AppRoute.constructorDashboard.name);
        }
      },
    );
  }
}
