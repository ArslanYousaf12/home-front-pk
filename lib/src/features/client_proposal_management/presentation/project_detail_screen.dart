import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_front_pk/src/features/client_proposal_management/data/client_proposal_controller.dart';
import 'package:home_front_pk/src/features/client_proposal_management/domain/client_proposal_model.dart';
import 'package:home_front_pk/src/features/client_proposal_management/presentation/chat_screen.dart';
import 'package:home_front_pk/src/features/constructor_apply_job/domain/constructor_job.dart';
import 'package:home_front_pk/src/features/user_job_post/domain/job_post_model.dart';
import 'package:timeago/timeago.dart' as timeago;

class ProjectDetailsScreen extends ConsumerStatefulWidget {
  final JobPost jobPost;
  final ClientProposal proposal;

  const ProjectDetailsScreen({
    Key? key,
    required this.jobPost,
    required this.proposal,
  }) : super(key: key);

  @override
  ConsumerState<ProjectDetailsScreen> createState() =>
      _ProjectDetailsScreenState();
}

class _ProjectDetailsScreenState extends ConsumerState<ProjectDetailsScreen> {
  int _currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Project Details'),
        actions: [
          IconButton(
            icon: const Icon(Icons.chat),
            onPressed: () {
              // Navigate to chat screen
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => ChatScreen(
                    jobId: widget.jobPost.id,
                    constructorId: widget.proposal.constructorId,
                  ),
                ),
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Project Progress Card
          ProjectProgressCard(
            jobPost: widget.jobPost,
            proposal: widget.proposal,
          ),

          // Navigation Tabs
          TabBar(
            onTap: (index) {
              setState(() {
                _currentIndex = index;
              });
            },
            tabs: const [
              Tab(text: 'Milestones'),
              Tab(text: 'Details'),
              Tab(text: 'Constructor'),
            ],
          ),

          // Tab Content
          Expanded(
            child: IndexedStack(
              index: _currentIndex,
              children: [
                MilestonesTab(
                  jobPost: widget.jobPost,
                  proposal: widget.proposal,
                ),
                DetailsTab(
                  jobPost: widget.jobPost,
                  proposal: widget.proposal,
                ),
                ConstructorTab(
                  constructor: widget.proposal.constructorDetails!,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

class ProjectProgressCard extends ConsumerWidget {
  final JobPost jobPost;
  final ClientProposal proposal;

  const ProjectProgressCard({
    Key? key,
    required this.jobPost,
    required this.proposal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final completedMilestones =
        proposal.milestones.where((m) => m.status == 'completed').length;
    final totalMilestones = proposal.milestones.length;
    final progress =
        totalMilestones > 0 ? completedMilestones / totalMilestones : 0.0;

    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              jobPost.title,
              style: Theme.of(context).textTheme.titleLarge,
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        'Progress',
                        style: Theme.of(context).textTheme.titleSmall,
                      ),
                      const SizedBox(height: 8),
                      LinearProgressIndicator(
                        value: progress,
                        backgroundColor: Colors.grey[200],
                        borderRadius: BorderRadius.circular(4),
                        minHeight: 8,
                      ),
                      const SizedBox(height: 4),
                      Text(
                        '$completedMilestones of $totalMilestones milestones completed',
                        style: Theme.of(context).textTheme.bodySmall,
                      ),
                    ],
                  ),
                ),
                const SizedBox(width: 16),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  children: [
                    Text(
                      'Rs.${proposal.proposedCost}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    Text(
                      '${proposal.estimatedDays} days',
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                  ],
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class MilestonesTab extends ConsumerWidget {
  final JobPost jobPost;
  final ClientProposal proposal;

  const MilestonesTab({
    Key? key,
    required this.jobPost,
    required this.proposal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return ListView.builder(
      padding: const EdgeInsets.all(16),
      itemCount: proposal.milestones.length,
      itemBuilder: (context, index) {
        final milestone = proposal.milestones[index];
        return MilestoneCard(
          milestone: milestone,
          index: index,
          onApprove: () => _approveMilestone(context, ref, index),
        );
      },
    );
  }

  Future<void> _approveMilestone(
    BuildContext context,
    WidgetRef ref,
    int index,
  ) async {
    final milestone = proposal.milestones[index];

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Approve Milestone'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text('Are you sure you want to approve this milestone?'),
            const SizedBox(height: 16),
            Text('Title: ${milestone.title}'),
            Text('Amount: Rs.${milestone.amount}'),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Approve'),
          ),
        ],
      ),
    );

    if (result == true && context.mounted) {
      try {
        // await ref
        //     .read(clientProposalControllerProvider.notifier)
        //     .approveMilestone(
        //       proposal.id,
        //       index,
        //     );
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Milestone approved'),
              backgroundColor: Colors.green,
            ),
          );
        }
      } catch (e) {
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            SnackBar(
              content: Text('Error: $e'),
              backgroundColor: Colors.red,
            ),
          );
        }
      }
    }
  }
}

