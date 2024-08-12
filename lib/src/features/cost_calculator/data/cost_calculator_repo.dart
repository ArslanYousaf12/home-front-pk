import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_front_pk/src/features/cost_calculator/domain/construction_cost_model.dart';

class CostCalculatorRepo {
  CostCalculatorRepo({required FirebaseFirestore firestore})
      : _firestore = firestore;
  final FirebaseFirestore _firestore;

  Future<ConstructionCostsModel> fetchConstructionCost() async {
    final ref = _firestore.collection('costs').doc('materials').withConverter(
        fromFirestore: (doc, options) =>
            ConstructionCostsModel.fromMap(doc.data()!),
        toFirestore: (ConstructionCostsModel value, options) => value.toMap());
    final snapshot = await ref.get();

    return snapshot.data()!;
  }
}

final costCalculatorRepoProvider = Provider<CostCalculatorRepo>((ref) {
  return CostCalculatorRepo(firestore: FirebaseFirestore.instance);
});

final fetchcostProvider = FutureProvider<ConstructionCostsModel>((ref) async {
  final repo = ref.watch(costCalculatorRepoProvider);
  return await repo.fetchConstructionCost();
});
