import 'package:flutter_test/flutter_test.dart';
import 'package:home_front_pk/src/constants/ktest_new_requests.dart';
import 'package:home_front_pk/src/features/new_requests/data/fake_design_request_repository.dart';

void main() {
  FakeDesignRequestRepository makeRequestRepo() =>
      FakeDesignRequestRepository(addDelay: false);
  group('Fake design Request Repo', () {
    test('getRequestList return global list', () {
      final requestRepo = makeRequestRepo();
      expect(requestRepo.getRequestList(), ktestserviceRequests);
    });
    test('getRequest(1) return first item', () {
      final requestRepo = makeRequestRepo();
      expect(requestRepo.getRequest('1'), ktestserviceRequests[0]);
    });
    test('getRequest(100) return null', () {
      final requestRepo = makeRequestRepo();
      expect(requestRepo.getRequest('100'), null);
    });
    test('fetchRequestList return global list', () async {
      final requestRepo = makeRequestRepo();
      expect(await requestRepo.fetchRequestList(), ktestserviceRequests);
    });
    test('watchRequestList return global list', () {
      final requestRepo = makeRequestRepo();
      expect(requestRepo.watchRequestList(), emits(ktestserviceRequests));
    });
    test('watchRequest(1) return first item', () {
      final requestRepo = makeRequestRepo();
      expect(requestRepo.watchRequest('1'), emits(ktestserviceRequests[0]));
    });
    test('watchRequest(100) return null', () {
      final requestRepo = makeRequestRepo();
      expect(requestRepo.watchRequest('100'), emits(null));
    });
  });
}
