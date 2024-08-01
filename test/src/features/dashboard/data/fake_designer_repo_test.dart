import 'package:flutter_test/flutter_test.dart';
import 'package:home_front_pk/src/constants/ktest_designer_list.dart';
import 'package:home_front_pk/src/features/dashboard/data/designer_repo/fake_designer_repo.dart';

void main() {
  FakeDesignerRepository makeDesignerRepository() =>
      FakeDesignerRepository(addDelay: false);

  group('Fake Designer Repository', () {
    test('getDesignerList return the global list', () {
      final designerRepository = makeDesignerRepository();
      expect(designerRepository.getDesignerList(), ktestDesigner);
    });
    test('getDesigner(1) return the first item', () {
      final designerRepository = makeDesignerRepository();
      expect(designerRepository.getDesigner('1'), ktestDesigner[0]);
    });
    test('getDesigner(100) return null', () {
      final designerRepository = makeDesignerRepository();
      expect(designerRepository.getDesigner('100'), null);
    });
    test('fetchDesignerList return global list', () async {
      final designerRepository = makeDesignerRepository();
      expect(await designerRepository.fetchDesignerList(), ktestDesigner);
    });
    test('watchDesignerList return the global List', () {
      final designerRepository = makeDesignerRepository();
      expect(designerRepository.watchDesignerList(), emits(ktestDesigner));
    });
    test('watchDesigner(1) return firstItem', () {
      final designerRepository = makeDesignerRepository();
      expect(designerRepository.watchDesigner('1'), emits(ktestDesigner[0]));
    });
    test('watchDesigner(100) return null', () {
      final designerRepository = makeDesignerRepository();
      expect(designerRepository.watchDesigner('100'), emits(null));
    });
  });
}
