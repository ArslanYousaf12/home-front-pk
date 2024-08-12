import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:home_front_pk/src/features/dashboard/domain/constructor.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'constructor_repository.g.dart';

class ConstructorRepository {
  const ConstructorRepository(this._firestore);
  final FirebaseFirestore _firestore;

  static String constructorsPath() => 'constructors';
  static String constructorPath(ConstructorID id) => 'constructors/$id';

  Future<List<ConstructorIslamabad>> fetchConstructorsList() async {
    final ref = _constructorsRef();
    final snapshot = await ref.get();
    return snapshot.docs.map((docSnapshot) => docSnapshot.data()).toList();
  }

  Stream<List<ConstructorIslamabad>> watchConstructorList() {
    final ref = _constructorsRef();
    return ref.snapshots().map((snapshot) =>
        snapshot.docs.map((docSnapshot) => docSnapshot.data()).toList());
  }

  Stream<ConstructorIslamabad?> watchConstructor(ConstructorID id) {
    final ref = _constructorRef(id);
    return ref.snapshots().map((snapshot) => snapshot.data());
  }

  Future<ConstructorIslamabad?> fetchConstructor(ConstructorID id) async {
    final ref = _constructorRef(id);
    final snapshot = await ref.get();
    return snapshot.data();
  }

  DocumentReference<ConstructorIslamabad> _constructorRef(ConstructorID id) =>
      _firestore.doc(constructorPath(id)).withConverter(
            fromFirestore: (doc, _) =>
                ConstructorIslamabad.fromMap(doc.data()!),
            toFirestore: (ConstructorIslamabad constructor, options) =>
                constructor.toMap(),
          );

  Query<ConstructorIslamabad> _constructorsRef() => _firestore
      .collection(constructorsPath())
      .withConverter(
        fromFirestore: (doc, _) => ConstructorIslamabad.fromMap(doc.data()!),
        toFirestore: (ConstructorIslamabad constructor, options) =>
            constructor.toMap(),
      )
      .orderBy('id');

  // * Temporary search implementation.
  // * Note: this is quite inefficient as it pulls the entire product list
  // * and then filters the data on the client

  Future<List<ConstructorIslamabad>> searchConstructors(String query) async {
    // 1. Get all products from Firestore
    final constrctorsList = await fetchConstructorsList();
    // 2. Perform client-side filtering
    return constrctorsList
        .where((constructor) =>
            constructor.title.toLowerCase().contains(query.toLowerCase()))
        .toList();
  }

  Future<void> createConstructor(ConstructorID id, String imageUrl) {
    return _firestore.doc('constructors/$id').set({
      'id': id,
      'imageUrl': imageUrl,
    }, SetOptions(merge: true));
  }

  Future<void> updateConstructor(ConstructorIslamabad constructor) {
    final ref = _constructorRef(constructor.id);
    return ref.set(constructor);
  }

  Future<void> deleteConstructor(ConstructorID id) {
    return _firestore.doc(constructorPath(id)).delete();
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
  return constructorRepository.watchConstructorList();
}

@riverpod
Future<List<ConstructorIslamabad>> constructorsListFuture(
    ConstructorsListFutureRef ref) {
  final constructorRepository = ref.watch(constructorRepositoryProvider);
  return constructorRepository.fetchConstructorsList();
}

@riverpod
Future<ConstructorIslamabad?> constructorFuture(
    ConstructorFutureRef ref, ConstructorID id) {
  final productsRepository = ref.watch(constructorRepositoryProvider);
  return productsRepository.fetchConstructor(id);
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
