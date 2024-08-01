import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';

import 'package:home_front_pk/src/features/dashboard/domain/designer.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';
part 'designer_repository.g.dart';

class DesignerRepository {
  const DesignerRepository(this._firestore);
  final FirebaseFirestore _firestore;

  // TODO: Implement all methods using Cloud Firestore

  Future<List<DesignerIslamabad>> fetchDesignersList() {
    return Future.value([]);
  }

  Stream<List<DesignerIslamabad>> watchDesignersList() {
    return Stream.value([]);
  }

  Stream<DesignerIslamabad?> watchDesigner(DesignerID id) {
    return Stream.value(null);
  }

  Future<List<DesignerIslamabad>> searchDesigners(String query) {
    return Future.value([]);
  }
}

@Riverpod(keepAlive: true)
DesignerRepository designerRepository(DesignerRepositoryRef ref) {
  return DesignerRepository(FirebaseFirestore.instance);
}

@riverpod
Stream<List<DesignerIslamabad>> designersListStream(
    DesignersListStreamRef ref) {
  final designerRepository = ref.watch(designerRepositoryProvider);
  return designerRepository.watchDesignersList();
}

@riverpod
Future<List<DesignerIslamabad>> designersListFuture(
    DesignersListFutureRef ref) {
  final designerRepository = ref.watch(designerRepositoryProvider);
  return designerRepository.fetchDesignersList();
}

@riverpod
Stream<DesignerIslamabad?> designer(DesignerRef ref, DesignerID id) {
  final designerRepository = ref.watch(designerRepositoryProvider);
  return designerRepository.watchDesigner(id);
}

@riverpod
Future<List<DesignerIslamabad>> designersListSearch(
    DesignersListSearchRef ref, String query) async {
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
  final designerRepository = ref.watch(designerRepositoryProvider);
  return designerRepository.searchDesigners(query);
}
