import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_front_pk/src/features/authentication/data/auth_repository.dart';

import 'package:home_front_pk/src/features/authentication/presentation/sign_in/email_password_sign_in_state.dart';

class EmailPasswordSignInController
    extends StateNotifier<EmailPasswordSignInState> {
  EmailPasswordSignInController(
      {required EmailPasswordSignInFormType formType,
      required this.authRepository})
      : super(
          EmailPasswordSignInState(formType: formType),
        );

  final AuthRepository authRepository;

  Future<bool> submit(
    String email,
    String password,
  ) async {
    state = state.copyWith(value: const AsyncValue.loading());
    final value = await AsyncValue.guard(() => authenticate(
          email,
          password,
        ));
    state = state.copyWith(value: value);
    return value.hasError == false;
  }

  Future<void> authenticate(
    String email,
    String password,
  ) {
    switch (state.formType) {
      case EmailPasswordSignInFormType.signIn:
        return authRepository.signInWithEmailAndPassword(
          email,
          password,
        );
      case EmailPasswordSignInFormType.register:
        return authRepository.createUserWithEmailAndPassword(
          email,
          password,
        );
    }
  }
}

final emailPasswordSignInControllerProvider = StateNotifierProvider.autoDispose
    .family<EmailPasswordSignInController, EmailPasswordSignInState,
        EmailPasswordSignInFormType>(
  (ref, formType) {
    final authRepository = ref.watch(authRepositoryProvider);
    // Now, params contains both the formType and role
    return EmailPasswordSignInController(
      formType: formType,
      authRepository: authRepository,
    );
  },
);
