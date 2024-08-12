import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:home_front_pk/src/features/user-management/presentation/widgets/sliver_products_grid.dart';
import 'package:home_front_pk/src/localization/string_hardcoded.dart';
import 'package:home_front_pk/src/routing/app_router.dart';

/// Used to add or edit products
class AdminProductsScreen extends ConsumerWidget {
  const AdminProductsScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(title: Text('Manage Seller'.hardcoded)),
      body: CustomScrollView(
        slivers: [
          SliverProductsGrid(
            onPressed: (context, constructorid) => context.goNamed(
              AppRoute.adminEditProduct.name,
              pathParameters: {'id': constructorid},
            ),
          ),
        ],
      ),
      floatingActionButton: FloatingActionButton(
        child: const Icon(Icons.add),
        onPressed: () => context.goNamed(AppRoute.adminAdd.name),
      ),
    );
  }
}
