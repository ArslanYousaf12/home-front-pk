// lib/presentation/controllers/job_post_controller.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'dart:io';

import 'package:home_front_pk/src/features/user_job_post/data/firestore_repo.dart';
import 'package:home_front_pk/src/features/user_job_post/data/image_upload_repo.dart';
import 'package:home_front_pk/src/features/user_job_post/domain/job_post_model.dart';

// Providers
final firestoreRepositoryProvider = Provider((ref) => FirestoreRepository());
final storageRepositoryProvider = Provider((ref) => StorageRepository());

// Controller
final jobPostControllerProvider =
    StateNotifierProvider<JobPostController, AsyncValue<void>>((ref) {
  return JobPostController(ref);
});

class JobPostController extends StateNotifier<AsyncValue<void>> {
  final Ref _ref;

  JobPostController(this._ref) : super(const AsyncValue.data(null));

  Future<void> createJobPost({
    required String title,
    required String description,
    required List<File> images,
    required String location,
    required String category,
    required double estimatedCost,
    required double budget,
    List<String> tags = const [],
  }) async {
    state = const AsyncValue.loading();

    try {
      final storageRepo = _ref.read(storageRepositoryProvider);
      final firestoreRepo = _ref.read(firestoreRepositoryProvider);

      // Create initial job post
      final jobPost = JobPost(
        id: DateTime.now().millisecondsSinceEpoch.toString(), // Temporary ID
        userId: 'current-user-id', // Get this from auth
        title: title,
        description: description,
        images: [],
        location: location,
        estimatedCost: estimatedCost,
        budget: budget,
        category: category,
        createdAt: DateTime.now(),
        tags: tags,
      );

      // Upload images
      final imageUrls = await storageRepo.uploadJobImages(images, jobPost.id);

      // Create final job post with image URLs
      final finalJobPost = jobPost.copyWith(images: imageUrls);
      await firestoreRepo.createJobPost(finalJobPost);

      state = const AsyncValue.data(null);
    } catch (error, stackTrace) {
      state = AsyncValue.error(error, stackTrace);
    }
  }
}
