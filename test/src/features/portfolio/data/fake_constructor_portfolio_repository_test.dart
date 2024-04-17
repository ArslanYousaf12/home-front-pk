import 'package:flutter_test/flutter_test.dart';
import 'package:home_front_pk/src/constants/ktest_constructor_portfolio.dart';
import 'package:home_front_pk/src/features/portfolio/data/fake_constructor_portfolio_repository.dart';

void main() {
  FakeConstructorPortfolioRepository constructorPortfolioRepo() =>
      FakeConstructorPortfolioRepository(addDelay: false);
  group('Fake constructor portfolio repository', () {
    test('getPortfolioList return the global list', () {
      final portfolioRepo = constructorPortfolioRepo();
      expect(portfolioRepo.getPortfolioList(), constructorPortfolioItems);
    });
    test('getPortfolio(1) return firstItem', () {
      final portfolioRepo = constructorPortfolioRepo();
      expect(portfolioRepo.getPortfolio('1'), constructorPortfolioItems[0]);
    });
    test('getPortfolio(100) return null', () {
      final portfolioRepo = constructorPortfolioRepo();
      expect(portfolioRepo.getPortfolio('100'), null);
    });
    test('fetchPortfolioList return global list', () async {
      final portfolioRepo = constructorPortfolioRepo();
      expect(
          await portfolioRepo.fetchPortfolioList(), constructorPortfolioItems);
    });
    test('watchPortfolioList return global list', () {
      final portfolioRepo = constructorPortfolioRepo();
      expect(
          portfolioRepo.watchPortfolioList(), emits(constructorPortfolioItems));
    });
    test('watchPortfolio(1) return firstItem', () {
      final portfolioRepo = constructorPortfolioRepo();
      expect(portfolioRepo.watchPortfolio('1'),
          emits(constructorPortfolioItems[0]));
    });
    test('getPortfolio(100) return null', () {
      final portfolioRepo = constructorPortfolioRepo();
      expect(portfolioRepo.watchPortfolio('100'), emits(null));
    });
  });
}
