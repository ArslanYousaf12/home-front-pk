import 'dart:async';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_front_pk/src/features/user_job_post/domain/job_post_model.dart';
import 'package:home_front_pk/src/features/user_job_post/presentation/user_job_post_controller.dart';

final userJobsControllerProvider =
    StateNotifierProvider<UserJobsController, AsyncValue<List<JobPost>>>((ref) {
  return UserJobsController(ref);
});

class UserJobsController extends StateNotifier<AsyncValue<List<JobPost>>> {
  final Ref _ref;
  StreamSubscription<List<JobPost>>? _subscription;
  StreamSubscription<User?>? _authSubscription;

  UserJobsController(this._ref) : super(const AsyncValue.loading()) {
    // Listen to auth state changes
    _authSubscription = FirebaseAuth.instance.authStateChanges().listen((user) {
      if (user != null) {
        loadUserJobs();
      } else {
        state = const AsyncValue.data([]);
      }
    });
  }

  void loadUserJobs() {
    final userId = FirebaseAuth.instance.currentUser?.uid;
    if (userId == null) {
      state = const AsyncValue.error('No user logged in', StackTrace.empty);
      return;
    }

    state = const AsyncValue.loading();
    _subscription?.cancel();

    _subscription =
        _ref.read(firestoreRepositoryProvider).getUserJobs(userId).listen(
              (jobs) => state = AsyncValue.data(jobs),
              onError: (error, stack) => state = AsyncValue.error(error, stack),
            );
  }

  @override
  void dispose() {
    _subscription?.cancel();
    _authSubscription?.cancel();
    super.dispose();
  }
}
