import 'package:home_front_pk/src/common_widgets/notifier_mounted.dart';
import 'package:home_front_pk/src/features/cost_calculator/data/cost_calculator_repo.dart';
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
      () => ref.read(fetchCostProvider.future),
    );

    if (value.hasError) {
      state = AsyncError(value.error!, value.stackTrace!);
      return;
    }

    final costs = value.value!;
    final selectedOptions = ref.read(selectedOptionsProvider);
    final totalCost = _calculateTotalCost(costs, selectedOptions, area);
    final breakdown = _calculateBreakdown(costs, selectedOptions, area);

    if (mounted) {
      state = AsyncData({
        'totalCost': totalCost,
        'breakdown': breakdown,
      });
    }
  }

  double _calculateTotalCost(
    ConstructionCostsModel costs,
    Map<String, Map<String, MaterialOption>> selectedOptions,
    double area,
  ) {
    double total = 0.0;

    void addCost(String category, String type, MaterialOption option) {
      switch (option.unit) {
        case 'per sq ft':
          total += option.pricePerUnit * area;
          break;
        case 'flat rate':
          total += option.pricePerUnit;
          break;
        case 'per brick':
          // Assuming average brick coverage
          total += option.pricePerUnit * (area * 35); // 35 bricks per sq ft
          break;
        case 'per bag':
          // Assuming average cement usage
          total += option.pricePerUnit * (area * 0.4); // 0.4 bags per sq ft
          break;
        case 'per meter':
          // Assuming average wiring/piping needs
          total += option.pricePerUnit * (area * 0.5); // 0.5 meters per sq ft
          break;
        case 'per ton':
          // Assuming average HVAC needs
          total += option.pricePerUnit * (area * 0.0002); // 1 ton per 500 sq ft
          break;
        case 'per linear ft':
          // Assuming average cabinet length needs
          total +=
              option.pricePerUnit * (area * 0.2); // 0.2 linear ft per sq ft
          break;
        case 'per day':
          // Assuming construction duration based on area
          total += option.pricePerUnit * (area * 0.02); // 1 day per 50 sq ft
          break;
        default:
          total += option.pricePerUnit;
      }
    }

    selectedOptions.forEach((category, types) {
      types.forEach((type, option) {
        addCost(category, type, option);
      });
    });

    return total;
  }

  Map<String, double> _calculateBreakdown(
    ConstructionCostsModel costs,
    Map<String, Map<String, MaterialOption>> selectedOptions,
    double area,
  ) {
    final breakdown = <String, double>{};

    selectedOptions.forEach((category, types) {
      types.forEach((type, option) {
        double cost = 0.0;

        switch (option.unit) {
          case 'per sq ft':
            cost = option.pricePerUnit * area;
            break;
          case 'flat rate':
            cost = option.pricePerUnit;
            break;
          case 'per brick':
            cost = option.pricePerUnit * (area * 35);
            break;
          case 'per bag':
            cost = option.pricePerUnit * (area * 0.4);
            break;
          case 'per meter':
            cost = option.pricePerUnit * (area * 0.5);
            break;
          case 'per ton':
            cost = option.pricePerUnit * (area * 0.0002);
            break;
          case 'per linear ft':
            cost = option.pricePerUnit * (area * 0.2);
            break;
          case 'per day':
            cost = option.pricePerUnit * (area * 0.02);
            break;
          default:
            cost = option.pricePerUnit;
        }

        breakdown['$category - $type'] = cost;
      });
    });

    return breakdown;
  }
}
