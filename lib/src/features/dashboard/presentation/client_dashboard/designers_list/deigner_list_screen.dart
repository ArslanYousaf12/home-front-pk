import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:home_front_pk/src/common_widgets/async_value_widget.dart';
import 'package:home_front_pk/src/common_widgets/custom_talent_card.dart';
import 'package:home_front_pk/src/constants/app_sizes.dart';
import 'package:home_front_pk/src/features/dashboard/data/designer_repo/fake_designer_repo.dart';
import 'package:home_front_pk/src/routing/app_router.dart';

class DesignerListScreen extends ConsumerWidget {
  const DesignerListScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final designersRepository = ref.watch(designerRepositoryProvider);
    // final designers = designersRepository.getConstructorList();
    final designerValue = ref.watch(designersListStreamProvider);
    return AsyncValueWidget(
      value: designerValue,
      data: (designers) => Scaffold(
        appBar: AppBar(
          title: const Text('Designers'),
          // backgroundColor: const Color(0xFFF6F7C4),
        ),
        body: Padding(
          padding: const EdgeInsets.all(30.0),
          child: ListView.separated(
            itemCount: designers.length,
            itemBuilder: (context, index) {
              final designer = designers[index];
              return CustomTalentCard(
                title: designer.title,
                icon: designer.icon,
                description: designer.detail,
                onPressed: () {
                  context.goNamed(AppRoute.designerDetailed.name,
                      pathParameters: {'id': designer.id});
                },
              );
            },
            separatorBuilder: (context, index) {
              return gapH12;
            },
          ),
        ),
      ),
    );
  }
}
