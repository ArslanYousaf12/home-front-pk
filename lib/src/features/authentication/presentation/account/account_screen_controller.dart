import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_front_pk/src/features/authentication/data/auth_repository.dart';
import 'package:home_front_pk/src/features/authentication/domain/app_user.dart';

class AccountScreenController extends StateNotifier<AsyncValue<void>> {
  AccountScreenController({required this.authRepository})
      : super(const AsyncData(null));

  final AuthRepository authRepository;

  Future<bool> signOut() async {
    // try {
    //   state = const AsyncValue<void>.loading();
    //   await authRepository.signOut();
    //   state = const AsyncValue.data(null);
    //   return true;
    // } catch (e, st) {
    //   state = AsyncValue.error(e, st);
    //   return false;
    // }
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => authRepository.signOut());
    return state.hasError == false;
  }

  Future<bool> sendEmailVerification(AppUser user) async {
    state = const AsyncLoading();
    state = await AsyncValue.guard(() => user.sendEmailVerification());
    return state.hasError == false;
  }
}

final accountScreenControllerProvider =
    StateNotifierProvider<AccountScreenController, AsyncValue<void>>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return AccountScreenController(authRepository: authRepository);
});
