import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_front_pk/src/common_widgets/async_value_widget.dart';
import 'package:home_front_pk/src/common_widgets/request_card.dart';
import 'package:home_front_pk/src/constants/app_sizes.dart';
import 'package:home_front_pk/src/features/new_requests/data/fake_construction_request_repository.dart';

class NewRequest extends ConsumerWidget {
  const NewRequest({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final newRequests = ref.watch(constructionRequestListStreamProvider);
    return AsyncValueWidget(
      value: newRequests,
      data: (requests) {
        if (requests.isEmpty) {
          return Scaffold(
            appBar: AppBar(
              title: const Text('New Requests'),
            ),
            body: const Center(
              child: Text(
                'No New Request',
                style: TextStyle(fontSize: 17),
              ),
            ),
          );
        }
        return Scaffold(
          appBar: AppBar(
            title: const Text('New Requests'),
          ),
          body: ListView.separated(
            itemCount: requests.length,
            itemBuilder: (context, index) {
              final newrequest = requests[index];
              return NewRequestCard(
                id: newrequest.id,
                title: newrequest.title,
                name: newrequest.name,
                location: newrequest.location,
              );
            },
            separatorBuilder: (context, index) {
              return gapH4;
            },
          ),
        );
      },
    );
  }
}
