// lib/src/features/requests/presentation/new_request_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:home_front_pk/src/features/offer_sent/presentation/offer_provider.dart';

final jobsStreamProvider = StreamProvider.autoDispose((ref) {
  return FirebaseFirestore.instance
      .collection('jobs')
      .where('status', isEqualTo: 'pending')
      .snapshots()
      .map((snapshot) => snapshot.docs);
});

class NewRequestScreen extends ConsumerWidget {
  const NewRequestScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final jobsStream = ref.watch(jobsStreamProvider);

    return Scaffold(
      appBar: AppBar(
        title: const Text('New Requests'),
        elevation: 0,
      ),
      body: jobsStream.when(
        data: (jobs) {
          if (jobs.isEmpty) {
            return const Center(
              child: Text('No new requests available'),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: jobs.length,
            itemBuilder: (context, index) {
              final job = jobs[index];
              final jobData = job.data();

              return JobRequestCard(
                jobId: job.id,
                title: jobData['title'] ?? 'Untitled',
                description: jobData['description'] ?? 'No description',
                location: jobData['location'] ?? 'No location',
                estimatedCost: jobData['estimatedCost']?.toString() ?? '0',
                userId: jobData['userId'] ?? '',
                onTapApply: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => OfferScreen(
                        jobId: job.id,
                        userId: jobData['userId'],
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
        loading: () => const Center(child: CircularProgressIndicator()),
        error: (error, stack) => Center(child: Text('Error: $error')),
      ),
    );
  }
}

class JobRequestCard extends StatelessWidget {
  final String jobId;
  final String title;
  final String description;
  final String location;
  final String estimatedCost;
  final String userId;
  final VoidCallback onTapApply;

  const JobRequestCard({
    required this.jobId,
    required this.title,
    required this.description,
    required this.location,
    required this.estimatedCost,
    required this.userId,
    required this.onTapApply,
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      margin: const EdgeInsets.only(bottom: 16),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              title,
              style: const TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 8),
            Text(
              description,
              style: TextStyle(
                color: Colors.grey[600],
              ),
            ),
            const SizedBox(height: 16),
            Row(
              children: [
                Icon(Icons.location_on, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(
                  location,
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(Icons.monetization_on, size: 16, color: Colors.grey[600]),
                const SizedBox(width: 4),
                Text(
                  'PKR $estimatedCost',
                  style: TextStyle(
                    color: Colors.grey[600],
                  ),
                ),
              ],
            ),
            const SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                TextButton(
                  onPressed: () {
                    // Show job details
                  },
                  child: const Text('View Details'),
                ),
                const SizedBox(width: 8),
                ElevatedButton(
                  onPressed: onTapApply,
                  child: const Text('Send Offer'),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
