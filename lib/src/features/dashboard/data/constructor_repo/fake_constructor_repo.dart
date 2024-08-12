// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:home_front_pk/src/constants/ktest_constructor_card.dart';
import 'package:home_front_pk/src/features/dashboard/data/constructor_repo/constructor_repository.dart';
import 'package:home_front_pk/src/features/dashboard/domain/constructor.dart';
import 'package:home_front_pk/src/utils/delay.dart';

class FakeConstructorRepository implements ConstructorRepository {
  FakeConstructorRepository({
    this.addDelay = true,
  });
  bool addDelay;
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
    return _getConstructor(_constructorList, id);
  }

  Future<List<ConstructorIslamabad>> fetchConstructorList() async {
    await delay(addDelay);
    return Future.value(_constructorList);
  }

  Stream<List<ConstructorIslamabad>> watchConstructorList() async* {
    await delay(addDelay);
    yield _constructorList;
  }

  // Getting constructor base on id

  Stream<ConstructorIslamabad?> watchConstructor(String id) {
    return watchConstructorList()
        .map((constructorList) => _getConstructor(constructorList, id));
  }

  static ConstructorIslamabad? _getConstructor(
      List<ConstructorIslamabad> constructors, String id) {
    try {
      return constructors.firstWhere((constructor) => constructor.id == id);
    } catch (e) {
      return null;
    }
  }

  @override
  Future<void> createConstructor(ConstructorID id, String imageUrl) {
    // TODO: implement createConstructor
    throw UnimplementedError();
  }

  @override
  Future<List<ConstructorIslamabad>> fetchConstructorsList() {
    // TODO: implement fetchConstructorsList
    throw UnimplementedError();
  }

  @override
  Future<List<ConstructorIslamabad>> searchConstructors(String query) {
    // TODO: implement searchConstructors
    throw UnimplementedError();
  }

  @override
  Stream<List<ConstructorIslamabad>> watchConstructorsList() {
    // TODO: implement watchConstructorsList
    throw UnimplementedError();
  }

  @override
  Future<void> updateConstructor(ConstructorIslamabad constructor) {
    // TODO: implement updateConstructor
    throw UnimplementedError();
  }

  @override
  Future<void> deleteConstructor(ConstructorID id) {
    // TODO: implement deleteConstructor
    throw UnimplementedError();
  }

  @override
  Future<ConstructorIslamabad?> fetchConstructor(ConstructorID id) {
    // TODO: implement fetchConstructor
    throw UnimplementedError();
  }
}

// final constructorRepositoryProvider =
//     Provider<FakeConstructorRepository>((ref) {
//   return FakeConstructorRepository();
// });

// final constructorsListFutureProvider =
//     FutureProvider.autoDispose<List<ConstructorIslamabad>>((ref) {
//   final constructorRepository = ref.watch(constructorRepositoryProvider);

//   return constructorRepository.fetchConstructorList();
// });

// final constructorsListStreamProvider =
//     StreamProvider.autoDispose<List<ConstructorIslamabad>>((ref) {
//   final constructorRepository = ref.watch(constructorRepositoryProvider);
//   return constructorRepository.watchConstructorList();
// });

// final constructorProvider =
//     StreamProvider.autoDispose.family<ConstructorIslamabad?, String>((ref, id) {
//   final constructorRepository = ref.watch(constructorRepositoryProvider);
//   return constructorRepository.watchConstructor(id);
// });
