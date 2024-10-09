import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_front_pk/src/features/cost_calculator/domain/construction_cost_model.dart';

class CostCalculatorRepo {
  CostCalculatorRepo({required FirebaseFirestore firestore})
      : _firestore = firestore;

  final FirebaseFirestore _firestore;

  Future<ConstructionCostsModel> fetchConstructionCost() async {
    final categories = [
      'structural',
      'utilities',
      'finishing',
      'appliances',
      'exterior',
      'services'
    ];
    final Map<String, dynamic> constructionData = {};

    // Fetch all categories in parallel
    final categoryFutures = categories.map((category) async {
      final snapshot = await _firestore.collection(category).get();
      final categoryData = <String, dynamic>{};

      for (var doc in snapshot.docs) {
        categoryData[doc.id] = doc.data();
      }

      return MapEntry(category, categoryData);
    });

    // Wait for all fetches to complete
    final results = await Future.wait(categoryFutures);

    // Combine results into final map
    for (var result in results) {
      constructionData[result.key] = result.value;
    }

    return ConstructionCostsModel.fromFirestore(constructionData);
  }
}

// Repository provider
final costCalculatorRepoProvider = Provider<CostCalculatorRepo>((ref) {
  return CostCalculatorRepo(firestore: FirebaseFirestore.instance);
});

// Future provider for fetching costs
final fetchCostProvider = FutureProvider<ConstructionCostsModel>((ref) async {
  final repo = ref.watch(costCalculatorRepoProvider);
  return await repo.fetchConstructionCost();
});

// Providers for selected options
final selectedOptionsProvider = StateNotifierProvider<SelectedOptionsNotifier,
    Map<String, Map<String, MaterialOption>>>((ref) {
  return SelectedOptionsNotifier();
});

// Notifier to manage selected options
class SelectedOptionsNotifier
    extends StateNotifier<Map<String, Map<String, MaterialOption>>> {
  SelectedOptionsNotifier() : super({});

  void updateSelectedOption(
      String category, String materialType, MaterialOption option) {
    state = {
      ...state,
      category: {
        ...state[category] ?? {},
        materialType: option,
      }
    };
  }

  void reset() {
    state = {};
  }

  double calculateTotalCost(double area) {
    double total = 0.0;

    state.forEach((category, materialTypes) {
      materialTypes.forEach((type, option) {
        switch (option.unit) {
          case 'per sq ft':
            total += option.pricePerUnit * area;
            break;
          case 'flat rate':
            total += option.pricePerUnit;
            break;
          case 'per brick':
          case 'per bag':
            // You might want to add logic here to calculate based on area
            total += option.pricePerUnit * (area / 10); // Example calculation
            break;
          default:
            total += option.pricePerUnit;
        }
      });
    });

    return total;
  }
}

// Provider for total cost calculation
final totalCostProvider = Provider.family<double, double>((ref, area) {
  final selectedOptions = ref.watch(selectedOptionsProvider);
  final notifier = ref.read(selectedOptionsProvider.notifier);
  return notifier.calculateTotalCost(area);
});
