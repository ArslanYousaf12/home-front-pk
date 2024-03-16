import 'package:flutter/material.dart';
import 'package:home_front_pk/src/common_widgets/circular_image.dart';
import 'package:home_front_pk/src/common_widgets/lable_inputfield.dart';
import 'package:home_front_pk/src/common_widgets/welcome_screen_button.dart';
import 'package:home_front_pk/src/constants/app_sizes.dart';
import 'package:intl/intl.dart';

class ConstructorSignUp extends StatefulWidget {
  const ConstructorSignUp({super.key});

  @override
  State<ConstructorSignUp> createState() => _ConstructorSignUpState();
}

class _ConstructorSignUpState extends State<ConstructorSignUp> {
  final _formKey = GlobalKey<FormState>();
  String _name = '';
  String _email = '';
  String _password = '';
  final _dobTextEditingController = TextEditingController();
  final _passwordTextEditingController = TextEditingController();
  final _confirmedTextEditingController = TextEditingController();

  Future<void> _pickingDOB() async {
    final pickedDob = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(1990),
        lastDate: DateTime.now());
    if (pickedDob != null) {
      setState(() {
        _dobTextEditingController.text =
            DateFormat('yyyy-MM-dd').format(pickedDob);
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _dobTextEditingController.dispose();
    _passwordTextEditingController.dispose();
    _confirmedTextEditingController.dispose();
    super.dispose();
  }

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      // print(_email);
    }
    return;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
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
                            labelString: 'Name',
                            child: TextFormField(
                              decoration: const InputDecoration(
                                hintText: 'Name',
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                  fontSize: 20,
                                ),
                                prefixIcon: Icon(Icons.person_outline),
                              ),
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 20),
                              cursorHeight: 40,
                              onSaved: (newValue) {
                                _name = newValue!;
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter the First Name';
                                }
                                return null;
                              },
                            ),
                          ),
                          LabelInputField(
                            labelString: 'Email',
                            child: TextFormField(
                              decoration: const InputDecoration(
                                hintText: 'Email',
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                  fontSize: 20,
                                ),
                                prefixIcon: Icon(Icons.email),
                              ),
                              keyboardType: TextInputType.emailAddress,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 20),
                              cursorHeight: 40,
                              onSaved: (newValue) {
                                _email = newValue!;
                              },
                              validator: (value) {
                                if (value == null ||
                                    value.isEmpty ||
                                    !value.contains('@')) {
                                  return 'Please Enter the Valid Email';
                                }
                                return null;
                              },
                            ),
                          ),
                          LabelInputField(
                            labelString: 'Date Of Birth',
                            child: TextFormField(
                              controller: _dobTextEditingController,
                              readOnly: true,
                              decoration: const InputDecoration(
                                hintText: 'Date Of Birth',
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                  fontSize: 20,
                                ),
                                suffixIcon: Icon(Icons.calendar_today),
                              ),
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 20),
                              cursorHeight: 40,
                              onTap: _pickingDOB,
                              onSaved: (newValue) {},
                              validator: (value) {
                                return null;
                              },
                            ),
                          ),
                          LabelInputField(
                            labelString: 'Password',
                            child: TextFormField(
                              controller: _passwordTextEditingController,
                              decoration: const InputDecoration(
                                hintText: 'Password',
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                  fontSize: 20,
                                ),
                                prefixIcon: Icon(Icons.password),
                              ),
                              obscureText: true,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 20),
                              cursorHeight: 40,
                              onSaved: (newValue) {
                                _password = newValue!;
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter the valid 7 character password';
                                }
                                return null;
                              },
                            ),
                          ),
                          LabelInputField(
                            labelString: 'Confirm Password',
                            child: TextFormField(
                              controller: _confirmedTextEditingController,
                              decoration: const InputDecoration(
                                hintText: 'Confirm Password',
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                  fontSize: 20,
                                ),
                                prefixIcon: Icon(Icons.password),
                              ),
                              obscureText: true,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 20),
                              cursorHeight: 40,
                              onSaved: (newValue) {
                                _password = newValue!;
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter the valid 7 character password';
                                }
                                if (value !=
                                    _passwordTextEditingController.text) {
                                  return 'Password Did\'n Match';
                                }
                                return null;
                              },
                            ),
                          ),
                          gapH12,
                          WelcomeButton(
                            text: 'Submit as Constructor',
                            color: Colors.amber.shade400,
                            onPressed: _submit,
                          ),
                        ],
                      ))
                ],
              ),
            ),
          ),
        )),
      ),
    );
  }
}
