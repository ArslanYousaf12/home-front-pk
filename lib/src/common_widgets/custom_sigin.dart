import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_front_pk/src/common_widgets/action_load_button.dart';
import 'package:home_front_pk/src/common_widgets/alert_dialogs.dart';
import 'package:home_front_pk/src/constants/app_sizes.dart';
import 'package:home_front_pk/src/features/authentication/data/auth_repository.dart';
import 'package:home_front_pk/src/features/authentication/presentation/shared/email_password_sign_in_controller.dart';
import 'package:home_front_pk/src/features/authentication/presentation/sign_in/email_password_sign_in_state.dart';
import 'package:home_front_pk/src/features/authentication/presentation/sign_in/string_validators.dart';
import 'package:home_front_pk/src/localization/string_hardcoded.dart';
import 'package:home_front_pk/src/utils/async_value_ui.dart';
import 'package:home_front_pk/src/utils/constants.dart';

typedef FormSubmitCallback = void Function(String email, String password);

class SignInForm extends ConsumerStatefulWidget {
  const SignInForm(
      {super.key,
      required this.signInText,
      required this.onFormSubmit,
      required this.role});
  final String signInText;
//TODO: check signInText usage
  final Function(String email, String password) onFormSubmit;
  final String role;

  @override
  ConsumerState<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends ConsumerState<SignInForm> {
  // * Keys for testing using find.byKey()
  static const emailKey = Key('email');
  static const passwordKey = Key('password');
  final _formKey = GlobalKey<FormState>();
  final _node = FocusScopeNode();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  String get email => _emailController.text;
  String get password => _passwordController.text;
  // local variable used to apply AutovalidateMode.onUserInteraction and show
  // error hints only when the form has been submitted
  // For more details on how this is implemented, see:
  // https://codewithandrea.com/articles/flutter-text-field-form-validation/
  var _submitted = false;

  @override
  void dispose() {
    // * TextEditingControllers should be always disposed
    _node.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  Future<void> _submit(EmailPasswordSignInState state) async {
    setState(() => _submitted = true);
    // only submit the form if validation passes
    if (_formKey.currentState!.validate()) {
      final controller = ref.read(emailPasswordSignInControllerProvider(
        EmailPasswordSignInFormType.signIn,
      ).notifier);
      final sucess = await controller.submit(
        email,
        password,
        widget.role,
      );
      if (sucess) {
        widget.onFormSubmit.call(email, password);
      }
    }
  }

  void _emailEditingComplete(EmailPasswordSignInState state) {
    if (state.canSubmitEmail(email)) {
      _node.nextFocus();
    }
  }

  void _passwordEditingComplete(EmailPasswordSignInState state) {
    if (!state.canSubmitEmail(email)) {
      _node.previousFocus();
      return;
    }
    _submit(state);
  }

  // void _updateFormType(EmailPasswordSignInFormType formType) {
  //   // * Toggle between register and sign in form
  //   setState(() => state = state.copyWith(formType: formType));
  //   // * Clear the password field when doing so
  //   _passwordController.clear();
  // }

  // void _submit() {
  //   if (_formKey.currentState!.validate()) {
  //     _formKey.currentState!.save();
  //     widget.onFormSubmit(_enteredEmail, _enteredPassword);
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    //only Listen when State value change
    ref.listen(
        emailPasswordSignInControllerProvider(
                EmailPasswordSignInFormType.signIn)
            .select((state) => state.value), (_, state) {
      state.showAlertDialogOnError(context);
    });

    final state = ref.watch(emailPasswordSignInControllerProvider(
      EmailPasswordSignInFormType.signIn,
    ));

    return FocusScope(
      node: _node,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              key: emailKey,
              controller: _emailController,
              decoration: InputDecoration(
                labelText: 'Email'.hardcoded,
                hintText: 'test@test.com'.hardcoded,
                hintStyle:
                    const TextStyle(color: Color.fromARGB(118, 255, 255, 255)),
                enabled: !state.isLoading,
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (email) =>
                  !_submitted ? null : state.emailErrorText(email ?? ''),
              autocorrect: false,
              textInputAction: TextInputAction.next,
              keyboardType: TextInputType.emailAddress,
              keyboardAppearance: Brightness.light,
              onEditingComplete: () => _emailEditingComplete(state),
              inputFormatters: <TextInputFormatter>[
                ValidatorInputFormatter(
                    editingValidator: EmailEditingRegexValidator()),
              ],
            ),
            TextFormField(
              key: passwordKey,
              controller: _passwordController,
              decoration: InputDecoration(
                labelText: state.passwordLabelText,
                enabled: !state.isLoading,
              ),
              autovalidateMode: AutovalidateMode.onUserInteraction,
              validator: (password) =>
                  !_submitted ? null : state.passwordErrorText(password ?? ''),
              obscureText: true,
              autocorrect: false,
              textInputAction: TextInputAction.done,
              keyboardAppearance: Brightness.light,
              onEditingComplete: () => _passwordEditingComplete(state),
            ),
            const SizedBox(height: 64),
            ActionLoadButton(
              isLoading: state.isLoading,
              text: 'Login',
              color: kPrimaryColor,
              onPressed: state.isLoading ? null : () => _submit(state),
            ),
            gapH12,
            TextButton(
                style: TextButton.styleFrom(
                  foregroundColor: Colors.white,
                ),
                onPressed: () async {
                  final emailController =
                      ref.read(emailPasswordSignInControllerProvider(
                    EmailPasswordSignInFormType.signIn,
                  ).notifier);
                  final sucess =
                      await emailController.sendPasswordResetLink(email);
                  if (sucess) {
                    showAlertDialog(
                        context: context,
                        title: 'Sucess',
                        content:
                            'Email Sucessfully sent please check your email');
                  }
                },
                child: const Text(
                  'Forget Password',
                  style: TextStyle(
                    color: kSecondaryColor,
                    fontWeight: FontWeight.w500,
                  ),
                )),
          ],
        ),
      ),
    );
  }
}
