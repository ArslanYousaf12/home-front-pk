import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:home_front_pk/src/constants/ktest_constructor_portfolio.dart'; // Assuming you have a similar constants file

import 'package:home_front_pk/src/features/portfolio/domain/portfolio_item.dart'; // Assuming you have a domain model

class FakeConstructorPortfolioRepository {
  final List<PortfolioItem> _portfolios =
      constructorPortfolioItems; // Assuming this is your data source

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
        return portfolioList.firstWhere((portfolio) => portfolio.id == id);
      } catch (e) {
        return null;
      }
    });
  }
}

final constructorPortfolioRepositoryProvider =
    Provider<FakeConstructorPortfolioRepository>((ref) {
  return FakeConstructorPortfolioRepository();
});

final constructorListPortfolioStreamProvider =
    StreamProvider.autoDispose<List<PortfolioItem>>((ref) {
  final portfolioRepository = ref.watch(constructorPortfolioRepositoryProvider);
  return portfolioRepository.watchPortfolioList();
});

final constructorListPortfolioFutureProvider =
    FutureProvider.autoDispose<List<PortfolioItem>>((ref) {
  final portfolioRepository = ref.watch(constructorPortfolioRepositoryProvider);
  return portfolioRepository.fetchPortfolioList();
});

final constructorPortfolioProvider =
    StreamProvider.autoDispose.family<PortfolioItem?, String>((ref, id) {
  final portfolioRepository = ref.watch(constructorPortfolioRepositoryProvider);
  return portfolioRepository.watchPortfolio(id);
});
