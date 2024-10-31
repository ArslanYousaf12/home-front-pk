// lib/data/repositories/firestore_repository.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:home_front_pk/src/features/user_job_post/domain/job_post_model.dart';

class FirestoreRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? get currentUserId => _auth.currentUser?.uid;

  Future<void> createJobPost(JobPost jobPost) async {
    try {
      if (currentUserId == null) {
        throw Exception('No user logged in');
      }

      // Create a new document reference
      final docRef = _firestore.collection('jobs').doc();

      // Update the job post with the document ID and current user ID
      final updatedJobPost = jobPost.copyWith(
        id: docRef.id,
        userId: currentUserId,
      );

      // Set the document data
      await docRef.set(updatedJobPost.toJson());
    } catch (e) {
      throw Exception('Failed to create job post: $e');
    }
  }

  Stream<List<JobPost>> getUserJobs(String userId) {
    return _firestore
        .collection('jobs')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => JobPost.fromJson({
                  ...doc.data(),
                  'id': doc.id, // Include the document ID
                }))
            .toList());
  }

  Stream<List<JobPost>> getJobPosts(String category) {
    return _firestore
        .collection('jobs')
        .where('category', isEqualTo: category)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => JobPost.fromJson({
                  ...doc.data(),
                  'id': doc.id, // Include the document ID
                }))
            .toList());
  }
}
