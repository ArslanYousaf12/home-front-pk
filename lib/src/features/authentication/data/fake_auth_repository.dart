import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_front_pk/src/features/authentication/domain/app_user.dart';
import 'package:home_front_pk/src/utils/in_memory_store.dart';

class ClientFakeAuthRepository {
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

final clientAuthRepositoryProvider = Provider<ClientFakeAuthRepository>((ref) {
  final auth = ClientFakeAuthRepository();
  ref.onDispose(
    () => auth.dispose(),
  );
  return auth;
});
final clientAuthStateChangeProvider = StreamProvider<AppUser?>((ref) {
  final clientFakeAuthRepository = ref.watch(clientAuthRepositoryProvider);
  return clientFakeAuthRepository.authStateChange();
});
