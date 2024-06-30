// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:home_front_pk/src/features/authentication/domain/app_user.dart';

class AuthRepository {
  AuthRepository({
    required FirebaseAuth auth,
  }) : _auth = auth;
  final FirebaseAuth _auth;

// List to keep track of all user accounts

  Future<void> signInWithEmailAndPassword(
    String email,
    String password,
  ) =>
      _auth.signInWithEmailAndPassword(email: email, password: password);

  Future<void> createUserWithEmailAndPassword(
    String email,
    String password,
  ) =>
      _auth.createUserWithEmailAndPassword(email: email, password: password);

  Future<void> signOut() => _auth.signOut();

  AppUser? converUser(User? user) {
    return user != null ? AppUser(uid: user.uid, email: user.email) : null;
  }

  Stream<AppUser?> authStateChange() =>
      _auth.authStateChanges().map(converUser);

// used to get the current user synchronously
  AppUser? get currentUser => converUser(_auth.currentUser);
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final auth = AuthRepository(auth: FirebaseAuth.instance);
  return auth;
});
final authStateChangeProvider = StreamProvider<AppUser?>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.authStateChange();
});
