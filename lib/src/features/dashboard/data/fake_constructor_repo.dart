import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_front_pk/src/constants/ktest_constructor_card.dart';
import 'package:home_front_pk/src/features/dashboard/domain/constructor.dart';

class FakeConstructorRepository {
  //private constructor so object can not be initiated outside
  // of this class

  //Removing Singleton and Adding Riverpod for
  //Performance and testing purpose

  // FakeConstructorRepository._();

  //Singleton to solve the issue of
  //Dependancy Injection Problem
  //Changed later
  // static FakeConstructorRepository instance = FakeConstructorRepository._();
  final List<ConstructorIslamabad> _constructorList = ktestConstructor;

  List<ConstructorIslamabad> getConstructorList() {
    return _constructorList;
  }

  //      Incase if we need Construcor bases of Id

  ConstructorIslamabad? getConstructor(String id) {
    try {
      return _constructorList.firstWhere((constructor) => constructor.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<List<ConstructorIslamabad>> fetchConstructorList() {
    return Future.value(_constructorList);
  }

  Stream<List<ConstructorIslamabad>> watchConstructorList() {
    return Stream.value(_constructorList);
  }

  // Getting constructor base on id

  Stream<ConstructorIslamabad?> watchConstructor(String id) {
    return watchConstructorList().map((constructorList) =>
        constructorList.firstWhere((constructor) => constructor.id == id));
  }
}

final constructorRepositoryProvider =
    Provider<FakeConstructorRepository>((ref) {
  return FakeConstructorRepository();
});

final constructorsListFutureProvider =
    FutureProvider.autoDispose<List<ConstructorIslamabad>>((ref) {
  final constructorRepository = ref.watch(constructorRepositoryProvider);

  return constructorRepository.fetchConstructorList();
});

final constructorsListStreamProvider =
    StreamProvider.autoDispose<List<ConstructorIslamabad>>((ref) {
  final constructorRepository = ref.watch(constructorRepositoryProvider);
  return constructorRepository.watchConstructorList();
});

final constructorProvider =
    StreamProvider.autoDispose.family<ConstructorIslamabad?, String>((ref, id) {
  final constructorRepository = ref.watch(constructorRepositoryProvider);
  return constructorRepository.watchConstructor(id);
});
