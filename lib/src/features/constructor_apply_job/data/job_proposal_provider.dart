// Providers
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_front_pk/src/features/constructor_apply_job/data/job_proposal_repo.dart';
import 'package:home_front_pk/src/features/constructor_apply_job/domain/constructor_job.dart';
import 'package:home_front_pk/src/features/user_job_post/data/image_upload_repo.dart';
import 'package:home_front_pk/src/features/user_job_post/presentation/user_job_post_controller.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

final jobProposalRepositoryProvider = Provider<JobProposalRepository>((ref) {
  final storageRepo = ref.watch(storageRepositoryProvider);
  return JobProposalRepository(storageRepository: storageRepo);
});

final constructorProposalsProvider =
    StreamProvider.family<List<JobProposal>, String>((ref, constructorId) {
  final repository = ref.watch(jobProposalRepositoryProvider);
  return repository.getConstructorProposals(constructorId);
});

final jobProposalsProvider =
    StreamProvider.family<List<JobProposal>, String>((ref, jobId) {
  final repository = ref.watch(jobProposalRepositoryProvider);
  return repository.getJobProposals(jobId);
});

// Controller
class ProposalController extends StateNotifier<AsyncValue<void>> {
  final JobProposalRepository _repository;
  final StorageRepository _storageRepository;

  ProposalController({
    required JobProposalRepository repository,
    required StorageRepository storageRepository,
  })  : _repository = repository,
        _storageRepository = storageRepository,
        super(const AsyncValue.data(null));

  Future<void> submitProposal({
    required String jobId,
    required String description,
    required double proposedCost,
    required int estimatedDays,
    required List<Milestone> milestones,
    required List<File> attachments,
  }) async {
    state = const AsyncValue.loading();
    try {
      final proposal = JobProposal(
        id: '', // Will be set in repository
        jobId: jobId,
        constructorId: '', // Will be set in repository
        proposalDescription: description,
        proposedCost: proposedCost,
        estimatedDays: estimatedDays,
        milestones: milestones,
        createdAt: DateTime.now(),
      );

      await _repository.submitProposal(proposal, attachments);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateProposalStatus(String proposalId, String status) async {
    state = const AsyncValue.loading();
    try {
      await _repository.updateProposalStatus(proposalId, status);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }

  Future<void> updateMilestoneStatus(
      String proposalId, int milestoneIndex, String status) async {
    state = const AsyncValue.loading();
    try {
      await _repository.updateMilestoneStatus(
          proposalId, milestoneIndex, status);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
    }
  }
}

final proposalControllerProvider =
    StateNotifierProvider<ProposalController, AsyncValue<void>>((ref) {
  final repository = ref.watch(jobProposalRepositoryProvider);
  final storageRepository = ref.watch(storageRepositoryProvider);
  return ProposalController(
    repository: repository,
    storageRepository: storageRepository,
  );
});