class DetailsTab extends StatelessWidget {
  final JobPost jobPost;
  final ClientProposal proposal;

  const DetailsTab({
    Key? key,
    required this.jobPost,
    required this.proposal,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  'Project Description',
                  style: Theme.of(context).textTheme.titleLarge,
                ),
                const SizedBox(height: 8),
                Text(jobPost.description),
                const SizedBox(height: 16),
                Text(
                  'Location',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                const SizedBox(height: 8),
                Row(
                  children: [
                    const Icon(Icons.location_on, size: 16),
                    const SizedBox(width: 4),
                    Text(jobPost.location),
                  ],
                ),
                if (jobPost.images.isNotEmpty) ...[
                  const SizedBox(height: 16),
                  Text(
                    'Project Images',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  SizedBox(
                    height: 120,
                    child: ListView.builder(
                      scrollDirection: Axis.horizontal,
                      itemCount: jobPost.images.length,
                      itemBuilder: (context, index) {
                        return Padding(
                          padding: const EdgeInsets.only(right: 8),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.network(
                              jobPost.images[index],
                              width: 120,
                              height: 120,
                              fit: BoxFit.cover,
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class ConstructorTab extends StatelessWidget {
  final ConstructorDetails constructor;

  const ConstructorTab({
    Key? key,
    required this.constructor,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView(
      padding: const EdgeInsets.all(16),
      children: [
        Card(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  children: [
                    CircleAvatar(
                      radius: 30,
                      backgroundImage: constructor.profileImage != null
                          ? NetworkImage(constructor.profileImage!)
                          : null,
                      child: constructor.profileImage == null
                          ? Text(constructor.name[0].toUpperCase())
                          : null,
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Text(
                                constructor.name,
                                style: Theme.of(context).textTheme.titleLarge,
                              ),
                              if (constructor.isVerified)
                                const Padding(
                                  padding: EdgeInsets.only(left: 4),
                                  child: Icon(
                                    Icons.verified,
                                    size: 20,
                                    color: Colors.blue,
                                  ),
                                ),
                            ],
                          ),
                          const SizedBox(height: 4),
                          Row(
                            children: [
                              const Icon(Icons.star,
                                  size: 16, color: Colors.amber),
                              Text(' ${constructor.rating.toStringAsFixed(1)}'),
                              Text(
                                  ' • ${constructor.completedJobs} jobs completed'),
                            ],
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 16),
                const Divider(),
                const SizedBox(height: 16),
                if (constructor.specializations.isNotEmpty) ...[
                  Text(
                    'Specializations',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  const SizedBox(height: 8),
                  Wrap(
                    spacing: 8,
                    runSpacing: 8,
                    children: constructor.specializations
                        .map((spec) => Chip(label: Text(spec)))
                        .toList(),
                  ),
                  const SizedBox(height: 16),
                ],
                ListTile(
                  leading: const Icon(Icons.email),
                  title: Text(constructor.email),
                ),
                if (constructor.phone != null)
                  ListTile(
                    leading: const Icon(Icons.phone),
                    title: Text(constructor.phone!),
                  ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}

class MilestoneCard extends StatelessWidget {
  final Milestone milestone;
  final int index;
  final VoidCallback onApprove;

  const MilestoneCard({
    Key? key,
    required this.milestone,
    required this.index,
    required this.onApprove,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Column(
        children: [
          ListTile(
            leading: CircleAvatar(
              child: Text('${index + 1}'),
            ),
            title: Text(milestone.title),
            subtitle: Text(milestone.description),
            trailing: _buildStatusChip(milestone.status),
          ),
          Padding(
            padding: const EdgeInsets.all(16),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Amount',
                      style: Theme.of(context).textTheme.titleSmall,
                    ),
                    Text(
                      'Rs.${milestone.amount}',
                      style: Theme.of(context).textTheme.titleLarge,
                    ),
                  ],
                ),
                if (milestone.status == 'pending')
                  ElevatedButton(
                    onPressed: onApprove,
                    child: const Text('Approve & Pay'),
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
      case 'completed':
        color = Colors.green;
        break;
      case 'in_progress':
        color = Colors.blue;
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
