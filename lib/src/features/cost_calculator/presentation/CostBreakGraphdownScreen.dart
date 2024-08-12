import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:home_front_pk/src/features/cost_calculator/presentation/calculator_screen_controller.dart';
// import 'package:home_front_pk/src/utils/constants.dart';

class CostBreakdownGraphScreen extends ConsumerWidget {
  final double area;

  const CostBreakdownGraphScreen({Key? key, required this.area})
      : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(calculatorScreenControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Cost Breakdown Graph'),
      ),
      body: state.when(
        data: (data) => data != null
            ? _buildGraph(context, data)
            : Center(child: Text('No data available')),
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }

  Widget _buildGraph(BuildContext context, Map<String, dynamic> data) {
    final breakdown = data['breakdown'] as Map<String, double>;
    final List<PieChartSectionData> sections = [];
    final List<Color> colors = [
      Colors.blue,
      Colors.green,
      Colors.red,
      Colors.yellow,
      Colors.purple,
      Colors.orange,
      Colors.teal,
      Colors.pink,
      Colors.cyan,
      Colors.amber,
      Colors.indigo,
      Colors.lime,
      Colors.brown,
      Colors.deepOrange,
      Colors.lightBlue,
      Colors.lightGreen,
      Colors.deepPurple,
    ];

    int colorIndex = 0;
    breakdown.forEach((key, value) {
      sections.add(
        PieChartSectionData(
          color: colors[colorIndex % colors.length],
          value: value,
          title: '${(value / data['totalCost'] * 100).toStringAsFixed(1)}%',
          radius: 150,
          titleStyle: TextStyle(
            fontSize: 12,
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
      );
      colorIndex++;
    });

    return Column(
      children: [
        Expanded(
          child: PieChart(
            PieChartData(
              sections: sections,
              centerSpaceRadius: 0,
              sectionsSpace: 2,
            ),
          ),
        ),
        Expanded(
          child: ListView(
            children: [
              ...breakdown.entries.map((entry) {
                return ListTile(
                  leading: CircleAvatar(
                    backgroundColor: colors[
                        breakdown.keys.toList().indexOf(entry.key) %
                            colors.length],
                  ),
                  title: Text(entry.key),
                  trailing: Text('PKR ${entry.value.toStringAsFixed(2)}'),
                );
              }),
            ],
          ),
        ),
      ],
    );
  }
}
