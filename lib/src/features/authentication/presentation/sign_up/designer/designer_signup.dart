import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:home_front_pk/src/common_widgets/circular_image.dart';
import 'package:home_front_pk/src/common_widgets/lable_inputfield.dart';
import 'package:home_front_pk/src/common_widgets/action_load_button.dart';
import 'package:home_front_pk/src/constants/app_sizes.dart';
import 'package:home_front_pk/src/features/authentication/presentation/shared/email_password_sign_in_controller.dart';
import 'package:home_front_pk/src/features/authentication/presentation/sign_in/email_password_sign_in_state.dart';
import 'package:home_front_pk/src/features/authentication/presentation/sign_in/string_validators.dart';
import 'package:home_front_pk/src/features/authentication/presentation/sign_up/signup_form.dart';
import 'package:home_front_pk/src/features/authentication/presentation/sign_up/signup_screen.dart';
import 'package:home_front_pk/src/localization/string_hardcoded.dart';
import 'package:home_front_pk/src/routing/app_router.dart';
import 'package:home_front_pk/src/utils/async_value_ui.dart';
import 'package:intl/intl.dart';

class DesignerSignUp extends StatelessWidget {
  const DesignerSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SignUpScreen(
        topText: 'Designer Account',
        signUpform: SignUpForm(
            onFormSubmit: (email, password) => context.goNamed(
                  AppRoute.designerDashboard.name,
                )),
      ),
    );
  }
}
