import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:home_front_pk/src/features/authentication/data/firbase_app_user.dart';
import 'package:home_front_pk/src/features/authentication/domain/app_user.dart';

class AuthRepository {
  AuthRepository({
    required FirebaseAuth auth,
    required FirebaseFirestore firestore,
  })  : _auth = auth,
        _firestore = firestore;

  final FirebaseAuth _auth;
  final FirebaseFirestore _firestore;

  Future<void> createUserWithEmailAndPassword(
    String email,
    String password,
    String role, // Add role parameter
  ) async {
    UserCredential userCredential = await _auth.createUserWithEmailAndPassword(
      email: email,
      password: password,
    );
    // Store user role in Firestore
    await _firestore.collection('users').doc(userCredential.user!.uid).set({
      'email': email,
      'role': role,
    });
  }

  Future<void> signInWithEmailAndPassword(
    String email,
    String password,
  ) async {
    final credential = await _auth.signInWithEmailAndPassword(
        email: email, password: password);
    print('sigin');
    print(credential);
  }

  Future<void> signInWithGoogle() async {
    final googleUser = await GoogleSignIn().signIn();
    final googleAuth = await googleUser!.authentication;
    final cred = GoogleAuthProvider.credential(
      idToken: googleAuth.idToken,
      accessToken: googleAuth.accessToken,
    );
    await _auth.signInWithCredential(cred);
  }

  Future<void> sendPasswordResetLink(String email) async {
    await _auth.sendPasswordResetEmail(email: email);
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  /// Helper method to convert a [User] to an [AppUser]
  AppUser? _convertUser(User? user) =>
      user != null ? FirebaseAppUser(user) : null;

  Stream<AppUser?> authStateChange() =>
      _auth.authStateChanges().map(_convertUser);

  AppUser? get currentUser => _convertUser(_auth.currentUser);

  Future<String?> getUserRole(String uid) async {
    DocumentSnapshot doc = await _firestore.collection('users').doc(uid).get();
    return doc['role'];
  }
}

final authRepositoryProvider = Provider<AuthRepository>((ref) {
  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  return AuthRepository(auth: auth, firestore: firestore);
});

final authStateChangeProvider = StreamProvider<AppUser?>((ref) {
  final authRepository = ref.watch(authRepositoryProvider);
  return authRepository.authStateChange();
});

final userRoleProvider = FutureProvider<String?>((ref) async {
  final authRepository = ref.watch(authRepositoryProvider);
  final user = authRepository.currentUser;
  if (user != null) {
    return await authRepository.getUserRole(user.uid);
  }
  return null;
});
