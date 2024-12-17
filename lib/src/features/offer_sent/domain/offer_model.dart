// lib/src/features/offers/domain/offer_model.dart
import 'package:cloud_firestore/cloud_firestore.dart';

class Milestone {
  final double amount;
  final int daysToComplete;
  final String description;
  final String status;

  Milestone({
    required this.amount,
    required this.daysToComplete,
    required this.description,
    required this.status,
  });

  factory Milestone.fromMap(Map<String, dynamic> map) {
    return Milestone(
      amount: (map['amount'] ?? 0).toDouble(),
      daysToComplete: map['daysToComplete'] ?? 0,
      description: map['description'] ?? '',
      status: map['status'] ?? 'pending',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'amount': amount,
      'daysToComplete': daysToComplete,
      'description': description,
      'status': status,
    };
  }
}

class Offer {
  final String id;
  final List<String> attachments;
  final String constructorId;
  final DateTime createdAt;
  final int estimatedDays;
  final String jobId;
  final List<Milestone> milestones;
  final String status;
  final String title;
  final String description;
  final double estimatedCost;
  final String location;
  final String userId;

  Offer({
    required this.id,
    required this.attachments,
    required this.constructorId,
    required this.createdAt,
    required this.estimatedDays,
    required this.jobId,
    required this.milestones,
    required this.status,
    required this.title,
    required this.description,
    required this.estimatedCost,
    required this.location,
    required this.userId,
  });

  factory Offer.fromFirestore(DocumentSnapshot doc) {
    Map<String, dynamic> data = doc.data() as Map<String, dynamic>;
    return Offer(
      id: doc.id,
      attachments: List<String>.from(data['attachments'] ?? []),
      constructorId: data['constructorId'] ?? '',
      createdAt: (data['createdAt'] as Timestamp).toDate(),
      estimatedDays: data['estimatedDays'] ?? 0,
      jobId: data['jobId'] ?? '',
      milestones: (data['milestones'] as List?)
              ?.map((m) => Milestone.fromMap(m))
              .toList() ??
          [],
      status: data['status'] ?? 'pending',
      title: data['title'] ?? '',
      description: data['description'] ?? '',
      estimatedCost: (data['estimatedCost'] ?? 0).toDouble(),
      location: data['location'] ?? '',
      userId: data['userId'] ?? '',
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'attachments': attachments,
      'constructorId': constructorId,
      'createdAt': Timestamp.fromDate(createdAt),
      'estimatedDays': estimatedDays,
      'jobId': jobId,
      'milestones': milestones.map((m) => m.toMap()).toList(),
      'status': status,
      'title': title,
      'description': description,
      'estimatedCost': estimatedCost,
      'location': location,
      'userId': userId,
    };
  }
}
