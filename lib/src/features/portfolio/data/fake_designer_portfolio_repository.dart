// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:home_front_pk/src/constants/ktest_designer_portfolio.dart';
import 'package:home_front_pk/src/features/portfolio/domain/portfolio_item.dart';
import 'package:home_front_pk/src/utils/delay.dart';

class FakeDesignerPortfolioRepository {
  bool addDelay;
  FakeDesignerPortfolioRepository({
    this.addDelay = true,
  });
  final List<PortfolioItem> _portfolios = designerPortfolioItems;

  List<PortfolioItem> getPortfolioList() {
    return _portfolios;
  }

  PortfolioItem? getPortfolio(String id) {
    return _getPortfolio(_portfolios, id);
  }

  Future<List<PortfolioItem>> fetchPortfolioList() async {
    await delay(addDelay);
    return Future.value(_portfolios);
  }

  Stream<List<PortfolioItem>> watchPortfolioList() async* {
    await delay(addDelay);
    yield _portfolios;
  }

  Stream<PortfolioItem?> watchPortfolio(String id) {
    return watchPortfolioList().map((portfolioList) {
      return _getPortfolio(portfolioList, id);
    });
  }

  static PortfolioItem? _getPortfolio(
      List<PortfolioItem> portfolios, String id) {
    try {
      // Attempt to find the first portfolio that matches the ID
      return portfolios.firstWhere((portfolio) => portfolio.id == id);
    } catch (e) {
      // If no match is found, return null
      return null;
    }
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
