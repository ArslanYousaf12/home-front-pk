import 'package:home_front_pk/src/features/chat_section/data/chat_repository.dart';
import 'package:home_front_pk/src/features/chat_section/domain/chat_model.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

import 'package:home_front_pk/src/common_widgets/notifier_mounted.dart';

part 'chat_controller.g.dart';

@riverpod
class ChatController extends _$ChatController with NotifierMounted {
  @override
  FutureOr<List<ChatMessage>?> build() {
    ref.onDispose(setUnmounted);
    return null;
  }

  Future<void> sendMessage(ChatMessage message) async {
    state = const AsyncLoading();
    final result = await AsyncValue.guard(
      () => ref.read(chatRepositoryProvider).sendMessage(message),
    );

    if (result.hasError) {
      state = AsyncError(result.error!, result.stackTrace!);
      return;
    }

    if (mounted) {
      // Add the new message to the current state
      state = AsyncData([...state.value ?? [], message]);
    }
  }

  Stream<List<ChatMessage>> getChatMessages() {
    return ref.read(chatRepositoryProvider).getChatMessages();
  }
}
