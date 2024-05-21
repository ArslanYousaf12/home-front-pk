// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'package:home_front_pk/src/constants/ktest_constructor_portfolio.dart'; // Assuming you have a similar constants file
import 'package:home_front_pk/src/features/portfolio/domain/portfolio_item.dart';
import 'package:home_front_pk/src/utils/delay.dart'; // Assuming you have a domain model

class FakeConstructorPortfolioRepository {
  FakeConstructorPortfolioRepository({
    this.addDelay = true,
  });
  bool addDelay;
  final List<PortfolioItem> _portfolios =
      constructorPortfolioItems; // Assuming this is your data source

  List<PortfolioItem> getPortfolioList() {
    return _portfolios;
  }

  PortfolioItem? getPortfolio(String id) {
    return _getPortfolioItem(_portfolios, id);
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
      return _getPortfolioItem(portfolioList, id);
    });
  }

  static PortfolioItem? _getPortfolioItem(
      List<PortfolioItem> portfolios, String id) {
    try {
      return portfolios.firstWhere((portfolio) => portfolio.id == id);
    } catch (e) {
      return null;
    }
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
