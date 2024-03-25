import 'package:flutter/foundation.dart';
import 'package:flutter/widgets.dart';
import 'package:home_front_pk/src/constants/ktest_constructor_portfolio.dart';
import 'package:home_front_pk/src/features/portfolio/presentation/custom_portfolio.dart';

class ConstructorPortfolio extends StatelessWidget {
  const ConstructorPortfolio({super.key});

  @override
  Widget build(BuildContext context) {
    return PortfolioPage(
      title: 'Constructor Portfolio',
      portfolioItems: constructorPortfolioItems,
      emptyPortfolioMessage: 'No portfolio items found. Try to add some.',
    );
  }
}
