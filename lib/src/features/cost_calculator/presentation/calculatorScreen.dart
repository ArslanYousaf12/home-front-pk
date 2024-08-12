import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:home_front_pk/src/common_widgets/lable_inputfield.dart';
import 'package:home_front_pk/src/constants/app_sizes.dart';
import 'package:home_front_pk/src/features/cost_calculator/presentation/calculator_screen_controller.dart';
import 'package:home_front_pk/src/features/cost_calculator/presentation/cost_breakdown_screen.dart';
import 'package:home_front_pk/src/routing/app_router.dart';
import 'package:home_front_pk/src/utils/constants.dart';

class CalculatorScreen extends ConsumerStatefulWidget {
  const CalculatorScreen({super.key});

  @override
  ConsumerState<CalculatorScreen> createState() => _CalculatorScreenState();
}

class _CalculatorScreenState extends ConsumerState<CalculatorScreen> {
  String _selectedUnit = 'Square Foot';
  final List<String> _units = ['Square Foot', 'Marla', 'Kanal'];
  final TextEditingController _areaController = TextEditingController();

  @override
  void dispose() {
    _areaController.dispose();
    super.dispose();
  }

  double convertToSquareFeet(double area, String unit) {
    switch (unit) {
      case 'Square Foot':
        return area;
      case 'Marla':
        return area * 272.25; // 1 Marla = 272.25 sq ft
      case 'Kanal':
        return area * 5445; // 1 Kanal = 5445 sq ft
      default:
        return area;
    }
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();

    return SafeArea(
      child: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text(
              'Construction Cost Calculator',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
            ),
            Form(
              key: formKey,
              child: Padding(
                padding: const EdgeInsets.all(20.0),
                child: Column(
                  children: [
                    LabelInputField(
                      child: TextField(
                        controller: _areaController,
                        keyboardType: TextInputType.number,
                        decoration: InputDecoration(
                          labelText: 'Area Size',
                          contentPadding: EdgeInsets.all(10),
                          border: InputBorder.none,
                          hintStyle:
                              TextStyle(fontSize: 20, fontFamily: 'Montserrat'),
                          prefixIcon: Icon(
                            Icons.house,
                            color: Color.fromARGB(161, 0, 0, 0),
                          ),
                        ),
                        style: TextStyle(color: Colors.black, fontSize: 20),
                        cursorHeight: 15,
                      ),
                    ),
                    gapH20,
                    const Text(
                      'Select Area Unit:',
                      style:
                          TextStyle(fontSize: 18, fontWeight: FontWeight.w600),
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
                        borderRadius:
                            const BorderRadius.all(Radius.circular(12)),
                        iconSize: 40,
                        autofocus: true,
                        elevation: 2,
                        icon: const Icon(Icons.arrow_drop_down_sharp),
                        value: _selectedUnit,
                        onChanged: (String? newValue) {
                          setState(() {
                            _selectedUnit = newValue!;
                          });
                        },
                        items:
                            _units.map<DropdownMenuItem<String>>((String unit) {
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
                            backgroundColor: kSecondaryColor,
                            foregroundColor: Colors.white,
                            maximumSize: const Size(250, 120)),
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            double area =
                                double.tryParse(_areaController.text) ?? 0;
                            double squareFeetArea =
                                convertToSquareFeet(area, _selectedUnit);
                            ref
                                .read(
                                    calculatorScreenControllerProvider.notifier)
                                .calculateCost(squareFeetArea);
                            // Navigator.push(
                            //     context,
                            //     MaterialPageRoute(
                            //       builder: (context) =>
                            //           CostBreakdownScreen(area: squareFeetArea),
                            //     ));
                            context.goNamed(
                              AppRoute.costBreakDownScreen.name,
                              extra: squareFeetArea.toString(),
                            );
                          }
                        },
                        child: const Text(
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
    );
  }
}
