// profile_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'dart:io';

final profileRepositoryProvider = Provider<ProfileRepository>((ref) {
  return ProfileRepository();
});

final userProfileProvider =
    StreamProvider.autoDispose<Map<String, dynamic>>((ref) {
  final repository = ref.watch(profileRepositoryProvider);
  return repository.getUserProfile();
});

class ProfileRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final FirebaseStorage _storage = FirebaseStorage.instance;

  Stream<Map<String, dynamic>> getUserProfile() {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return Stream.value({});

    return _firestore
        .collection('users')
        .doc(userId)
        .snapshots()
        .map((doc) => doc.data() ?? {});
  }

  Future<void> updateProfile(Map<String, dynamic> data) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return;

    await _firestore.collection('users').doc(userId).update({
      ...data,
      'lastUpdated': Timestamp.now(),
    });
  }

  Future<String> uploadProfileImage(File image) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) throw Exception('User not found');

    final ref = _storage.ref().child('profile_images/$userId.jpg');
    await ref.putFile(image);
    return await ref.getDownloadURL();
  }
}
