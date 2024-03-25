import 'package:flutter/material.dart';
import 'package:home_front_pk/src/constants/ktest_designer_portfolio.dart';
import 'package:home_front_pk/src/features/portfolio/presentation/custom_portfolio.dart';

class DesignerPortfolio extends StatelessWidget {
  const DesignerPortfolio({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Using the PortfolioPage widget to display designer's portfolio
    return PortfolioPage(
      title: 'Designer Portfolio',
      portfolioItems: designerPortfolioItems,
      emptyPortfolioMessage: 'No portfolio items found. Try to add some.',
    );
  }
}
