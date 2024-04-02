import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_front_pk/src/features/authentication/data/fake_auth_repository.dart';
import 'package:home_front_pk/src/features/authentication/presentation/sign_in/email_password_sign_in_state.dart';

class EmailPasswordSignInController
    extends StateNotifier<EmailPasswordSignInState> {
  EmailPasswordSignInController(
      {required EmailPasswordSignInFormType formType,
      required this.role,
      required this.authRepository})
      : super(
          EmailPasswordSignInState(formType: formType),
        );

  final FakeAuthRepository authRepository;
  final Role role;

  Future<bool> submit(String email, String password, Role role) async {
    state = state.copyWith(value: const AsyncValue.loading());
    final value =
        await AsyncValue.guard(() => authenticate(email, password, role));
    state = state.copyWith(value: value);
    return value.hasError == false;
  }

  Future<void> authenticate(String email, String password, role) {
    switch (state.formType) {
      case EmailPasswordSignInFormType.signIn:
        return authRepository.signInWithEmailAndPassword(email, password, role);
      case EmailPasswordSignInFormType.register:
        return authRepository.createUserWithEmailAndPassword(
            email, password, role);
    }
  }
}

class EmailSignInParams {
  final EmailPasswordSignInFormType formType;
  final Role role;

  EmailSignInParams(this.formType, this.role);
}

final emailPasswordSignInControllerProvider = StateNotifierProvider.autoDispose
    .family<EmailPasswordSignInController, EmailPasswordSignInState,
        EmailSignInParams>(
  (ref, params) {
    final authRepository = ref.watch(authRepositoryProvider);
    // Now, params contains both the formType and role
    return EmailPasswordSignInController(
      formType: params.formType,
      role: params.role,
      authRepository: authRepository,
    );
  },
);
