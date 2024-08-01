import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:home_front_pk/src/features/dashboard/domain/constructor.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'constructor_repository.g.dart';

class ConstructorRepository {
  const ConstructorRepository(this._firestore);
  final FirebaseFirestore _firestore;

  // TODO: Implement all methods using Cloud Firestore

  Future<List<ConstructorIslamabad>> fetchConstructorsList() {
    return Future.value([]);
  }

  Stream<List<ConstructorIslamabad>> watchConstructorsList() {
    return Stream.value([]);
  }

  Stream<ConstructorIslamabad?> watchConstructor(ConstructorID id) {
    return Stream.value(null);
  }

  Future<List<ConstructorIslamabad>> searchConstructors(String query) {
    return Future.value([]);
  }
}

@Riverpod(keepAlive: true)
ConstructorRepository constructorRepository(ConstructorRepositoryRef ref) {
  return ConstructorRepository(FirebaseFirestore.instance);
}

@riverpod
Stream<List<ConstructorIslamabad>> constructorsListStream(
    ConstructorsListStreamRef ref) {
  final constructorRepository = ref.watch(constructorRepositoryProvider);
  return constructorRepository.watchConstructorsList();
}

@riverpod
Future<List<ConstructorIslamabad>> constructorsListFuture(
    ConstructorsListFutureRef ref) {
  final constructorRepository = ref.watch(constructorRepositoryProvider);
  return constructorRepository.fetchConstructorsList();
}

@riverpod
Stream<ConstructorIslamabad?> constructor(
    ConstructorRef ref, ConstructorID id) {
  final constructorRepository = ref.watch(constructorRepositoryProvider);
  return constructorRepository.watchConstructor(id);
}

@riverpod
Future<List<ConstructorIslamabad>> constructorsListSearch(
    ConstructorsListSearchRef ref, String query) async {
  final link = ref.keepAlive();
  // a timer to be used by the callbacks below
  Timer? timer;
  // When the provider is destroyed, cancel the http request and the timer
  ref.onDispose(() {
    timer?.cancel();
  });
  // When the last listener is removed, start a timer to dispose the cached data
  ref.onCancel(() {
    // start a 30 second timer
    timer = Timer(const Duration(seconds: 30), () {
      // dispose on timeout
      link.close();
    });
  });
  // If the provider is listened again after it was paused, cancel the timer
  ref.onResume(() {
    timer?.cancel();
  });
  final constructorRepository = ref.watch(constructorRepositoryProvider);
  return constructorRepository.searchConstructors(query);
}
