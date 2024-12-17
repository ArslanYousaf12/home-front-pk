import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_front_pk/src/features/client_proposal_management/data/client_proposal_controller.dart';
import 'package:home_front_pk/src/features/client_proposal_management/data/client_proposal_repo.dart';
import 'package:home_front_pk/src/features/client_proposal_management/domain/client_proposal_model.dart';
import 'package:home_front_pk/src/features/client_proposal_management/presentation/chat_screen.dart';
import 'package:home_front_pk/src/features/client_proposal_management/presentation/client_proposal_screen.dart';
import 'package:home_front_pk/src/features/client_proposal_management/presentation/project_detail_screen.dart';
import 'package:home_front_pk/src/features/user_job_post/domain/job_post_model.dart';
import 'package:home_front_pk/src/features/user_job_post/presentation/user_job_post_controller.dart';
import 'package:timeago/timeago.dart' as timeago;

// Provider for client's jobs
final clientJobsProvider = StreamProvider<List<JobPost>>((ref) {
  final repository = ref.watch(firestoreRepositoryProvider);
  return repository.getUserJobs(
    ref.watch(firestoreRepositoryProvider).currentUserId!,
  );
});

class ClientJobsScreen extends ConsumerWidget {
  const ClientJobsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jobsAsync = ref.watch(clientJobsProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('My Jobs'),
      ),
      body: jobsAsync.when(
        data: (jobs) {
          if (jobs.isEmpty) {
            return const Center(
              child: Text('No jobs posted yet'),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: jobs.length,
            itemBuilder: (context, index) {
              return JobCard(job: jobs[index]);
            },
          );
        },
        loading: () => const Center(
          child: CircularProgressIndicator(),
        ),
        error: (error, stack) => Center(
          child: Text('Error: $error'),
        ),
      ),
    );
  }
}

class JobCard extends ConsumerWidget {
  final JobPost job;

  const JobCard({
    Key? key,
    required this.job,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Watch proposals for this job
    final proposalsAsync = ref.watch(jobProposalsProvider(job.id));

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Job header with image
          if (job.images.isNotEmpty)
            SizedBox(
              height: 200,
              width: double.infinity,
              child: Stack(
                fit: StackFit.expand,
                children: [
                  Image.network(
                    job.images.first,
                    fit: BoxFit.cover,
                  ),
                  Positioned(
                    top: 8,
                    right: 8,
                    child: _buildStatusChip(job.status),
                  ),
                ],
              ),
            ),

          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Title and Status
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Text(
                        job.title,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                    ),
                    if (job.images.isEmpty) _buildStatusChip(job.status),
                  ],
                ),
                const SizedBox(height: 8),

                // Location
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 16),
                    const SizedBox(width: 4),
                    Text(job.location),
                  ],
                ),
                const SizedBox(height: 8),

                // Budget and Time
                Row(
                  children: [
                    Icon(Icons.account_balance_wallet,
                        size: 16, color: Theme.of(context).primaryColor),
                    const SizedBox(width: 4),
                    Text(
                      'Budget: Rs.${job.budget.toStringAsFixed(0)}',
                      style: TextStyle(
                        color: Theme.of(context).primaryColor,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const Spacer(),
                    const Icon(Icons.access_time, size: 16),
                    const SizedBox(width: 4),
                    Text(
                      timeago.format(job.createdAt),
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ],
                ),
                const SizedBox(height: 16),

                // Proposals count
                proposalsAsync.when(
                  data: (proposals) => Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '${proposals.length} Proposals',
                        style: Theme.of(context).textTheme.titleMedium,
                      ),
                      TextButton.icon(
                        onPressed: () {
                          // Navigate to proposals screen
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => ClientJobProposalsScreen(
                                jobId: job.id,
                                jobPost: job,
                              ),
                            ),
                          );
                        },
                        icon: const Icon(Icons.visibility),
                        label: const Text('View Proposals'),
                      ),
                    ],
                  ),
                  loading: () => const Center(
                    child: CircularProgressIndicator(),
                  ),
                  error: (error, stack) => Text('Error: $error'),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color color;
    String text = status.toUpperCase();

    switch (status) {
      case 'in_progress':
        color = Colors.blue;
        break;
      case 'completed':
        color = Colors.green;
        break;
      case 'cancelled':
        color = Colors.red;
        break;
      default:
        color = Colors.orange;
    }

    return Chip(
      label: Text(
        text,
        style: const TextStyle(color: Colors.white, fontSize: 12),
      ),
      backgroundColor: color,
      padding: EdgeInsets.zero,
    );
  }
}

// Update the JobActionsBottomSheet
class JobActionsBottomSheet extends ConsumerWidget {
  final JobPost job;
  final ClientProposal proposal;

  const JobActionsBottomSheet({
    Key? key,
    required this.job,
    required this.proposal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(16),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.chat),
                title: const Text('Chat with Constructor'),
                onTap: () {
                  Navigator.pop(context);
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ChatScreen(
                        jobId: job.id,
                        constructorId: proposal.constructorId,
                      ),
                    ),
                  );
                },
              ),
              if (job.status == 'in_progress') ...[
                ListTile(
                  leading: const Icon(Icons.work),
                  title: const Text('View Project'),
                  onTap: () {
                    Navigator.pop(context);
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProjectDetailsScreen(
                          jobPost: job,
                          proposal: proposal,
                        ),
                      ),
                    );
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.assignment),
                  title: const Text('View Milestones'),
                  onTap: () {
                    Navigator.pop(context);
                    // Navigate to milestones screen if you have one
                  },
                ),
              ],
              ListTile(
                leading: const Icon(Icons.person),
                title: const Text('Constructor Profile'),
                onTap: () {
                  Navigator.pop(context);
                  // Navigate to constructor profile screen if you have one
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  void showDeleteConfirmationDialog(BuildContext context, WidgetRef ref) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Job'),
        content: const Text(
          'Are you sure you want to delete this job? This action cannot be undone.',
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          TextButton(
            onPressed: () async {
              try {
                await ref
                    .read(clientProposalRepositoryProvider)
                    .deleteJob(job.id);
                if (context.mounted) {
                  Navigator.pop(context); // Close dialog
                  Navigator.pop(context); // Close bottom sheet
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Job deleted successfully'),
                    ),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error deleting job: $e'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              }
            },
            style: TextButton.styleFrom(
              foregroundColor: Colors.red,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }
}
