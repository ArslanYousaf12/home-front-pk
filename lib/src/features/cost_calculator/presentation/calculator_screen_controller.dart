// import 'package:flutter/foundation.dart';
import 'package:home_front_pk/src/common_widgets/notifier_mounted.dart';
import 'package:home_front_pk/src/features/cost_calculator/data/cost_calculator_repo.dart';
// import 'package:home_front_pk/src/features/cost_calculator/domain/construction_cost.dart';
import 'package:home_front_pk/src/features/cost_calculator/domain/construction_cost_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'calculator_screen_controller.g.dart';

@riverpod
class CalculatorScreenController extends _$CalculatorScreenController
    with NotifierMounted {
  @override
  FutureOr<Map<String, dynamic>?> build() {
    ref.onDispose(setUnmounted);
    return null;
  }

  Future<void> calculateCost(double area) async {
    state = const AsyncLoading();
    final value = await AsyncValue.guard(
      () => ref.read(fetchcostProvider.future),
    );

    if (value.hasError) {
      state = AsyncError(value.error!, value.stackTrace!);
      return;
    }

    final costs = value.value!;
    final totalCost = _calculateTotalCost(costs, area);
    final breakdown = _calculateBreakdown(costs, area);

    if (mounted) {
      state = AsyncData({
        'totalCost': totalCost,
        'breakdown': breakdown,
      });
    }
  }

  double _calculateTotalCost(ConstructionCostsModel costs, double area) {
    return (costs.bricks +
                costs.cement +
                costs.plumbing +
                costs.electricity +
                costs.labor +
                costs.foundation +
                costs.roofing +
                costs.windows +
                costs.hvac +
                costs.flooring +
                costs.interiorFinishes +
                costs.cabinetry) *
            area +
        costs.appliances +
        costs.landscaping * area +
        costs.permits +
        costs.architectFees * area +
        costs.sitePrep * area;
  }

  Map<String, double> _calculateBreakdown(
      ConstructionCostsModel costs, double area) {
    return {
      'Bricks': costs.bricks * area,
      'Cement': costs.cement * area,
      'Plumbing': costs.plumbing * area,
      'Electricity': costs.electricity * area,
      'Labor': costs.labor * area,
      'Foundation': costs.foundation * area,
      'Roofing': costs.roofing * area,
      'Windows': costs.windows * area,
      'HVAC': costs.hvac * area,
      'Flooring': costs.flooring * area,
      'Interior Finishes': costs.interiorFinishes * area,
      'Cabinetry': costs.cabinetry * area,
      'Appliances': costs.appliances,
      'Landscaping': costs.landscaping * area,
      'Permits': costs.permits,
      'Architect Fees': costs.architectFees * area,
      'Site Preparation': costs.sitePrep * area,
    };
  }
}
