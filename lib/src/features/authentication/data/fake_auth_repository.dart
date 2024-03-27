import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_front_pk/src/features/authentication/domain/app_user.dart';
import 'package:home_front_pk/src/utils/in_memory_store.dart';

class FakeAuthRepository {
  final _authState = InMemoryStore<AppUser?>(null);
  Stream<AppUser?> authStateChange() => _authState.stream;

// used to get the current user synchronously
  AppUser? get currentUser => _authState.value;

  Future<void> signInWithEmailAndPassword(
      String email, String password, String role) async {
    if (currentUser == null) {
      createNewUser(email, role);
    }
  }

  Future<void> createUserWithEmailAndPassword(
      String email, String password, String role) async {
    if (currentUser == null) createNewUser(email, role);
  }

  Future<void> signOut() async {
    _authState.value = null;
  }

  void createNewUser(String email, String role) {
    _authState.value =
        AppUser(uid: email.split('').reversed.join(), email: email, role: role);
  }

  void dispose() => _authState.close();
}

final authRepositoryProvider = Provider<FakeAuthRepository>((ref) {
  final auth = FakeAuthRepository();
  ref.onDispose(
    () => auth.dispose(),
  );
  return auth;
});
final authStateChangeProvider = StreamProvider<AppUser?>((ref) {
  final fakeAuthRepository = ref.watch(authRepositoryProvider);
  return fakeAuthRepository.authStateChange();
});
