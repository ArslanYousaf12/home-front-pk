@Timeout(Duration(milliseconds: 500))
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:home_front_pk/src/features/authentication/presentation/shared/email_password_sign_in_controller.dart';
import 'package:home_front_pk/src/features/authentication/presentation/sign_in/email_password_sign_in_state.dart';
import 'package:mocktail/mocktail.dart';

import '../../../../../mocks.dart';

void main() {
  const email = 'test@test.com';
  const password = '2333';
  late MockAuthRepository authRepository;
  late EmailPasswordSignInController sigInController;
  late EmailPasswordSignInController registerController;

  setUp(() {
    authRepository = MockAuthRepository();
    sigInController = EmailPasswordSignInController(
        formType: EmailPasswordSignInFormType.signIn,
        authRepository: authRepository);
    registerController = EmailPasswordSignInController(
        formType: EmailPasswordSignInFormType.register,
        authRepository: authRepository);
  });
  group('EmailPassword signin Controller', () {
    test(
      '''

    Given the Form as SignIn
    when signInWithEmailPassword successed
    return True
    and State is AsyncData(null)

    ''',
      () async {
        when(() => authRepository.signInWithEmailAndPassword(email, password))
            .thenAnswer((_) => Future.value());

        expectLater(
            sigInController.stream,
            emitsInOrder([
              EmailPasswordSignInState(
                  formType: EmailPasswordSignInFormType.signIn,
                  value: const AsyncLoading<void>()),
              EmailPasswordSignInState(
                  formType: EmailPasswordSignInFormType.signIn,
                  value: const AsyncData<void>(null)),
            ]));

        final result = await sigInController.submit(email, password);
        expect(result, true);
      },
      // timeout: const Timeout(Duration(milliseconds: 500)),
    );
    test(
      '''
      Given the form as signIn
      when SignInWithEmailPassword Fail
      return false
      and the state is AsyncError()

      ''',
      () async {
        final exception = Exception('connection Failed');
        when(() => authRepository.signInWithEmailAndPassword(email, password))
            .thenThrow(exception);
        expectLater(
          sigInController.stream,
          emitsInOrder(
            [
              EmailPasswordSignInState(
                  formType: EmailPasswordSignInFormType.signIn,
                  value: const AsyncLoading<void>()),
              predicate<EmailPasswordSignInState>((state) {
                expect(state.formType, EmailPasswordSignInFormType.signIn);
                expect(state.value.hasError, true);
                return true;
              }),
            ],
          ),
        );
        final result = await sigInController.submit(email, password);
        expect(result, false);
      },
    );
    test(
      '''

    Given the Form as Register
    when signInWithEmailPassword successed
    return True
    and State is AsyncData(null)

    ''',
      () async {
        when(() =>
                authRepository.createUserWithEmailAndPassword(email, password))
            .thenAnswer((_) => Future.value());

        expectLater(
            registerController.stream,
            emitsInOrder([
              EmailPasswordSignInState(
                  formType: EmailPasswordSignInFormType.register,
                  value: const AsyncLoading<void>()),
              EmailPasswordSignInState(
                  formType: EmailPasswordSignInFormType.register,
                  value: const AsyncData<void>(null)),
            ]));

        final result = await registerController.submit(email, password);
        expect(result, true);
      },
      // timeout: const Timeout(Duration(milliseconds: 500)),
    );
    test(
      '''
      Given the form as Register
      when SignInWithEmailPassword Fail
      return false
      and the state is AsyncError()

      ''',
      () async {
        final exception = Exception('connection Failed');
        when(() => authRepository.signInWithEmailAndPassword(email, password))
            .thenThrow(exception);
        expectLater(
          registerController.stream,
          emitsInOrder(
            [
              EmailPasswordSignInState(
                  formType: EmailPasswordSignInFormType.register,
                  value: const AsyncLoading<void>()),
              predicate<EmailPasswordSignInState>((state) {
                expect(state.formType, EmailPasswordSignInFormType.register);
                expect(state.value.hasError, true);
                return true;
              }),
            ],
          ),
        );
        final result = await registerController.submit(email, password);
        expect(result, false);
      },
      //  timeout: const Timeout(Duration(milliseconds: 500)
      //  )
    );
  });
}
