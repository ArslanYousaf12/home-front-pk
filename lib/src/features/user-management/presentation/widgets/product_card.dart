import 'package:flutter/material.dart';

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_front_pk/src/common_widgets/custom_image.dart';
import 'package:home_front_pk/src/common_widgets/custom_image_network.dart';
import 'package:home_front_pk/src/constants/app_sizes.dart';
import 'package:home_front_pk/src/features/dashboard/domain/constructor.dart';
import 'package:home_front_pk/src/utils/currency_formatter%20copy.dart';

/// Used to show a single product inside a card.
class ProductCard extends ConsumerWidget {
  const ProductCard({super.key, required this.product, this.onPressed});
  final ConstructorIslamabad product;
  final VoidCallback? onPressed;

  // * Keys for testing using find.byKey()
  static const productCardKey = Key('product-card');

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // final priceFormatted = ref.watch(currencyFormatterProvider).format(product);
    return Card(
      child: InkWell(
        key: productCardKey,
        onTap: onPressed,
        child: Padding(
          padding: const EdgeInsets.all(Sizes.p16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              CustomImageNetwork(
                imageUrl: product.imageUrl,
              ),
              gapH8,
              const Divider(),
              gapH8,
              Text(
                product.title,
                style: Theme.of(context).textTheme.titleLarge,
              ),
              // if (product.numRatings >= 1) ...[
              gapH8,
              Text(
                product.name,
                style: Theme.of(context).textTheme.bodySmall!.copyWith(
                      color: Theme.of(context).colorScheme.secondary,
                    ),
              ),
              // ProductAverageRating(product: product),
              // ],
              gapH24,
              Text(product.detail,
                  style: Theme.of(context).textTheme.bodyMedium),
              gapH4,
            ],
          ),
        ),
      ),
    );
  }
}
