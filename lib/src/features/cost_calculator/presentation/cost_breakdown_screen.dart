import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:home_front_pk/src/features/cost_calculator/presentation/CostBreakGraphdownScreen.dart';
import 'package:home_front_pk/src/features/cost_calculator/presentation/calculator_screen_controller.dart';
import 'package:home_front_pk/src/routing/app_router.dart';
import 'package:home_front_pk/src/utils/constants.dart';

class CostBreakdownScreen extends ConsumerStatefulWidget {
  final double area;

  const CostBreakdownScreen({Key? key, required this.area}) : super(key: key);

  @override
  _CostBreakdownScreenState createState() => _CostBreakdownScreenState();
}

class _CostBreakdownScreenState extends ConsumerState<CostBreakdownScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref
          .read(calculatorScreenControllerProvider.notifier)
          .calculateCost(widget.area);
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(calculatorScreenControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: Text('Cost Breakdown'),
      ),
      body: state.when(
        data: (data) => data != null
            ? _buildCostBreakdown(context, data)
            : Center(child: Text('No data available')),
        loading: () => Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }

  Widget _buildCostBreakdown(BuildContext context, Map<String, dynamic> data) {
    final totalCost = data['totalCost'] as double;
    final breakdown = data['breakdown'] as Map<String, double>;

    return ListView(
      padding: EdgeInsets.all(16),
      children: [
        Text(
          'Total Cost: PKR ${totalCost.toStringAsFixed(2)}',
          style: Theme.of(context)
              .textTheme
              .headlineMedium!
              .copyWith(color: kPrimaryColor),
        ),
        SizedBox(height: 20),
        ElevatedButton(
          child: Text('View Graph'),
          onPressed: () {
            // Navigator.of(context).push(
            //   MaterialPageRoute(
            //     builder: (context) =>
            //         CostBreakdownGraphScreen(area: widget.area),
            //   ),
            // );
            context.goNamed(
              AppRoute.costBreakDownGraph.name,
              extra: widget.area.toString(),
            );
          },
        ),
        SizedBox(height: 20),
        Text(
          'Cost Breakdown:',
          style: Theme.of(context).textTheme.headlineSmall!.copyWith(
              color: kSecondaryColor,
              // fontWeight: FontWeight.bold,
              fontStyle: FontStyle.italic),
        ),
        SizedBox(height: 10),
        ...breakdown.entries
            .map((entry) => _buildCostItem(entry.key, entry.value)),
      ],
    );
  }

  Widget _buildCostItem(String label, double cost) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(label),
          Text('PKR ${cost.toStringAsFixed(2)}'),
        ],
      ),
    );
  }
}
