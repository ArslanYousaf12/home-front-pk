// ongoing_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

final ongoingRepositoryProvider = Provider<OngoingRepository>((ref) {
  return OngoingRepository();
});

final ongoingProjectsProvider =
    StreamProvider.autoDispose<List<Map<String, dynamic>>>((ref) {
  final repository = ref.watch(ongoingRepositoryProvider);
  return repository.getOngoingProjects();
});

class OngoingRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  Stream<List<Map<String, dynamic>>> getOngoingProjects() {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return Stream.value([]);

    return _firestore
        .collection('projects')
        .where('userId', isEqualTo: userId)
        .where('status', whereIn: ['ongoing', 'pending'])
        .orderBy('startDate', descending: true)
        .snapshots()
        .map((snapshot) {
          return snapshot.docs.map((doc) {
            final data = doc.data();
            return {
              'id': doc.id,
              ...data,
            };
          }).toList();
        });
  }

  Future<void> updateProjectStatus(String projectId, String status) async {
    await _firestore.collection('projects').doc(projectId).update({
      'status': status,
      'lastUpdated': Timestamp.now(),
    });
  }

  Future<void> updateMilestone(
      String projectId, String milestoneId, bool completed) async {
    await _firestore
        .collection('projects')
        .doc(projectId)
        .collection('milestones')
        .doc(milestoneId)
        .update({
      'completed': completed,
      'completedAt': completed ? Timestamp.now() : null,
    });
  }
}
