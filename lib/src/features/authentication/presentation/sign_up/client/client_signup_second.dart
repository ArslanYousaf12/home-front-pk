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
import 'package:home_front_pk/src/localization/string_hardcoded.dart';
import 'package:home_front_pk/src/routing/app_router.dart';
import 'package:home_front_pk/src/utils/async_value_ui.dart';

class ClientSignUpSecond extends ConsumerStatefulWidget {
  const ClientSignUpSecond({super.key, this.onSignedIn});
  final VoidCallback? onSignedIn;

  @override
  ConsumerState<ClientSignUpSecond> createState() => _ClientSignUpSecondState();
}

class _ClientSignUpSecondState extends ConsumerState<ClientSignUpSecond> {
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
      context.goNamed(AppRoute.clientDashboard.name);
      final controller = ref.read(emailPasswordSignInControllerProvider(
              EmailPasswordSignInFormType.register)
          .notifier);

      final success = await controller.submit(email, password);

      if (success) {
        widget.onSignedIn?.call();
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
  //   ref
  //       .read(emailPasswordSignInControllerProvider(widget.formType).notifier)
  //       .updateFormType(formType);
  //   // * Clear the password field when doing so
  //   _passwordController.clear();
  // }
  String _address = '';
  String _city = '';
  String _password = '';
  String _email = '';
  // final _passordTextEditingController = TextEditingController();
  final _confirmPassordTextEditingController = TextEditingController();

  // void _submit() {
  //   if (_formKey.currentState!.validate()) {
  //     _formKey.currentState!.save();
  //   }
  // }

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
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: FocusScope(
        node: _node,
        child: Scaffold(
          body: SafeArea(
              child: SingleChildScrollView(
            child: Center(
              child: Padding(
                padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
                child: Column(
                  children: [
                    const CircularImage(imageUrl: 'assets/signup/signup.jpeg'),
                    gapH24,
                    Form(
                        key: _formKey,
                        child: Column(
                          children: [
                            LabelInputField(
                              labelString: 'Address',
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  hintText: 'Address',
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                    fontSize: 20,
                                  ),
                                  prefixIcon: Icon(Icons.home),
                                ),
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 20),
                                cursorHeight: 40,
                                onSaved: (newValue) {
                                  _address = newValue!;
                                },
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      value.trim().length <= 2) {
                                    return 'Enter the Valid Address';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            LabelInputField(
                              labelString: 'City',
                              child: TextFormField(
                                decoration: const InputDecoration(
                                  hintText: 'City',
                                  border: InputBorder.none,
                                  prefixIcon: Icon(Icons.location_city),
                                  hintStyle: TextStyle(
                                    fontSize: 20,
                                  ),
                                ),
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 20),
                                cursorHeight: 40,
                                onSaved: (newValue) {
                                  _city = newValue!;
                                },
                                validator: (value) {
                                  if (value == null ||
                                      value.isEmpty ||
                                      value.trim().length <= 1) {
                                    return 'Enter the city name';
                                  }
                                  return null;
                                },
                              ),
                            ),
                            LabelInputField(
                              labelString: 'Email',
                              child: TextFormField(
                                key: emailKey,
                                controller: _emailController,
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 20),
                                decoration: InputDecoration(
                                  labelText: 'Email'.hardcoded,
                                  hintText: 'test@test.com'.hardcoded,
                                  enabled: !state.isLoading,
                                ),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (email) => !_submitted
                                    ? null
                                    : state.emailErrorText(email ?? ''),
                                autocorrect: false,
                                textInputAction: TextInputAction.next,
                                keyboardType: TextInputType.emailAddress,
                                keyboardAppearance: Brightness.light,
                                onEditingComplete: () =>
                                    _emailEditingComplete(state),
                                inputFormatters: <TextInputFormatter>[
                                  ValidatorInputFormatter(
                                      editingValidator:
                                          EmailEditingRegexValidator()),
                                ],
                              ),
                            ),
                            LabelInputField(
                              labelString: 'Password',
                              child: TextFormField(
                                key: passwordKey,
                                controller: _passwordController,
                                decoration: InputDecoration(
                                  labelText: state.passwordLabelText,
                                  enabled: !state.isLoading,
                                ),
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 20),
                                autovalidateMode:
                                    AutovalidateMode.onUserInteraction,
                                validator: (password) => !_submitted
                                    ? null
                                    : state.passwordErrorText(password ?? ''),
                                obscureText: true,
                                autocorrect: false,
                                textInputAction: TextInputAction.done,
                                keyboardAppearance: Brightness.light,
                                onEditingComplete: () =>
                                    _passwordEditingComplete(state),
                              ),
                            ),
                            LabelInputField(
                              labelString: 'Confirme Password',
                              child: TextFormField(
                                controller:
                                    _confirmPassordTextEditingController,
                                decoration: const InputDecoration(
                                  hintText: 'Confirme Password',
                                  border: InputBorder.none,
                                  hintStyle: TextStyle(
                                    fontSize: 20,
                                  ),
                                  prefixIcon: Icon(Icons.password),
                                ),
                                style: const TextStyle(
                                    color: Colors.black, fontSize: 20),
                                cursorHeight: 40,
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
                              text: 'Submit as Client',
                              color: Colors.amber.shade400,
                              onPressed: () => _submit(state),
                            ),
                          ],
                        ))
                  ],
                ),
              ),
            ),
          )),
        ),
      ),
    );
  }
}
