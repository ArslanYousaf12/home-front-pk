// Providers
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_front_pk/src/features/client_proposal_management/data/client_proposal_repo.dart';
import 'package:home_front_pk/src/features/client_proposal_management/domain/client_proposal_model.dart';
import 'package:home_front_pk/src/features/user_job_post/data/image_upload_repo.dart';

final clientProposalRepositoryProviderWithStorage =
    Provider<ClientProposalRepository>((ref) {
  return ClientProposalRepository();
});

// Stream provider for job proposals
final jobProposalsProvider =
    StreamProvider.family<List<ClientProposal>, String>((ref, jobId) {
  final repository = ref.watch(clientProposalRepositoryProviderWithStorage);
  return repository.getJobProposals(jobId);
});

// Stream provider for all proposals across all jobs
final allJobProposalsProvider =
    StreamProvider<Map<String, List<ClientProposal>>>((ref) {
  final repository = ref.watch(clientProposalRepositoryProvider);
  return repository.getAllJobProposals();
});

// Controller
class ClientProposalController extends StateNotifier<AsyncValue<void>> {
  final ClientProposalRepository _repository;

  ClientProposalController(this._repository)
      : super(const AsyncValue.data(null));

  Future<void> acceptProposal(String jobId, String proposalId) async {
    state = const AsyncValue.loading();
    try {
      await _repository.acceptProposal(jobId, proposalId);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  Future<void> rejectProposal(String proposalId, {String? reason}) async {
    state = const AsyncValue.loading();
    try {
      await _repository.rejectProposal(proposalId, reason: reason);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }
}

final storageRepositoryProvider = Provider<StorageRepository>((ref) {
  return StorageRepository();
});

final clientProposalRepositoryProvider =
    Provider<ClientProposalRepository>((ref) {
  final storageRepo = ref.watch(storageRepositoryProvider);
  return ClientProposalRepository();
});

final clientProposalControllerProvider =
    StateNotifierProvider<ClientProposalController, AsyncValue<void>>((ref) {
  final repository = ref.watch(clientProposalRepositoryProvider);
  return ClientProposalController(repository);
});
