import 'package:flutter/material.dart';
import 'package:home_front_pk/src/common_widgets/circular_image.dart';
import 'package:home_front_pk/src/common_widgets/lable_inputfield.dart';
import 'package:home_front_pk/src/common_widgets/action_load_button.dart';
import 'package:home_front_pk/src/constants/app_sizes.dart';

class ClientSignUpSecond extends StatefulWidget {
  const ClientSignUpSecond({super.key});

  @override
  State<ClientSignUpSecond> createState() => _ClientSignUpSecondState();
}

class _ClientSignUpSecondState extends State<ClientSignUpSecond> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  String _address = '';
  String _city = '';
  String _password = '';
  final _passordTextEditingController = TextEditingController();
  final _confirmPassordTextEditingController = TextEditingController();

  void _submit() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    }
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
                            labelString: 'Password',
                            child: TextFormField(
                              controller: _passordTextEditingController,
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
                                if (value == null ||
                                    value.isEmpty ||
                                    value.trim().length <= 7) {
                                  return 'Enter the Valid 7 Character long Password';
                                }
                                return null;
                              },
                            ),
                          ),
                          LabelInputField(
                            labelString: 'Confirme Password',
                            child: TextFormField(
                              controller: _confirmPassordTextEditingController,
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
                                if (value !=
                                    _passordTextEditingController.text) {
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
