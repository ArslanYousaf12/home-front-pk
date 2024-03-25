import 'package:flutter/material.dart';
import 'package:home_front_pk/src/common_widgets/custom_image.dart';
import 'package:home_front_pk/src/common_widgets/responsive_scrollable_card.dart';
import 'package:home_front_pk/src/constants/app_sizes.dart';
import 'package:home_front_pk/src/features/portfolio/domain/portfolio_item.dart';

class PortfolioPage extends StatelessWidget {
  final String title;
  final List<PortfolioItem> portfolioItems;
  final String emptyPortfolioMessage;
  final VoidCallback? addPortfolio;

  const PortfolioPage({
    super.key,
    required this.title,
    required this.portfolioItems,
    this.emptyPortfolioMessage = 'No Portfolio. Try to add some.',
    this.addPortfolio,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: InkWell(
          onTap: addPortfolio,
          child: const Icon(
            Icons.add,
            size: 28,
          ),
        ),
        title: Text(
          title,
          style: const TextStyle(fontSize: 20),
        ),
      ),
      body: portfolioItems.isEmpty
          ? Center(
              child: Text(
                emptyPortfolioMessage,
                style: const TextStyle(fontSize: 15),
              ),
            )
          : ListView.builder(
              itemCount: portfolioItems.length,
              itemBuilder: (context, index) {
                final item = portfolioItems[index];
                return ResponsiveScrollableCard(
                  child: Column(
                    children: [
                      CustomImage(
                        imageUrl: item.imageUrl,
                        width: 200,
                        height: 200,
                      ),
                      Text(
                        item.title,
                        style: const TextStyle(
                            color: Colors.black54, fontSize: 20),
                      ),
                      gapH12,
                      Text(
                        item.description,
                        textAlign: TextAlign.center,
                        style: const TextStyle(color: Colors.black),
                      )
                    ],
                  ),
                );
              },
            ),
    );
  }
}
