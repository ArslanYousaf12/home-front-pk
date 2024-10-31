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

  UserJobsController(this._ref) : super(const AsyncValue.loading()) {
    loadUserJobs();
  }

  void loadUserJobs() {
    final userId = FirebaseAuth.instance.currentUser!.uid;

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
    super.dispose();
  }
}
