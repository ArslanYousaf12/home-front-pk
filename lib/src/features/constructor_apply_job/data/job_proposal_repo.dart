import 'dart:io';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:home_front_pk/src/features/constructor_apply_job/domain/constructor_job.dart';
import 'package:home_front_pk/src/features/user_job_post/data/image_upload_repo.dart';

class JobProposalRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final StorageRepository _storageRepository;

  JobProposalRepository({required StorageRepository storageRepository})
      : _storageRepository = storageRepository;

  String? get currentUserId => _auth.currentUser?.uid;

  Future<void> submitProposal(
      JobProposal proposal, List<File> attachments) async {
    try {
      if (currentUserId == null) {
        throw Exception('No user logged in');
      }

      // Upload attachments if any
      List<String> attachmentUrls = [];
      if (attachments.isNotEmpty) {
        attachmentUrls = await _storageRepository.uploadJobImages(
          attachments,
          'proposals/${proposal.jobId}',
        );
      }

      // Create a new document reference
      final docRef = _firestore.collection('proposals').doc();

      // Update the proposal with the document ID and attachments
      final updatedProposal = proposal.copyWith(
        id: docRef.id,
        constructorId: currentUserId,
        attachments: attachmentUrls,
      );

      // Set the document data
      await docRef.set(updatedProposal.toJson());
    } catch (e) {
      throw Exception('Failed to submit proposal: $e');
    }
  }

  Stream<List<JobProposal>> getConstructorProposals(String constructorId) {
    return _firestore
        .collection('proposals')
        .where('constructorId', isEqualTo: constructorId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => JobProposal.fromJson({
                  ...doc.data(),
                  'id': doc.id,
                }))
            .toList());
  }

  Stream<List<JobProposal>> getJobProposals(String jobId) {
    return _firestore
        .collection('proposals')
        .where('jobId', isEqualTo: jobId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => JobProposal.fromJson({
                  ...doc.data(),
                  'id': doc.id,
                }))
            .toList());
  }

  Future<void> updateProposalStatus(String proposalId, String status) async {
    try {
      await _firestore.collection('proposals').doc(proposalId).update({
        'status': status,
      });
    } catch (e) {
      throw Exception('Failed to update proposal status: $e');
    }
  }

  Future<void> updateMilestoneStatus(
      String proposalId, int milestoneIndex, String status) async {
    try {
      DocumentSnapshot doc =
          await _firestore.collection('proposals').doc(proposalId).get();

      if (!doc.exists) {
        throw Exception('Proposal not found');
      }

      JobProposal proposal = JobProposal.fromJson({
        ...doc.data() as Map<String, dynamic>,
        'id': doc.id,
      });

      List<Milestone> updatedMilestones = [...proposal.milestones];
      if (milestoneIndex < updatedMilestones.length) {
        Milestone milestone = updatedMilestones[milestoneIndex];
        updatedMilestones[milestoneIndex] = Milestone(
          title: milestone.title,
          description: milestone.description,
          amount: milestone.amount,
          daysToComplete: milestone.daysToComplete,
          status: status,
        );

        await doc.reference.update({
          'milestones': updatedMilestones.map((m) => m.toJson()).toList(),
        });
      }
    } catch (e) {
      throw Exception('Failed to update milestone status: $e');
    }
  }
}
