import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_front_pk/src/features/cost_calculator/data/cost_calculator_repo.dart';
import 'package:home_front_pk/src/features/cost_calculator/domain/construction_cost_model.dart';

// Selected options notifier
class SelectedOptionsNotifier
    extends StateNotifier<Map<String, Map<String, MaterialOption>>> {
  SelectedOptionsNotifier() : super({});

  void initializeDefaultSelections(ConstructionCostsModel model) {
    final defaultSelections = <String, Map<String, MaterialOption>>{};

    // Initialize with first option from each category and material type
    model.categories.forEach((categoryName, category) {
      defaultSelections[categoryName] = {};

      category.materialTypes.forEach((typeName, materialType) {
        if (materialType.materials.isNotEmpty) {
          defaultSelections[categoryName]![typeName] =
              materialType.materials.first;
        }
      });
    });

    state = defaultSelections;
  }

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

  MaterialOption? getSelectedOption(String category, String materialType) {
    return state[category]?[materialType];
  }

  void reset() {
    state = {};
  }
}

// Provider for selected options with auto-selection
final selectedOptionsProvider = StateNotifierProvider<SelectedOptionsNotifier,
    Map<String, Map<String, MaterialOption>>>((ref) {
  final notifier = SelectedOptionsNotifier();

  // Listen to the cost data and initialize selections when it's available
  ref.listen<AsyncValue<ConstructionCostsModel>>(
    fetchCostProvider,
    (previous, next) {
      next.whenData((model) {
        notifier.initializeDefaultSelections(model);
      });
    },
  );

  return notifier;
});

// Combined provider for costs and selections
final constructionDataProvider = Provider<
    AsyncValue<
        (
          ConstructionCostsModel,
          Map<String, Map<String, MaterialOption>>
        )>>((ref) {
  final costsAsync = ref.watch(fetchCostProvider);
  final selections = ref.watch(selectedOptionsProvider);

  return costsAsync.whenData((costs) => (costs, selections));
});
