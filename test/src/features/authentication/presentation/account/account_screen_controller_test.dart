
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_front_pk/src/features/authentication/presentation/account/account_screen_controller.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../mocks.dart';

void main() {
  late MockAuthRepository authRepository;
  late AccountScreenController controller;
  setUp(() {
    authRepository = MockAuthRepository();
    controller = AccountScreenController(authRepository: authRepository);
  });
  group('AccountScreenController', () {
    test('initial state is AsyncValue.data', () {
      verifyNever(authRepository.signOut);
      expect(controller.state, const AsyncData<void>(null));
    });
    test('SignOut is sucess', () async {
      //setup

      when(authRepository.signOut).thenAnswer((_) => Future.value());

      //Expect Later
      //for checking AsyncLoading,
      // and AsyncData
      expectLater(
          controller.stream,
          emitsInOrder(const [
            AsyncLoading<void>(),
            AsyncData<void>(null),
          ]));
      //run
      await controller.signOut();

      //verify
      verify(authRepository.signOut).called(1);
      // expect(controller.state, const AsyncData<void>(null));
    }, timeout: const Timeout(Duration(milliseconds: 500)));
    test('SignOut is Fail', () async {
      //setup

      final exception = Exception('Connection Failed');
      when(authRepository.signOut).thenThrow(exception);

      //for checking AsyncLoading,
      // and AsyncData
      expectLater(
          controller.stream,
          emitsInOrder([
            const AsyncLoading<void>(),
            predicate<AsyncError<void>>((value) {
              expect(value.hasError, true);
              return true;
            }),
          ]));

      //run
      await controller.signOut();

      //verify
      verify(authRepository.signOut).called(1);
      // expect(controller.state, isA<AsyncError>());
      // expect(controller.state.hasError, true);
    }, timeout: const Timeout(Duration(milliseconds: 500)));
  });
}
