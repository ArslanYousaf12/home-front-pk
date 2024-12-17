// First, create a ChatController
import 'dart:io';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_front_pk/src/features/client_proposal_management/data/client_proposal_controller.dart';
import 'package:home_front_pk/src/features/client_proposal_management/data/client_proposal_repo.dart';
import 'package:home_front_pk/src/features/user_job_post/data/image_upload_repo.dart';

import 'package:riverpod_annotation/riverpod_annotation.dart';

class ChatController extends StateNotifier<AsyncValue<void>> {
  final ClientProposalRepository _repository;
  final StorageRepository _storageRepository;

  ChatController({
    required ClientProposalRepository repository,
    required StorageRepository storageRepository,
  })  : _repository = repository,
        _storageRepository = storageRepository,
        super(const AsyncValue.data(null));

  Future<String> uploadChatImage(String chatId, File file) async {
    try {
      state = const AsyncValue.loading();
      final url = await _storageRepository.uploadChatImage(chatId, file);
      state = const AsyncValue.data(null);
      return url;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  Future<void> sendMessage(String chatId, String content, String type) async {
    try {
      state = const AsyncValue.loading();
      await _repository.sendMessage(chatId, content, type);
      state = const AsyncValue.data(null);
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }

  Future<String> createChatRoom(String jobId, String constructorId) async {
    try {
      state = const AsyncValue.loading();
      final chatId = await _repository.createChatRoom(jobId, constructorId);
      state = const AsyncValue.data(null);
      return chatId;
    } catch (e, st) {
      state = AsyncValue.error(e, st);
      rethrow;
    }
  }
}

// Add providers
final chatControllerProvider =
    StateNotifierProvider<ChatController, AsyncValue<void>>((ref) {
  final repository = ref.watch(clientProposalRepositoryProvider);
  final storageRepository = ref.watch(storageRepositoryProvider);
  return ChatController(
    repository: repository,
    storageRepository: storageRepository,
  );
});
