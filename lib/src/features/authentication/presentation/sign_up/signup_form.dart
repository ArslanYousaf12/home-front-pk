import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_front_pk/src/common_widgets/action_load_button.dart';
import 'package:home_front_pk/src/common_widgets/custom_sigin.dart';
import 'package:home_front_pk/src/common_widgets/lable_inputfield.dart';
import 'package:home_front_pk/src/constants/app_sizes.dart';
import 'package:home_front_pk/src/features/authentication/presentation/shared/email_password_sign_in_controller.dart';
import 'package:home_front_pk/src/features/authentication/presentation/sign_in/email_password_sign_in_state.dart';
import 'package:home_front_pk/src/features/authentication/presentation/sign_in/string_validators.dart';
import 'package:home_front_pk/src/localization/string_hardcoded.dart';
import 'package:home_front_pk/src/utils/async_value_ui.dart';
import 'package:home_front_pk/src/utils/constants.dart';

class SignUpForm extends ConsumerStatefulWidget {
  const SignUpForm({super.key, required this.onFormSubmit, required this.role});
  final FormSubmitCallback onFormSubmit;
  final String role;

  @override
  ConsumerState<SignUpForm> createState() => _SignUpFormState();
}

class _SignUpFormState extends ConsumerState<SignUpForm> {
  // * Keys for testing using find.byKey()
  static const emailKey = Key('email');
  static const passwordKey = Key('password');

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
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
              EmailPasswordSignInFormType.register)
          .notifier);

      final success = await controller.submit(email, password, widget.role);

      if (success) {
        // widget.onSignedIn?.call();

        widget.onFormSubmit.call(email, password);

        // context.goNamed(AppRoute.clientDashboard.name);
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

  String _name = '';

  final String _password = '';

  final String _email = '';
  // final _passordTextEditingController = TextEditingController();
  final _confirmPassordTextEditingController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    ref.listen<AsyncValue>(
      emailPasswordSignInControllerProvider(
              EmailPasswordSignInFormType.register)
          .select((state) => state.value),
      (_, state) => state.showAlertDialogOnError(context),
    );
    final state = ref.watch(emailPasswordSignInControllerProvider(
        EmailPasswordSignInFormType.register));
    return FocusScope(
      node: _node,
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            LabelInputField(
              child: TextFormField(
                decoration: InputDecoration(
                  labelText: 'Name'.hardcoded,
                  // hintText: 'Arslan'.hardcoded,
                  border: InputBorder.none,
                  hintStyle:
                      const TextStyle(fontSize: 20, fontFamily: 'Montserrat'),
                  prefixIcon: const Icon(
                    Icons.person_outline_outlined,
                    color: Color.fromARGB(161, 0, 0, 0),
                  ),
                ),
                style: const TextStyle(color: Colors.black, fontSize: 20),
                cursorHeight: 25,
                onSaved: (newValue) {
                  _name = newValue!;
                },
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Please Enter the  Name';
                  }
                  return null;
                },
              ),
            ),
            LabelInputField(
              child: TextFormField(
                key: emailKey,
                controller: _emailController,
                style: const TextStyle(color: Colors.black, fontSize: 20),
                decoration: InputDecoration(
                  labelText: 'Email'.hardcoded,
                  // hintText: 'test@test.com'.hardcoded,
                  border: InputBorder.none,
                  hintStyle:
                      const TextStyle(fontSize: 20, fontFamily: 'Montserrat'),
                  prefixIcon: const Icon(
                    Icons.email_outlined,
                    color: Color.fromARGB(161, 0, 0, 0),
                  ),
                  enabled: !state.isLoading,
                ),
                cursorHeight: 25,
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
            ),
            LabelInputField(
              child: TextFormField(
                key: passwordKey,
                controller: _passwordController,
                decoration: InputDecoration(
                  labelText: state.passwordLabelText,
                  border: InputBorder.none,
                  hintStyle:
                      const TextStyle(fontSize: 20, fontFamily: 'Montserrat'),
                  prefixIcon: const Icon(
                    Icons.password,
                    color: Color.fromARGB(161, 0, 0, 0),
                  ),
                  enabled: !state.isLoading,
                ),
                cursorHeight: 25,
                style: const TextStyle(color: Colors.black, fontSize: 20),
                autovalidateMode: AutovalidateMode.onUserInteraction,
                validator: (password) => !_submitted
                    ? null
                    : state.passwordErrorText(password ?? ''),
                obscureText: true,
                autocorrect: false,
                textInputAction: TextInputAction.done,
                keyboardAppearance: Brightness.light,
                onEditingComplete: () => _passwordEditingComplete(state),
              ),
            ),
            LabelInputField(
              child: TextFormField(
                controller: _confirmPassordTextEditingController,
                decoration: InputDecoration(
                  labelText: 'Confirmed Password',
                  border: InputBorder.none,
                  hintStyle:
                      const TextStyle(fontSize: 20, fontFamily: 'Montserrat'),
                  prefixIcon: const Icon(
                    Icons.password_rounded,
                    color: Color.fromARGB(161, 0, 0, 0),
                  ),
                  enabled: !state.isLoading,
                ),
                style: const TextStyle(color: Colors.black, fontSize: 20),
                cursorHeight: 25,
                obscureText: true,
                onSaved: (newValue) {},
                validator: (value) {
                  if (value == null ||
                      value.isEmpty ||
                      value.trim().length <= 2) {
                    return 'please enter the valid password';
                  }
                  if (value != _passwordController.text) {
                    return 'Passwords do not match';
                  }
                  return null;
                },
              ),
            ),
            gapH12,
            ActionLoadButton(
              isLoading: state.isLoading,
              text: 'Submit',
              color: kPrimaryColor,
              onPressed: state.isLoading ? null : () => _submit(state),
            ),
          ],
        ),
      ),
    );
  }
}
