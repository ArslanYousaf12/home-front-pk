// lib/data/repositories/firestore_repository.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:home_front_pk/src/features/user_job_post/domain/job_post_model.dart';

class FirestoreRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<String> createJobPost(JobPost jobPost) async {
    try {
      final docRef = await _firestore.collection('jobs').add(jobPost.toJson());
      return docRef.id;
    } catch (e) {
      throw Exception('Failed to create job post: $e');
    }
  }

  // Add this new method to get user's jobs
  Stream<List<JobPost>> getUserJobs(String userId) {
    return _firestore
        .collection('jobs')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => JobPost.fromJson(doc.data())).toList());
  }

  Stream<List<JobPost>> getJobPosts(String category) {
    return _firestore
        .collection('jobs')
        .where('category', isEqualTo: category)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => JobPost.fromJson(doc.data())).toList());
  }
}
