import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:home_front_pk/src/common_widgets/lable_inputfield.dart';
import 'package:home_front_pk/src/constants/app_sizes.dart';
import 'package:home_front_pk/src/features/cost_calculator/data/cost_calculator_repo.dart';
import 'package:home_front_pk/src/features/cost_calculator/domain/construction_cost_model.dart';
import 'package:home_front_pk/src/features/cost_calculator/presentation/calculator_screen_controller.dart';
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
        return area * 272.25;
      case 'Kanal':
        return area * 5445;
      default:
        return area;
    }
  }

  @override
  Widget build(BuildContext context) {
    final formKey = GlobalKey<FormState>();
    final costsAsync = ref.watch(fetchCostProvider);

    return SafeArea(
      child: Scaffold(
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const Text(
                  'Construction Cost Calculator',
                  style: TextStyle(fontSize: 20, fontWeight: FontWeight.w600),
                ),
                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      gapH20,
                      LabelInputField(
                        child: TextField(
                          controller: _areaController,
                          keyboardType: TextInputType.number,
                          decoration: const InputDecoration(
                            labelText: 'Area Size',
                            contentPadding: EdgeInsets.all(10),
                            border: InputBorder.none,
                            hintStyle: TextStyle(
                              fontSize: 20,
                              fontFamily: 'Montserrat',
                            ),
                            prefixIcon: Icon(
                              Icons.house,
                              color: Color.fromARGB(161, 0, 0, 0),
                            ),
                          ),
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 20,
                          ),
                          cursorHeight: 15,
                        ),
                      ),
                      gapH20,
                      const Text(
                        'Select Area Unit:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      gapH16,
                      DropdownButton<String>(
                        isExpanded: true,
                        dropdownColor: kBackgroundColor,
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
                            child: Text(unit),
                          );
                        }).toList(),
                      ),
                      gapH24,
                      const Text(
                        'Select Materials:',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      gapH16,
                      costsAsync.when(
                        loading: () => const Center(
                          child: CircularProgressIndicator(),
                        ),
                        error: (error, stack) => Text('Error: $error'),
                        data: (costs) {
                          return Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: costs.categories.entries.map((category) {
                              return Card(
                                child: ExpansionTile(
                                  title: Text(
                                    category.key.toUpperCase(),
                                    style: const TextStyle(
                                      fontWeight: FontWeight.w600,
                                    ),
                                  ),
                                  children: category.value.materialTypes.entries
                                      .map((materialType) {
                                    return Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            materialType.key,
                                            style: const TextStyle(
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          DropdownButton<MaterialOption>(
                                            isExpanded: true,
                                            value: ref.watch(
                                                    selectedOptionsProvider)[
                                                category
                                                    .key]?[materialType.key],
                                            items: materialType.value.materials
                                                .map((option) {
                                              return DropdownMenuItem(
                                                value: option,
                                                child: Text(
                                                  '${option.name} - ${option.pricePerUnit} ${option.unit}',
                                                ),
                                              );
                                            }).toList(),
                                            onChanged: (newValue) {
                                              if (newValue != null) {
                                                ref
                                                    .read(
                                                        selectedOptionsProvider
                                                            .notifier)
                                                    .updateSelectedOption(
                                                      category.key,
                                                      materialType.key,
                                                      newValue,
                                                    );
                                              }
                                            },
                                          ),
                                          Text(
                                            materialType.value.materials.first
                                                .description,
                                            style: const TextStyle(
                                              fontSize: 12,
                                              color: Colors.grey,
                                            ),
                                          ),
                                        ],
                                      ),
                                    );
                                  }).toList(),
                                ),
                              );
                            }).toList(),
                          );
                        },
                      ),
                      gapH24,
                      Center(
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: kSecondaryColor,
                            foregroundColor: Colors.white,
                            maximumSize: const Size(250, 120),
                          ),
                          onPressed: () {
                            if (formKey.currentState!.validate()) {
                              double area =
                                  double.tryParse(_areaController.text) ?? 0;
                              double squareFeetArea =
                                  convertToSquareFeet(area, _selectedUnit);
                              ref
                                  .read(calculatorScreenControllerProvider
                                      .notifier)
                                  .calculateCost(squareFeetArea);
                              context.goNamed(
                                AppRoute.costBreakDownScreen.name,
                                extra: squareFeetArea.toString(),
                              );
                            }
                          },
                          child: const Text(
                            'Calculate Cost',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.w500,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
