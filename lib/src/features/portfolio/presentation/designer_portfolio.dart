import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_front_pk/src/common_widgets/async_value_widget.dart';
import 'package:home_front_pk/src/features/portfolio/data/fake_designer_portfolio_repository.dart';
import 'package:home_front_pk/src/features/portfolio/presentation/custom_portfolio.dart';

class DesignerPortfolio extends ConsumerWidget {
  const DesignerPortfolio({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final designerPortfolioValue =
        ref.watch(designerListPortfolioStreamProvider);
    return AsyncValueWidget(
      value: designerPortfolioValue,
      data: (designerPortfolio) => PortfolioPage(
        title: 'Designer Portfolio',
        portfolioItems: designerPortfolio,
        emptyPortfolioMessage: 'No portfolio items found. Try to add some.',
      ),
    );
    // Using the PortfolioPage widget to display designer's portfolio
  }
}
