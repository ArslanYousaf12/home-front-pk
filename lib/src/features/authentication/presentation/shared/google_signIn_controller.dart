import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_front_pk/src/features/authentication/data/auth_repository.dart';

class GoogleSigninController extends StateNotifier<AsyncValue> {
  GoogleSigninController({required this.authRepository})
      : super(const AsyncData(null));

  final AuthRepository authRepository;

  Future<bool> signInWithGoogle() async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => authRepository.signInWithGoogle());
    return state.hasError == false;
  }
}

final googleSigninControllerProvider =
    StateNotifierProvider<GoogleSigninController, AsyncValue>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return GoogleSigninController(
    authRepository: authRepository,
  );
});
