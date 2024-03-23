import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:home_front_pk/src/common_widgets/circular_image.dart';
import 'package:home_front_pk/src/common_widgets/lable_inputfield.dart';
import 'package:home_front_pk/src/common_widgets/action_load_button.dart';
import 'package:home_front_pk/src/constants/app_sizes.dart';
import 'package:home_front_pk/src/routing/app_router.dart';
import 'package:intl/intl.dart';

class ClientSignUp extends StatefulWidget {
  const ClientSignUp({super.key});

  @override
  State<ClientSignUp> createState() => _ClientSignUpState();
}

class _ClientSignUpState extends State<ClientSignUp> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  DateTime? _dob;
  final _dobTexteditingController = TextEditingController();
  String _firstName = '';
  String _lastName = '';
  String _email = '';
  String _phone = '';

  void _continue() {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
    }
    context.goNamed(AppRoute.signUpClientSecond.name);
  }

  Future<void> _pickingDOB() async {
    DateTime? pickedDate = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(1990),
      lastDate: DateTime.now(),
    );
    if (pickedDate != null) {
      setState(() {
        _dobTexteditingController.text =
            DateFormat('yyyy-MM-dd').format(pickedDate);
      });
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    _dobTexteditingController.dispose();
    super.dispose();
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
                            labelString: 'First Name',
                            child: TextFormField(
                              decoration: const InputDecoration(
                                hintText: 'First Name',
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
                                _firstName = newValue!;
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
                            labelString: 'Last Name',
                            child: TextFormField(
                              decoration: const InputDecoration(
                                hintText: 'Last Name',
                                border: InputBorder.none,
                                prefixIcon: Icon(Icons.person_outline),
                                hintStyle: TextStyle(
                                  fontSize: 20,
                                ),
                              ),
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 20),
                              cursorHeight: 40,
                              onSaved: (newValue) {
                                _lastName = newValue!;
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter the Last Name';
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
                            labelString: 'Phone Number',
                            child: TextFormField(
                              decoration: const InputDecoration(
                                hintText: 'Phone Number',
                                border: InputBorder.none,
                                hintStyle: TextStyle(
                                  fontSize: 20,
                                ),
                                prefixIcon: Icon(Icons.phone),
                              ),
                              keyboardType: TextInputType.phone,
                              style: const TextStyle(
                                  color: Colors.black, fontSize: 20),
                              cursorHeight: 40,
                              onSaved: (newValue) {
                                _phone = newValue!;
                              },
                              validator: (value) {
                                if (value == null || value.isEmpty) {
                                  return 'Please Enter the Phone Number';
                                }
                                return null;
                              },
                            ),
                          ),
                          LabelInputField(
                            labelString: 'Date Of Birth',
                            child: TextFormField(
                              controller: _dobTexteditingController,
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
                          gapH12,
                          ActionLoadButton(
                            text: 'Continue',
                            color: Colors.amber.shade400,
                            onPressed: _continue,
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
