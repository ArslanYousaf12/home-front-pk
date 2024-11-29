// lib/src/features/offers/data/offer_repository.dart
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../domain/offer_model.dart';

class OfferRepository {
  final FirebaseFirestore _firestore;
  final FirebaseAuth _auth;

  OfferRepository({
    FirebaseFirestore? firestore,
    FirebaseAuth? auth,
  })  : _firestore = firestore ?? FirebaseFirestore.instance,
        _auth = auth ?? FirebaseAuth.instance;

  Stream<List<Offer>> getOffersSent() {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return Stream.value([]);

    return _firestore
        .collection('proposals')
        .where('constructorId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Offer.fromFirestore(doc)).toList());
  }

  Stream<List<Offer>> getOffersReceived() {
    final userId = _auth.currentUser?.uid;
    if (userId == null) return Stream.value([]);

    return _firestore
        .collection('proposals')
        .where('userId', isEqualTo: userId)
        .orderBy('createdAt', descending: true)
        .snapshots()
        .map((snapshot) =>
            snapshot.docs.map((doc) => Offer.fromFirestore(doc)).toList());
  }

  Future<void> updateOfferStatus(String offerId, String status) async {
    await _firestore.collection('proposals').doc(offerId).update({
      'status': status,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<void> updateMilestoneStatus(
    String offerId,
    int milestoneIndex,
    String status,
  ) async {
    final offerDoc =
        await _firestore.collection('proposals').doc(offerId).get();
    final offer = Offer.fromFirestore(offerDoc);

    List<Map<String, dynamic>> updatedMilestones =
        offer.milestones.asMap().entries.map((entry) {
      if (entry.key == milestoneIndex) {
        return {...entry.value.toMap(), 'status': status};
      }
      return entry.value.toMap();
    }).toList();

    await _firestore.collection('proposals').doc(offerId).update({
      'milestones': updatedMilestones,
      'updatedAt': FieldValue.serverTimestamp(),
    });
  }

  Future<String> createOffer({
    required String jobId,
    required String title,
    required String description,
    required double estimatedCost,
    required int estimatedDays,
    required String location,
    required List<Map<String, dynamic>> milestones,
    required List<String> attachments,
  }) async {
    final userId = _auth.currentUser?.uid;
    if (userId == null) throw Exception('User not authenticated');

    final docRef = await _firestore.collection('proposals').add({
      'constructorId': userId,
      'jobId': jobId,
      'title': title,
      'description': description,
      'estimatedCost': estimatedCost,
      'estimatedDays': estimatedDays,
      'location': location,
      'milestones': milestones,
      'attachments': attachments,
      'status': 'pending',
      'createdAt': FieldValue.serverTimestamp(),
    });

    return docRef.id;
  }
}
