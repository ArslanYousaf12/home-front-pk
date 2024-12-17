// ClientProposal Model
import 'package:home_front_pk/src/features/constructor_apply_job/domain/constructor_job.dart';

class ClientProposal {
  final String id;
  final String jobId;
  final String constructorId;
  final String proposalDescription;
  final double proposedCost;
  final int estimatedDays;
  final List<Milestone> milestones;
  final String status; // 'pending', 'accepted', 'rejected'
  final DateTime createdAt;
  final List<String> attachments;
  final ConstructorDetails? constructorDetails;
  final String? clientResponse;
  final DateTime? respondedAt;

  ClientProposal({
    required this.id,
    required this.jobId,
    required this.constructorId,
    required this.proposalDescription,
    required this.proposedCost,
    required this.estimatedDays,
    required this.milestones,
    this.status = 'pending',
    required this.createdAt,
    this.attachments = const [],
    this.constructorDetails,
    this.clientResponse,
    this.respondedAt,
  });

  factory ClientProposal.fromJson(Map<String, dynamic> json) {
    return ClientProposal(
      id: json['id'] ?? '',
      jobId: json['jobId'] ?? '',
      constructorId: json['constructorId'] ?? '',
      proposalDescription: json['proposalDescription'] ?? '',
      proposedCost: (json['proposedCost'] ?? 0.0).toDouble(),
      estimatedDays: json['estimatedDays'] ?? 0,
      milestones: (json['milestones'] as List?)
              ?.map((m) => Milestone.fromJson(m))
              .toList() ??
          [],
      status: json['status'] ?? 'pending',
      createdAt:
          DateTime.parse(json['createdAt'] ?? DateTime.now().toIso8601String()),
      attachments: List<String>.from(json['attachments'] ?? []),
      constructorDetails: json['constructorDetails'] != null
          ? ConstructorDetails.fromJson(json['constructorDetails'])
          : null,
      clientResponse: json['clientResponse'],
      respondedAt: json['respondedAt'] != null
          ? DateTime.parse(json['respondedAt'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'jobId': jobId,
      'constructorId': constructorId,
      'proposalDescription': proposalDescription,
      'proposedCost': proposedCost,
      'estimatedDays': estimatedDays,
      'milestones': milestones.map((m) => m.toJson()).toList(),
      'status': status,
      'createdAt': createdAt.toIso8601String(),
      'attachments': attachments,
      'clientResponse': clientResponse,
      'respondedAt': respondedAt?.toIso8601String(),
    };
  }
}

class ConstructorDetails {
  final String id;
  final String name;
  final String? profileImage;
  final double rating;
  final int completedJobs;
  final bool isVerified;
  final String? phone;
  final String email;
  final List<String> specializations;

  ConstructorDetails({
    required this.id,
    required this.name,
    this.profileImage,
    required this.rating,
    required this.completedJobs,
    required this.isVerified,
    this.phone,
    required this.email,
    this.specializations = const [],
  });

  factory ConstructorDetails.fromJson(Map<String, dynamic> json) {
    return ConstructorDetails(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      profileImage: json['profileImage'],
      rating: (json['rating'] ?? 0.0).toDouble(),
      completedJobs: json['completedJobs'] ?? 0,
      isVerified: json['isVerified'] ?? false,
      phone: json['phone'],
      email: json['email'] ?? '',
      specializations: List<String>.from(json['specializations'] ?? []),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'profileImage': profileImage,
      'rating': rating,
      'completedJobs': completedJobs,
      'isVerified': isVerified,
      'phone': phone,
      'email': email,
      'specializations': specializations,
    };
  }
}
