import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_front_pk/src/common_widgets/async_value_widget.dart';
import 'package:home_front_pk/src/common_widgets/talent_detailed_widget.dart';
import 'package:home_front_pk/src/features/dashboard/data/constructor_repo/constructor_repository.dart';
import 'package:home_front_pk/src/features/dashboard/data/constructor_repo/fake_constructor_repo.dart';

class ConstructorDetailedScreen extends ConsumerWidget {
  const ConstructorDetailedScreen({super.key, required this.constructorId});
  final String constructorId;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final constructorvalue = ref.watch(constructorProvider(constructorId));
    return AsyncValueWidget(
      value: constructorvalue,
      data: (constructor) => Scaffold(
        body: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(top: 90, left: 20, right: 20),
            child: TalentDetailedWidget(
              imageUrl: constructor!.imageUrl,
              name: constructor.name,
              title: constructor.title,
              description: constructor.detail,
              onpressed: () {},
            ),
          ),
        ),
      ),
    );
  }
}
