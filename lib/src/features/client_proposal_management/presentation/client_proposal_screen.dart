import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_front_pk/src/features/client_proposal_management/data/client_proposal_controller.dart';
import 'package:home_front_pk/src/features/client_proposal_management/domain/client_proposal_model.dart';
import 'package:home_front_pk/src/features/client_proposal_management/presentation/client_job_screen.dart';
import 'package:home_front_pk/src/features/client_proposal_management/presentation/project_detail_screen.dart';
import 'package:home_front_pk/src/features/client_proposal_management/presentation/prosal_detail_screen.dart';
import 'package:home_front_pk/src/features/constructor_apply_job/domain/constructor_job.dart';
import 'package:home_front_pk/src/features/user_job_post/domain/job_post_model.dart';
import 'package:timeago/timeago.dart' as timeago;

class ClientJobProposalsScreen extends ConsumerWidget {
  final String jobId;
  final JobPost jobPost;

  const ClientJobProposalsScreen({
    Key? key,
    required this.jobId,
    required this.jobPost,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final proposalsAsync = ref.watch(jobProposalsProvider(jobId));

    return Scaffold(
      appBar: AppBar(
        title: const Text('Proposals'),
      ),
      body: Column(
        children: [
          // Job Summary Card
          JobSummaryCard(jobPost: jobPost),

          // Proposals List
          Expanded(
            child: proposalsAsync.when(
              data: (proposals) {
                if (proposals.isEmpty) {
                  return const Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.description_outlined,
                          size: 64,
                          color: Colors.grey,
                        ),
                        SizedBox(height: 16),
                        Text(
                          'No proposals received yet',
                          style: TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  );
                }

                return ListView.builder(
                  padding: const EdgeInsets.all(16),
                  itemCount: proposals.length,
                  itemBuilder: (context, index) {
                    return ProposalCard(
                      proposal: proposals[index],
                      jobPost: jobPost,
                    );
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
          ),
        ],
      ),
    );
  }
}

class JobSummaryCard extends StatelessWidget {
  final JobPost jobPost;

  const JobSummaryCard({
    Key? key,
    required this.jobPost,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.all(16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Job Images
                if (jobPost.images.isNotEmpty)
                  ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.network(
                      jobPost.images.first,
                      width: 80,
                      height: 80,
                      fit: BoxFit.cover,
                    ),
                  ),
                const SizedBox(width: 16),

                // Job Details
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        jobPost.title,
                        style: Theme.of(context).textTheme.titleLarge,
                      ),
                      const SizedBox(height: 8),
                      Row(
                        children: [
                          const Icon(Icons.location_on, size: 16),
                          const SizedBox(width: 4),
                          Text(jobPost.location),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Budget: Rs.${jobPost.budget.toStringAsFixed(0)}',
                        style:
                            Theme.of(context).textTheme.titleMedium?.copyWith(
                                  color: Theme.of(context).primaryColor,
                                ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class ProposalCard extends ConsumerWidget {
  final ClientProposal proposal;
  final JobPost jobPost;

  const ProposalCard({
    Key? key,
    required this.proposal,
    required this.jobPost,
  }) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // Safely handle possible null constructor details
    final constructor = proposal.constructorDetails;
    final isConstructorAvailable = constructor != null;

    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: InkWell(
        onTap: () {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProposalDetailsScreen(
                proposal: proposal,
                jobPost: jobPost,
              ),
            ),
          );
        },
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Constructor Info Section
            ListTile(
              leading: CircleAvatar(
                backgroundImage:
                    isConstructorAvailable && constructor.profileImage != null
                        ? NetworkImage(constructor.profileImage!)
                        : null,
                child:
                    isConstructorAvailable && constructor.profileImage == null
                        ? Text(constructor.name.isNotEmpty
                            ? constructor.name[0].toUpperCase()
                            : '?')
                        : !isConstructorAvailable
                            ? const Icon(Icons.person)
                            : null,
              ),
              title: Row(
                children: [
                  Text(isConstructorAvailable
                      ? constructor.name
                      : 'Unknown Constructor'),
                  if (isConstructorAvailable && constructor.isVerified)
                    const Padding(
                      padding: EdgeInsets.only(left: 4),
                      child: Icon(
                        Icons.verified,
                        size: 16,
                        color: Colors.blue,
                      ),
                    ),
                ],
              ),
              subtitle: isConstructorAvailable
                  ? Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            const Icon(
                              Icons.star,
                              size: 16,
                              color: Colors.amber,
                            ),
                            Text(' ${constructor.rating.toStringAsFixed(1)}'),
                            Text(
                                ' • ${constructor.completedJobs} jobs completed'),
                          ],
                        ),
                      ],
                    )
                  : const Text('Constructor details not available'),
              trailing: _buildStatusChip(proposal.status),
            ),

            // Proposal Summary
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Proposed Amount',
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          Text(
                            'Rs.${proposal.proposedCost.toStringAsFixed(0)}',
                            style: Theme.of(context)
                                .textTheme
                                .titleLarge
                                ?.copyWith(
                                  color: Theme.of(context).primaryColor,
                                ),
                          ),
                        ],
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Text(
                            'Duration',
                            style: Theme.of(context).textTheme.labelLarge,
                          ),
                          Text(
                            '${proposal.estimatedDays} days',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 16),
                  Text(
                    proposal.proposalDescription,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    'Submitted ${timeago.format(proposal.createdAt)}',
                    style: Theme.of(context).textTheme.bodySmall,
                  ),
                ],
              ),
            ),

