// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_front_pk/src/constants/ktest_new_requests.dart';
import 'package:home_front_pk/src/features/new_requests/domain/request.dart';
import 'package:home_front_pk/src/utils/delay.dart';

class FakeDesignRequestRepository {
  FakeDesignRequestRepository({
    this.addDelay = true,
  });
  bool addDelay;

  final List<Request> _newRequests = ktestserviceRequests;

  List<Request> getRequestList() {
    return _newRequests;
  }

  Request? getRequest(String id) {
    return _getRequest(_newRequests, id);
  }

  Future<List<Request>> fetchRequestList() async {
    await delay(addDelay);
    return Future.value(_newRequests);
  }

  Stream<List<Request>> watchRequestList() async* {
    await delay(addDelay);
    yield _newRequests;
  }

  Stream<Request?> watchRequest(String id) {
    return watchRequestList().map((newRequests) {
      return _getRequest(newRequests, id);
    });
  }

  static Request? _getRequest(List<Request> newRequests, String id) {
    try {
      return newRequests.firstWhere((request) => request.id == id);
    } catch (e) {
      return null;
    }
  }
}

final designRequestRepoProvider = Provider<FakeDesignRequestRepository>((ref) {
  return FakeDesignRequestRepository();
});

final designRequestListStreamProvider =
    StreamProvider.autoDispose<List<Request>>((ref) {
  final designRequestRepo = ref.watch(designRequestRepoProvider);
  return designRequestRepo.watchRequestList();
});

final designRequestListFutureProvider =
    FutureProvider.autoDispose<List<Request>>((ref) {
  final designRequestRepo = ref.watch(designRequestRepoProvider);

  return designRequestRepo.fetchRequestList();
});

final designRequestProvider =
    StreamProvider.family.autoDispose<Request?, String>((ref, id) {
  final designRequestRepo = ref.watch(designRequestRepoProvider);

  return designRequestRepo.watchRequest(id);
});
