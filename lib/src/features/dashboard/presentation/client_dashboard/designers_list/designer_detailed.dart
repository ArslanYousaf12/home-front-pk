import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_front_pk/src/common_widgets/alert_dialogs.dart';
import 'package:home_front_pk/src/common_widgets/async_value_widget.dart';
import 'package:home_front_pk/src/common_widgets/talent_detailed_widget.dart';
import 'package:home_front_pk/src/features/dashboard/data/designer_repo/fake_designer_repo.dart';
import 'package:home_front_pk/src/features/dashboard/domain/designer.dart';

class DesignerDetailedScreen extends ConsumerWidget {
  const DesignerDetailedScreen({super.key, required this.designerId});

  final String designerId;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final designerValue = ref.watch(designerProvider(designerId));
    return AsyncValueWidget<DesignerIslamabad?>(
      value: designerValue,
      data: (desiner) => Scaffold(
        body: SizedBox(
          width: double.infinity,
          child: Padding(
            padding: const EdgeInsets.only(top: 90, left: 20, right: 20),
            child: TalentDetailedWidget(
              imageUrl: desiner!.imageUrl,
              name: desiner.name,
              title: desiner.title,
              description: desiner.detail,
              onpressed: () {
                showNotImplementedAlertDialog(context: context);
              },
            ),
          ),
        ),
      ),
    );
  }
}
