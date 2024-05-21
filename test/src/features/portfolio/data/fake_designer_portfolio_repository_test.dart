import 'package:flutter_test/flutter_test.dart';
import 'package:home_front_pk/src/constants/ktest_designer_portfolio.dart';
import 'package:home_front_pk/src/features/portfolio/data/fake_designer_portfolio_repository.dart';

void main() {
  FakeDesignerPortfolioRepository makeRepoPortfolio() =>
      FakeDesignerPortfolioRepository(addDelay: false);

  group('Fake Designer portfolio repo', () {
    test('getPortfolioList return global list', () {
      final designerPortfolioRepo = makeRepoPortfolio();
      expect(designerPortfolioRepo.getPortfolioList(), designerPortfolioItems);
    });
    test('getPortfolio(1) return first item', () {
      final designerPortfolioRepo = makeRepoPortfolio();
      expect(
          designerPortfolioRepo.getPortfolio('1'), designerPortfolioItems[0]);
    });
    test('getPortfolio(100) return null', () {
      final designerPortfolioRepo = makeRepoPortfolio();
      expect(designerPortfolioRepo.getPortfolio('100'), null);
    });
    test('fetchPortfolioList return global list', () async {
      final designerPortfolioRepo = makeRepoPortfolio();
      expect(await designerPortfolioRepo.fetchPortfolioList(),
          designerPortfolioItems);
    });
    test('watchPortfolioList return global list', () {
      final designerPortfolioRepo = makeRepoPortfolio();
      expect(designerPortfolioRepo.watchPortfolioList(),
          emits(designerPortfolioItems));
    });
    test('watchPortfolio(1) return first item', () {
      final designerPortfolioRepo = makeRepoPortfolio();
      expect(designerPortfolioRepo.watchPortfolio('1'),
          emits(designerPortfolioItems[0]));
    });
    test('watchPortfolio(100) return null', () {
      final designerPortfolioRepo = makeRepoPortfolio();
      expect(designerPortfolioRepo.watchPortfolio('100'), emits(null));
    });
  });
}
