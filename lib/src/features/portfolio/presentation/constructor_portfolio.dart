import 'package:flutter/widgets.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_front_pk/src/common_widgets/async_value_widget.dart';
import 'package:home_front_pk/src/features/portfolio/data/fake_constructor_portfolio_repository.dart';
import 'package:home_front_pk/src/features/portfolio/presentation/custom_portfolio.dart';

class ConstructorPortfolio extends ConsumerWidget {
  const ConstructorPortfolio({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final constructorPortfolioValue =
        ref.watch(constructorListPortfolioStreamProvider);
    return AsyncValueWidget(
      value: constructorPortfolioValue,
      data: (constructorPortfolio) => PortfolioPage(
        title: 'Constructor Portfolio',
        portfolioItems: constructorPortfolio,
        emptyPortfolioMessage: 'No portfolio items found. Try to add some.',
      ),
    );
  }
}
