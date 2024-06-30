import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:home_front_pk/src/features/authentication/presentation/sign_up/signup_form.dart';
import 'package:home_front_pk/src/features/authentication/presentation/sign_up/signup_screen.dart';

import 'package:home_front_pk/src/routing/app_router.dart';

class ConstructorSignUp extends StatelessWidget {
  const ConstructorSignUp({super.key});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      child: SignUpScreen(
        topText: 'Constructor Account',
        signUpform: SignUpForm(
            role: 'constructor',
            onFormSubmit: (email, password) =>
                context.goNamed(AppRoute.constructorDashboard.name)),
      ),
    );
  }
}



//  ref.listen<AsyncValue>(
//       emailPasswordSignInControllerProvider(
//               EmailPasswordSignInFormType.register)
//           .select((state) => state.value),
//       (_, state) => state.showAlertDialogOnError(context),
//     );
//     final state = ref.watch(emailPasswordSignInControllerProvider(
//         EmailPasswordSignInFormType.register));
//     return GestureDetector(
//       onTap: () => FocusScope.of(context).unfocus(),
//       child: FocusScope(
//         node: _node,
//         child: Scaffold(
//           body: SafeArea(
//               child: SingleChildScrollView(
//             child: Center(
//               child: Padding(
//                 padding: const EdgeInsets.only(top: 20, left: 20, right: 20),
//                 child: Column(
//                   children: [
//                     const CircularImage(imageUrl: 'assets/signup/signup.jpeg'),
//                     gapH24,
//                     Form(
//                         key: _formKey,
//                         child: Column(
//                           children: [
//                             LabelInputField(
//                               labelString: 'Name',
//                               child: TextFormField(
//                                 decoration: const InputDecoration(
//                                   hintText: 'Name',
//                                   border: InputBorder.none,
//                                   hintStyle: TextStyle(
//                                     fontSize: 20,
//                                   ),
//                                   prefixIcon: Icon(Icons.person_outline),
//                                 ),
//                                 style: const TextStyle(
//                                     color: Colors.black, fontSize: 20),
//                                 cursorHeight: 40,
//                                 onSaved: (newValue) {
//                                   _name = newValue!;
//                                 },
//                                 validator: (value) {
//                                   if (value == null || value.isEmpty) {
//                                     return 'Please Enter the First Name';
//                                   }
//                                   return null;
//                                 },
//                               ),
//                             ),
//                             LabelInputField(
//                               labelString: 'Email',
//                               child: TextFormField(
//                                 key: emailKey,
//                                 controller: _emailController,
//                                 style: const TextStyle(
//                                     color: Colors.black, fontSize: 20),
//                                 decoration: InputDecoration(
//                                   labelText: 'Email'.hardcoded,
//                                   hintText: 'test@test.com'.hardcoded,
//                                   enabled: !state.isLoading,
//                                 ),
//                                 autovalidateMode:
//                                     AutovalidateMode.onUserInteraction,
//                                 validator: (email) => !_submitted
//                                     ? null
//                                     : state.emailErrorText(email ?? ''),
//                                 autocorrect: false,
//                                 textInputAction: TextInputAction.next,
//                                 keyboardType: TextInputType.emailAddress,
//                                 keyboardAppearance: Brightness.light,
//                                 onEditingComplete: () =>
//                                     _emailEditingComplete(state),
//                                 inputFormatters: <TextInputFormatter>[
//                                   ValidatorInputFormatter(
//                                       editingValidator:
//                                           EmailEditingRegexValidator()),
//                                 ],
//                               ),
//                             ),
//                             LabelInputField(
//                               labelString: 'Date Of Birth',
//                               child: TextFormField(
//                                 controller: _dobTextEditingController,
//                                 readOnly: true,
//                                 decoration: const InputDecoration(
//                                   hintText: 'Date Of Birth',
//                                   border: InputBorder.none,
//                                   hintStyle: TextStyle(
//                                     fontSize: 20,
//                                   ),
//                                   suffixIcon: Icon(Icons.calendar_today),
//                                 ),
//                                 style: const TextStyle(
//                                     color: Colors.black, fontSize: 20),
//                                 cursorHeight: 40,
//                                 onTap: _pickingDOB,
//                                 onSaved: (newValue) {},
//                                 validator: (value) {
//                                   return null;
//                                 },
//                               ),
//                             ),
//                             LabelInputField(
//                               labelString: 'Password',
//                               child: TextFormField(
//                                 key: passwordKey,
//                                 controller: _passwordController,
//                                 decoration: InputDecoration(
//                                   labelText: state.passwordLabelText,
//                                   enabled: !state.isLoading,
//                                 ),
//                                 style: const TextStyle(
//                                     color: Colors.black, fontSize: 20),
//                                 autovalidateMode:
//                                     AutovalidateMode.onUserInteraction,
//                                 validator: (password) => !_submitted
//                                     ? null
//                                     : state.passwordErrorText(password ?? ''),
//                                 obscureText: true,
//                                 autocorrect: false,
//                                 textInputAction: TextInputAction.done,
//                                 keyboardAppearance: Brightness.light,
//                                 onEditingComplete: () =>
//                                     _passwordEditingComplete(state),
//                               ),
//                             ),
//                             LabelInputField(
//                               labelString: 'Confirm Password',
//                               child: TextFormField(
//                                 controller: _confirmedTextEditingController,
//                                 decoration: const InputDecoration(
//                                   hintText: 'Confirm Password',
//                                   border: InputBorder.none,
//                                   hintStyle: TextStyle(
//                                     fontSize: 20,
//                                   ),
//                                   prefixIcon: Icon(Icons.password),
//                                 ),
//                                 obscureText: true,
//                                 style: const TextStyle(
//                                     color: Colors.black, fontSize: 20),
//                                 cursorHeight: 40,
//                                 onSaved: (newValue) {
//                                   _password = newValue!;
//                                 },
//                                 validator: (value) {
//                                   if (value == null || value.isEmpty) {
//                                     return 'Please Enter the valid 7 character password';
//                                   }
//                                   if (value != _passwordController.text) {
//                                     return 'Password Did\'n Match';
//                                   }
//                                   return null;
//                                 },
//                               ),
//                             ),
//                             gapH12,
//                             ActionLoadButton(
//                               isLoading: state.isLoading,
//                               text: 'Submit as Constructor',
//                               color: Colors.amber.shade400,
//                               onPressed:
//                                   state.isLoading ? null : () => _submit(state),
//                             ),
//                           ],
//                         ))
//                   ],
//                 ),
//               ),
//             ),
//           )),
//         ),
//       ),
//     );