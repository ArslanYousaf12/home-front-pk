// lib/domain/models/job_post.dart
class JobPost {
  final String id;
  final String userId;
  final String title;
  final String description;
  final List<String> images;
  final String location;
  final double estimatedCost;
  final double budget;
  final String category; // 'constructor' or 'designer'
  final DateTime createdAt;
  final List<String> tags;
  final String status;

  JobPost({
    required this.id,
    required this.userId,
    required this.title,
    required this.description,
    required this.images,
    required this.location,
    required this.estimatedCost,
    required this.budget,
    required this.category,
    required this.createdAt,
    this.tags = const [],
    this.status = 'pending',
  });

  // Convert JobPost instance to a Map
  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'userId': userId,
      'title': title,
      'description': description,
      'images': images,
      'location': location,
      'estimatedCost': estimatedCost,
      'budget': budget,
      'category': category,
      'createdAt': createdAt.toIso8601String(),
      'tags': tags,
      'status': status,
    };
  }

  // Create JobPost instance from a Map
  factory JobPost.fromJson(Map<String, dynamic> json) {
    return JobPost(
      id: json['id'] ?? '',
      userId: json['userId'] ?? '',
      title: json['title'] ?? '',
      description: json['description'] ?? '',
      images: List<String>.from(json['images'] ?? []),
      location: json['location'] ?? '',
      estimatedCost: (json['estimatedCost'] ?? 0).toDouble(),
      budget: (json['budget'] ?? 0).toDouble(),
      category: json['category'] ?? 'constructor',
      createdAt: json['createdAt'] != null
          ? DateTime.parse(json['createdAt'])
          : DateTime.now(),
      tags: List<String>.from(json['tags'] ?? []),
      status: json['status'] ?? 'pending',
    );
  }

  // Create a copy of JobPost with modified fields
  JobPost copyWith({
    String? id,
    String? userId,
    String? title,
    String? description,
    List<String>? images,
    String? location,
    double? estimatedCost,
    double? budget,
    String? category,
    DateTime? createdAt,
    List<String>? tags,
    String? status,
  }) {
    return JobPost(
      id: id ?? this.id,
      userId: userId ?? this.userId,
      title: title ?? this.title,
      description: description ?? this.description,
      images: images ?? this.images,
      location: location ?? this.location,
      estimatedCost: estimatedCost ?? this.estimatedCost,
      budget: budget ?? this.budget,
      category: category ?? this.category,
      createdAt: createdAt ?? this.createdAt,
      tags: tags ?? this.tags,
      status: status ?? this.status,
    );
  }
}
