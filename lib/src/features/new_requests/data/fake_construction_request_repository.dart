// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:async';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_front_pk/src/constants/ktest_new_requests.dart';
import 'package:home_front_pk/src/features/new_requests/domain/request.dart';
import 'package:home_front_pk/src/utils/delay.dart';

class FakeConstructionRequestRepository {
  FakeConstructionRequestRepository({
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

final constructionRequestRepoProvider =
    Provider<FakeConstructionRequestRepository>((ref) {
  return FakeConstructionRequestRepository();
});

final constructionRequestListStreamProvider =
    StreamProvider.autoDispose<List<Request>>((ref) {
  final constructionRequestRepo = ref.watch(constructionRequestRepoProvider);
  return constructionRequestRepo.watchRequestList();
});

final constructionRequestListFutureProvider =
    FutureProvider.autoDispose<List<Request>>((ref) {
  final constructionRequestRepo = ref.watch(constructionRequestRepoProvider);

  return constructionRequestRepo.fetchRequestList();
});

final constructionRequestProvider =
    StreamProvider.family.autoDispose<Request?, String>((ref, id) {
  final constructionRequestRepo = ref.watch(constructionRequestRepoProvider);

  return constructionRequestRepo.watchRequest(id);
});