            // Action Buttons
            if (proposal.status == 'pending')
              Padding(
                padding: const EdgeInsets.all(16),
                child: Row(
                  children: [
                    Expanded(
                      child: OutlinedButton(
                        onPressed: () => _showRejectDialog(context, ref),
                        style: OutlinedButton.styleFrom(
                          foregroundColor: Colors.red,
                        ),
                        child: const Text('Reject'),
                      ),
                    ),
                    const SizedBox(width: 16),
                    Expanded(
                      child: ElevatedButton(
                        onPressed: () => _showAcceptDialog(context, ref),
                        child: const Text('Accept'),
                      ),
                    ),
                  ],
                ),
              ),
            TextButton(
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => JobActionsBottomSheet(
                              job: jobPost, proposal: proposal)));
                },
                child: Text('View Actions'))
          ],
        ),
      ),
    );
  }

  Widget _buildStatusChip(String status) {
    Color color;
    String text = status.toUpperCase();

    switch (status) {
      case 'accepted':
        color = Colors.green;
        break;
      case 'rejected':
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

  Future<void> _showRejectDialog(BuildContext context, WidgetRef ref) async {
    final reasonController = TextEditingController();

    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Reject Proposal'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text('Are you sure you want to reject this proposal?'),
            const SizedBox(height: 16),
            TextField(
              controller: reasonController,
              decoration: const InputDecoration(
                labelText: 'Reason (Optional)',
                hintText: 'Enter reason for rejection',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            style: TextButton.styleFrom(foregroundColor: Colors.red),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Reject'),
          ),
        ],
      ),
    );

    if (result == true && context.mounted) {
      try {
        await ref
            .read(clientProposalControllerProvider.notifier)
            .rejectProposal(
              proposal.id,
              reason: reasonController.text,
            );
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Proposal rejected'),
              backgroundColor: Colors.red,
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

  Future<void> _showAcceptDialog(BuildContext context, WidgetRef ref) async {
    final result = await showDialog<bool>(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Accept Proposal'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const Text(
              'Are you sure you want to accept this proposal? This will:',
            ),
            const SizedBox(height: 8),
            const Text('• Reject all other proposals'),
            const Text('• Start the project with this constructor'),
            if (proposal.proposedCost > jobPost.budget)
              Padding(
                padding: const EdgeInsets.only(top: 8),
                child: Text(
                  'Note: Proposed cost (Rs.${proposal.proposedCost}) is higher than your budget (Rs.${jobPost.budget})',
                  style: const TextStyle(color: Colors.orange),
                ),
              ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context, false),
            child: const Text('Cancel'),
          ),
          TextButton(
            style: TextButton.styleFrom(foregroundColor: Colors.green),
            onPressed: () => Navigator.pop(context, true),
            child: const Text('Accept'),
          ),
        ],
      ),
    );

    if (result == true && context.mounted) {
      try {
        await ref
            .read(clientProposalControllerProvider.notifier)
            .acceptProposal(
              jobPost.id,
              proposal.id,
            );
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(
              content: Text('Proposal accepted'),
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
