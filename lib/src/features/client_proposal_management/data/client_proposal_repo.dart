import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:home_front_pk/src/features/client_proposal_management/data/client_proposal_controller.dart';
import 'package:home_front_pk/src/features/client_proposal_management/domain/chat_message.dart';
import 'package:home_front_pk/src/features/client_proposal_management/domain/client_proposal_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

class ClientProposalRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  String? get currentUserId => _auth.currentUser?.uid;

  // Get all proposals for a specific job
  Stream<List<ClientProposal>> getJobProposals(String jobId) {
    return _firestore
        .collection('proposals')
        .where('jobId', isEqualTo: jobId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .asyncMap((snapshot) async {
      List<ClientProposal> proposals = [];
      for (var doc in snapshot.docs) {
        // Get constructor details
        final constructorDoc = await _firestore
            .collection('users')
            .doc(doc.data()['constructorId'])
            .get();

        if (constructorDoc.exists) {
          final constructorData = constructorDoc.data()!;
          final proposal = ClientProposal.fromJson({
            ...doc.data(),
            'id': doc.id,
            'constructorDetails': constructorData,
          });
          proposals.add(proposal);
        }
      }
      return proposals;
    });
  }

  Future<void> acceptProposal(String jobId, String proposalId) async {
    try {
      // First get all pending proposals for this job
      final proposalsQuery = await _firestore
          .collection('proposals')
          .where('jobId', isEqualTo: jobId)
          .where('status', isEqualTo: 'pending')
          .get();

      // Start the batch write
      final batch = _firestore.batch();

      // Update the accepted proposal
      batch.update(
        _firestore.collection('proposals').doc(proposalId),
        {
          'status': 'accepted',
          'respondedAt': DateTime.now().toIso8601String(),
        },
      );

      // Reject all other proposals
      for (var doc in proposalsQuery.docs) {
        if (doc.id != proposalId) {
          batch.update(
            doc.reference,
            {
              'status': 'rejected',
              'respondedAt': DateTime.now().toIso8601String(),
            },
          );
        }
      }

      // Update job status
      batch.update(
        _firestore.collection('jobs').doc(jobId),
        {
          'status': 'in_progress',
          'acceptedProposalId': proposalId,
        },
      );

      // Commit the batch
      await batch.commit();
    } catch (e) {
      throw Exception('Failed to accept proposal: $e');
    }
  }

  // Optional: If you need to get all proposals for a job
  Future<List<ClientProposal>> getAllProposalsForJob(String jobId) async {
    try {
      final querySnapshot = await _firestore
          .collection('proposals')
          .where('jobId', isEqualTo: jobId)
          .get();

      List<ClientProposal> proposals = [];
      for (var doc in querySnapshot.docs) {
        final constructorDoc = await _firestore
            .collection('users')
            .doc(doc.data()['constructorId'])
            .get();

        if (constructorDoc.exists) {
          proposals.add(
            ClientProposal.fromJson({
              ...doc.data(),
              'id': doc.id,
              'constructorDetails': constructorDoc.data(),
            }),
          );
        }
      }

      return proposals;
    } catch (e) {
      throw Exception('Failed to get proposals: $e');
    }
  }

  // Reject a proposal
  Future<void> rejectProposal(String proposalId, {String? reason}) async {
    try {
      await _firestore.collection('proposals').doc(proposalId).update({
        'status': 'rejected',
        'clientResponse': reason,
        'respondedAt': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      throw Exception('Failed to reject proposal: $e');
    }
  }

  // Get all proposals for current client's jobs
  Stream<Map<String, List<ClientProposal>>> getAllJobProposals() {
    if (currentUserId == null) {
      throw Exception('No user logged in');
    }

    return _firestore
        .collection('jobs')
        .where('userId', isEqualTo: currentUserId)
        .snapshots()
        .asyncMap((jobsSnapshot) async {
      Map<String, List<ClientProposal>> allProposals = {};

      for (var jobDoc in jobsSnapshot.docs) {
        final proposals = await _firestore
            .collection('proposals')
            .where('jobId', isEqualTo: jobDoc.id)
            .get();

        List<ClientProposal> jobProposals = [];
        for (var proposalDoc in proposals.docs) {
          final constructorDoc = await _firestore
              .collection('users')
              .doc(proposalDoc.data()['constructorId'])
              .get();

          if (constructorDoc.exists) {
            final proposal = ClientProposal.fromJson({
              ...proposalDoc.data(),
              'id': proposalDoc.id,
              'constructorDetails': constructorDoc.data(),
            });
            jobProposals.add(proposal);
          }
        }

        if (jobProposals.isNotEmpty) {
          allProposals[jobDoc.id] = jobProposals;
        }
      }

      return allProposals;
    });
  }

  // Get constructor details
  Future<ConstructorDetails> getConstructorDetails(String constructorId) async {
    try {
      final doc = await _firestore.collection('users').doc(constructorId).get();

      if (!doc.exists) {
        throw Exception('Constructor not found');
      }

      return ConstructorDetails.fromJson({
        ...doc.data()!,
        'id': doc.id,
      });
    } catch (e) {
      throw Exception('Failed to get constructor details: $e');
    }
  }

  Future<void> approveMilestone(String proposalId, int milestoneIndex) async {
    try {
      final proposalDoc =
          await _firestore.collection('proposals').doc(proposalId).get();

      if (!proposalDoc.exists) {
        throw Exception('Proposal not found');
      }

      List<dynamic> milestones = proposalDoc.data()?['milestones'] ?? [];
      if (milestoneIndex >= milestones.length) {
        throw Exception('Invalid milestone index');
      }

      // Update the milestone status
      milestones[milestoneIndex]['status'] = 'completed';
      milestones[milestoneIndex]['completedAt'] =
          DateTime.now().toIso8601String();

      await _firestore.collection('proposals').doc(proposalId).update({
        'milestones': milestones,
      });
    } catch (e) {
      throw Exception('Failed to approve milestone: $e');
    }
  }

  // Add method to create a chat room
  Future<String> createChatRoom(String jobId, String constructorId) async {
    try {
      if (currentUserId == null) {
        throw Exception('No user logged in');
      }

      final chatDoc = await _firestore.collection('chats').add({
        'jobId': jobId,
        'clientId': currentUserId,
        'constructorId': constructorId,
        'createdAt': DateTime.now().toIso8601String(),
        'lastMessage': null,
        'lastMessageTime': null,
      });

      return chatDoc.id;
    } catch (e) {
      throw Exception('Failed to create chat room: $e');
    }
  }

  // Get chat messages
  Stream<List<ChatMessage>> getChatMessages(String chatId) {
    return _firestore
        .collection('chats')
        .doc(chatId)
        .collection('messages')
        .orderBy('timestamp', descending: true)
        .snapshots()
        .map((snapshot) => snapshot.docs
            .map((doc) => ChatMessage.fromJson({
                  ...doc.data(),
                  'id': doc.id,
                }))
            .toList());
  }

  // Send a message
  Future<void> sendMessage(String chatId, String content, String type) async {
    try {
      if (currentUserId == null) {
        throw Exception('No user logged in');
      }

      final message = ChatMessage(
        id: '',
        senderId: currentUserId!,
        content: content,
        type: type,
        timestamp: DateTime.now(),
      );

      await _firestore
          .collection('chats')
          .doc(chatId)
          .collection('messages')
          .add(message.toJson());

      // Update last message in chat room
      await _firestore.collection('chats').doc(chatId).update({
        'lastMessage': content,
        'lastMessageTime': DateTime.now().toIso8601String(),
      });
    } catch (e) {
      throw Exception('Failed to send message: $e');
    }
  }

  Future<ClientProposal?> getAcceptedProposal(String jobId) async {
    try {
      final querySnapshot = await _firestore
          .collection('proposals')
          .where('jobId', isEqualTo: jobId)
          .where('status', isEqualTo: 'accepted')
          .limit(1)
          .get();

      if (querySnapshot.docs.isEmpty) {
        return null;
      }

      final doc = querySnapshot.docs.first;

      // Get constructor details
      final constructorDoc = await _firestore
          .collection('users')
          .doc(doc.data()['constructorId'])
          .get();

      if (!constructorDoc.exists) {
        throw Exception('Constructor not found');
      }

      return ClientProposal.fromJson({
        ...doc.data(),
        'id': doc.id,
        'constructorDetails': constructorDoc.data(),
      });
    } catch (e) {
      throw Exception('Failed to get accepted proposal: $e');
    }
  }
}

// Add a provider for accepted proposal
final acceptedProposalProvider = FutureProvider.family<ClientProposal?, String>(
  (ref, jobId) {
    final repository = ref.watch(clientProposalRepositoryProvider);
    return repository.getAcceptedProposal(jobId);
  },
);

extension JobManagement on ClientProposalRepository {
  Future<void> deleteJob(String jobId) async {
    try {
      // Start a batch write
      final batch = _firestore.batch();

      // Delete the job
      batch.delete(_firestore.collection('jobs').doc(jobId));

      // Get and delete all related proposals
      final proposals = await _firestore
          .collection('proposals')
          .where('jobId', isEqualTo: jobId)
          .get();

      for (var doc in proposals.docs) {
        batch.delete(doc.reference);
      }

      // Commit the batch
      await batch.commit();
    } catch (e) {
      throw Exception('Failed to delete job: $e');
    }
  }
}
