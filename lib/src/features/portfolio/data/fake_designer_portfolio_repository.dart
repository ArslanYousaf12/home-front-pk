import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_front_pk/src/constants/ktest_designer_portfolio.dart';

import 'package:home_front_pk/src/features/portfolio/domain/portfolio_item.dart';

class FakeDesignerPortfolioRepository {
  final List<PortfolioItem> _portfolios = designerPortfolioItems;

  List<PortfolioItem> getPortfolioList() {
    return _portfolios;
  }

  PortfolioItem? getPortfolio(String id) {
    try {
      return _portfolios.firstWhere((portfolio) => portfolio.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<List<PortfolioItem>> fetchPortfolioList() {
    return Future.value(_portfolios);
  }

  Stream<List<PortfolioItem>> watchPortfolioList() {
    return Stream.value(_portfolios);
  }

  Stream<PortfolioItem?> watchPortfolio(String id) {
    return watchPortfolioList().map((portfolioList) {
      try {
        // Attempt to find the first portfolio that matches the ID
        return portfolioList.firstWhere((portfolio) => portfolio.id == id);
      } catch (e) {
        // If no match is found, return null
        return null;
      }
    });
  }
}

final designerPorfolioRepositoryProvider =
    Provider<FakeDesignerPortfolioRepository>((ref) {
  return FakeDesignerPortfolioRepository();
});

final designerListPortfolioStreamProvider =
    StreamProvider.autoDispose<List<PortfolioItem>>((ref) {
  final portfolioRepository = ref.watch(designerPorfolioRepositoryProvider);
  return portfolioRepository.watchPortfolioList();
});

final designerListPortfolioFutureProvider =
    FutureProvider.autoDispose<List<PortfolioItem>>((ref) {
  final portfolioRepository = ref.watch(designerPorfolioRepositoryProvider);
  return portfolioRepository.fetchPortfolioList();
});

final designerPortfolioProvider =
    StreamProvider.autoDispose.family<PortfolioItem?, String>((ref, id) {
  final portfolioRepository = ref.watch(designerPorfolioRepositoryProvider);
  return portfolioRepository.watchPortfolio(id);
});
