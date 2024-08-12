import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:home_front_pk/src/common_widgets/async_value_widget.dart';
import 'package:home_front_pk/src/features/dashboard/domain/constructor.dart';
import 'package:home_front_pk/src/features/user-management/data/template_products_providers.dart';
import 'package:home_front_pk/src/features/user-management/presentation/widgets/product_card.dart';
import 'package:home_front_pk/src/features/user-management/presentation/widgets/sliver_products_grid.dart';
import 'package:home_front_pk/src/localization/string_hardcoded.dart';
import 'package:home_front_pk/src/routing/app_router.dart';

/// Used to select a product to add from a template of available options
class AdminProductsAddScreen extends ConsumerWidget {
  const AdminProductsAddScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Add a seller'.hardcoded),
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          ColoredBox(
            color: Colors.grey.shade400,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                'Choose a seller from template'.hardcoded,
                textAlign: TextAlign.center,
              ),
            ),
          ),
          const Expanded(
            child: CustomScrollView(
              slivers: [
                // Choose from template
                ProductsTemplateGrid(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

/// A widget used to show all the template products
class ProductsTemplateGrid extends ConsumerWidget {
  const ProductsTemplateGrid({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // * Note: loading from the  "template" products provider
    final productsListValue = ref.watch(templateConstructorsListProvider);
    debugPrint('productsListValue: ${productsListValue.asData?.value}');
    return AsyncValueSliverWidget<List<ConstructorIslamabad>>(
        value: productsListValue,
        data: (products) {
          debugPrint('products 12: $products');
          return SliverProductsAlignedGrid(
            itemCount: products.length,
            itemBuilder: (_, index) {
              final product = products[index];
              debugPrint('product checking: $product');
              return ProductCard(
                product: product,
                onPressed: () => context.goNamed(
                  AppRoute.adminUploadProduct.name,
                  pathParameters: {'id': product.id},
                ),
              );
            },
          );
        });
  }
}
