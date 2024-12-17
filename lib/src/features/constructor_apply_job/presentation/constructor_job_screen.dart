import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_front_pk/src/features/constructor_apply_job/presentation/submit_proposal_screen.dart';
import 'package:home_front_pk/src/features/user_job_post/domain/job_post_model.dart';
import 'package:home_front_pk/src/features/user_job_post/presentation/user_job_post_controller.dart';
import 'package:timeago/timeago.dart' as timeago;

// Provider to filter jobs by category and status
final availableJobsProvider = StreamProvider.autoDispose<List<JobPost>>((ref) {
  final repository = ref.watch(firestoreRepositoryProvider);
  // Get jobs specifically for constructors that are still pending
  return repository.getJobPosts('constructor').map(
        (jobs) => jobs.where((job) => job.status == 'pending').toList(),
      );
});

class ConstructorJobsScreen extends ConsumerWidget {
  const ConstructorJobsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jobsAsync = ref.watch(availableJobsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('Available Jobs'),
      ),
      body: jobsAsync.when(
        data: (jobs) => jobs.isEmpty
            ? const Center(
                child: Text('No jobs available at the moment'),
              )
            : ListView.builder(
                itemCount: jobs.length,
                padding: const EdgeInsets.all(16),
                itemBuilder: (context, index) {
                  final job = jobs[index];
                  return JobCard(job: job);
                },
              ),
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(
          child: Text('Error: ${error.toString()}'),
        ),
      ),
    );
  }
}

class JobCard extends StatelessWidget {
  final JobPost job;

  const JobCard({Key? key, required this.job}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => SubmitProposalScreen(jobPost: job),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Job Images
            if (job.images.isNotEmpty)
              SizedBox(
                height: 200,
                child: PageView.builder(
                  itemCount: job.images.length,
                  itemBuilder: (context, index) {
                    return Image.network(
                      job.images[index],
                      fit: BoxFit.cover,
                    );
                  },
                ),
              ),

            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // Title and Budget
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Expanded(
                        child: Text(
                          job.title,
                          style: Theme.of(context).textTheme.titleLarge,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      Text(
                        'Budget: Rs.${job.budget.toStringAsFixed(0)}',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: Theme.of(context).primaryColor,
                                ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Location
                  Row(
                    children: [
                      const Icon(Icons.location_on, size: 16),
                      const SizedBox(width: 4),
                      Text(
                        job.location,
                        style: Theme.of(context).textTheme.bodyMedium,
                      ),
                    ],
                  ),
                  const SizedBox(height: 8),

                  // Description
                  Text(
                    job.description,
                    maxLines: 3,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 8),

                  // Tags
                  if (job.tags.isNotEmpty)
                    Wrap(
                      spacing: 8,
                      children: job.tags.map((tag) {
                        return Chip(
                          label: Text(tag),
                          padding: const EdgeInsets.all(4),
                        );
                      }).toList(),
                    ),

                  // Posted Time and Apply Button
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        'Posted ${timeago.format(job.createdAt)}',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  SubmitProposalScreen(jobPost: job),
                            ),
                          );
                        },
                        child: const Text('Apply Now'),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
