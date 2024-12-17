class JobProposal {
  final String id;
  final String jobId;
  final String constructorId;
  final String proposalDescription;
  final double proposedCost;
  final int estimatedDays;
  final List<Milestone> milestones;
  final String status; // 'pending', 'accepted', 'rejected'
  final DateTime createdAt;
  final List<String> attachments; // For any supporting documents

  JobProposal({
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
  });

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
    };
  }

  factory JobProposal.fromJson(Map<String, dynamic> json) {
    return JobProposal(
      id: json['id'] ?? '',
      jobId: json['jobId'] ?? '',
      constructorId: json['constructorId'] ?? '',
      proposalDescription: json['proposalDescription'] ?? '',
      proposedCost: (json['proposedCost'] ?? 0).toDouble(),
      estimatedDays: json['estimatedDays'] ?? 0,
      milestones: (json['milestones'] as List?)
              ?.map((m) => Milestone.fromJson(m))
              .toList() ??
          [],
      status: json['status'] ?? 'pending',
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      attachments: List<String>.from(json['attachments'] ?? []),
    );
  }

  JobProposal copyWith({
    String? id,
    String? jobId,
    String? constructorId,
    String? proposalDescription,
    double? proposedCost,
    int? estimatedDays,
    List<Milestone>? milestones,
    String? status,
    DateTime? createdAt,
    List<String>? attachments,
  }) {
    return JobProposal(
      id: id ?? this.id,
      jobId: jobId ?? this.jobId,
      constructorId: constructorId ?? this.constructorId,
      proposalDescription: proposalDescription ?? this.proposalDescription,
      proposedCost: proposedCost ?? this.proposedCost,
      estimatedDays: estimatedDays ?? this.estimatedDays,
      milestones: milestones ?? this.milestones,
      status: status ?? this.status,
      createdAt: createdAt ?? this.createdAt,
      attachments: attachments ?? this.attachments,
    );
  }
}

class Milestone {
  final String title;
  final String description;
  final double amount;
  final int daysToComplete;
  final String status; // 'pending', 'in_progress', 'completed'

  Milestone({
    required this.title,
    required this.description,
    required this.amount,
    required this.daysToComplete,
    this.status = 'pending',
  });

  Map<String, dynamic> toJson() {
    return {
      'title': title,
      'description': description,
      'amount': amount,
      'daysToComplete': daysToComplete,
      'status': status,
    };
  }

  factory Milestone.fromJson(Map<String, dynamic> json) {
    return Milestone(
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      amount: (json['amount'] ?? 0).toDouble(),
      daysToComplete: json['daysToComplete'] ?? 0,
      status: json['status'] ?? 'pending',
    );
  }
}
