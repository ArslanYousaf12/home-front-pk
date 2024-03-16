import 'package:flutter/material.dart';
import 'package:home_front_pk/src/common_widgets/welcome_screen_button.dart';

typedef FormSubmitCallback = void Function(String email, String password);

class SignInForm extends StatefulWidget {
  final String signInText;
  final FormSubmitCallback onFormSubmit;

  const SignInForm({
    super.key,
    required this.signInText,
    required this.onFormSubmit,
  });

  @override
  State<SignInForm> createState() => _SignInFormState();
}

class _SignInFormState extends State<SignInForm> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _enteredEmail = '';
  String _enteredPassword = '';

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      widget.onFormSubmit(_enteredEmail, _enteredPassword);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              decoration: const InputDecoration(labelText: 'Email'),
              keyboardType: TextInputType.emailAddress,
              autocorrect: false,
              onSaved: (newValue) => _enteredEmail = newValue ?? '',
              validator: (value) {
                if (value == null || value.isEmpty || !value.contains('@')) {
                  return 'Please Enter a valid Email';
                }
                return null;
              },
            ),
            TextFormField(
              decoration: const InputDecoration(labelText: 'Password'),
              obscureText: true,
              autocorrect: false,
              onSaved: (newValue) => _enteredPassword = newValue ?? '',
              validator: (value) {
                if (value == null || value.isEmpty || value.trim().length < 8) {
                  return 'Password must be at least 8 characters';
                }
                return null;
              },
            ),
            const SizedBox(height: 64),
            WelcomeButton(
              text: 'Login',
              color: Colors.amber.shade400,
              onPressed: _submit,
            )
          ],
        ),
      ),
    );
  }
}
