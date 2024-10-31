// lib/presentation/screens/user_jobs_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_front_pk/src/features/user_job_post/presentation/job_post_screen.dart';
import 'package:home_front_pk/src/features/user_job_post/presentation/user_jobs_controller.dart';
import 'package:home_front_pk/src/features/user_job_post/presentation/widgets/job_card.dart';

class UserJobsScreen extends ConsumerWidget {
  const UserJobsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jobsAsync = ref.watch(userJobsControllerProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Jobs'),
      ),
      body: jobsAsync.when(
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Error: ${error.toString()}'),
        ),
        data: (jobs) => jobs.isEmpty
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const Text(
                      'No jobs posted yet',
                      style: TextStyle(fontSize: 18),
                    ),
                    const SizedBox(height: 16),
                    ElevatedButton(
                      onPressed: () => Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const CreateJobPostScreen(),
                        ),
                      ),
                      child: const Text('Create Job Post'),
                    ),
                  ],
                ),
              )
            : RefreshIndicator(
                onRefresh: () async {
                  ref.read(userJobsControllerProvider.notifier).loadUserJobs();
                },
                child: ListView.builder(
                  padding: const EdgeInsets.all(8),
                  itemCount: jobs.length,
                  itemBuilder: (context, index) {
                    final job = jobs[index];
                    return JobCard(job: job);
                  },
                ),
              ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const CreateJobPostScreen(),
          ),
        ),
        child: const Icon(Icons.add),
      ),
    );
  }
}
