import 'package:flutter/material.dart';
import 'package:home_front_pk/src/common_widgets/action_load_button.dart';
import 'package:home_front_pk/src/common_widgets/lable_inputfield.dart';
import 'package:home_front_pk/src/constants/app_sizes.dart';
import 'package:home_front_pk/src/utils/constants.dart';

class CalculatorScreen extends StatefulWidget {
  const CalculatorScreen({super.key});

  @override
  State<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends State<CalculatorScreen> {
  String _selectedUnit = 'Square Foot';
  final List<String> _units = ['Square Foot', 'Marla', 'Kanal'];
  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();

    return Scaffold(
      body: SafeArea(
        child: SizedBox(
          width: double.infinity,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            // crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Text(
                'Construction Cost Calculator',
                style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
              ),
              Form(
                key: _formKey,
                child: Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    children: [
                      LabelInputField(
                        child: TextField(
                          decoration: InputDecoration(
                            labelText: 'Area Size',
                            contentPadding: EdgeInsets.all(10),
                            border: InputBorder.none,
                            hintStyle: const TextStyle(
                                fontSize: 20, fontFamily: 'Montserrat'),
                            prefixIcon: const Icon(
                              Icons.house,
                              color: Color.fromARGB(161, 0, 0, 0),
                            ),
                          ),
                          style: const TextStyle(
                              color: Colors.black, fontSize: 20),
                          cursorHeight: 15,
                          obscureText: true,
                        ),
                      ),
                      gapH20,
                      Text(
                        'Select Area Unit:',
                        style: TextStyle(
                            fontSize: 18, fontWeight: FontWeight.w600),
                      ),
                      gapH16,
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: DropdownButton<String>(
                          isExpanded: true,
                          dropdownColor: kBackgroundColor,
                          focusColor: Colors.red,
                          enableFeedback: true,
                          iconEnabledColor: Colors.green.shade600,
                          borderRadius: BorderRadius.all(Radius.circular(12)),
                          iconSize: 40,
                          autofocus: true,
                          elevation: 2,
                          icon: Icon(Icons.arrow_drop_down_sharp),
                          value: _selectedUnit,
                          onChanged: (String? newValue) {
                            setState(() {
                              _selectedUnit = newValue!;
                            });
                          },
                          items: _units
                              .map<DropdownMenuItem<String>>((String unit) {
                            return DropdownMenuItem<String>(
                              value: unit,
                              child: Text(
                                unit,
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                      gapH24,
                      ElevatedButton(
                          style: ElevatedButton.styleFrom(
                              backgroundColor: kPrimaryColor,
                              foregroundColor: Colors.white,
                              maximumSize: Size(250, 120)),
                          onPressed: () {},
                          child: Text(
                            'Calculate Cost',
                            style: TextStyle(
                                fontSize: 18, fontWeight: FontWeight.w500),
                          ))
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
