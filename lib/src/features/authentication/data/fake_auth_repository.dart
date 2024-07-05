// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_front_pk/src/exceptions/app_exception.dart';

import 'package:home_front_pk/src/features/authentication/domain/app_user.dart';
import 'package:home_front_pk/src/features/authentication/domain/fake_app_user.dart';

import 'package:home_front_pk/src/utils/delay.dart';
import 'package:home_front_pk/src/utils/in_memory_store.dart';

class FakeAuthRepository {
  FakeAuthRepository({
    this.addDelay = true,
  });
  bool addDelay;
  final _authState = InMemoryStore<AppUser?>(null);
  Stream<AppUser?> authStateChange() => _authState.stream;

// used to get the current user synchronously
  AppUser? get currentUser => _authState.value;

// List to keep track of all user accounts
  final List<FakeAppUser> _users = [];

  Future<void> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    await delay(addDelay);
    // check the given credentials agains each registered user
    for (final u in _users) {
      // matching email and password
      if (u.email == email && u.password == password) {
        _authState.value = u;
        return;
      }
      // same email, wrong password
      if (u.email == email && u.password != password) {
        throw WrongPasswordException();
      }
    }
    throw UserNotFoundException();
  }

  Future<void> createUserWithEmailAndPassword(
    String email,
    String password,
  ) async {
    await delay(addDelay);
    // check if the email is already in use
    for (final u in _users) {
      if (u.email == email) {
        throw EmailAlreadyInUseException();
      }
    }
    // minimum password length requirement
    if (password.length < 8) {
      throw WeakPasswordException();
    }
    createNewUser(email, password);
  }

  Future<void> signOut() async {
    _authState.value = null;
  }

  void createNewUser(String email, String password) {
    // create new user
    final user = FakeAppUser(
      uid: email.split('').reversed.join(),
      email: email,
      password: password,
    );
    // register it
    _users.add(user);
    // update the auth state
    _authState.value = user;
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
