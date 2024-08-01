import 'package:flutter_test/flutter_test.dart';
import 'package:home_front_pk/src/constants/ktest_constructor_card.dart';
import 'package:home_front_pk/src/features/dashboard/data/constructor_repo/fake_constructor_repo.dart';

void main() {
  FakeConstructorRepository makeConstructorRepository() {
    return FakeConstructorRepository(addDelay: false);
  }

  group('Fake Constructor repo', () {
    test('getConstructorList return global list', () {
      final constructorRepository = makeConstructorRepository();
      expect(constructorRepository.getConstructorList(), ktestConstructor);
    });
    test('getConstructor(1) return first item', () {
      final constructorRepository = makeConstructorRepository();
      expect(constructorRepository.getConstructor('1'), ktestConstructor[0]);
    });
    test('getConstructor(100) return null', () {
      final constructorRepository = makeConstructorRepository();
      expect(constructorRepository.getConstructor('100'), null);
    });
    test('fetchConstructorList return global list', () async {
      final constructorRepository = makeConstructorRepository();
      expect(
          await constructorRepository.fetchConstructorList(), ktestConstructor);
    });
    test('watchConstructorList return global list', () {
      final constructorRepository = makeConstructorRepository();
      expect(constructorRepository.watchConstructorList(),
          emits(ktestConstructor));
    });
    test('watchConstructor(1) return first Item', () {
      final constructorRepository = makeConstructorRepository();
      expect(constructorRepository.watchConstructor('1'),
          emits(ktestConstructor[0]));
    });
    test('watchConstructor(100) return null', () {
      final constructorRepository = makeConstructorRepository();
      expect(constructorRepository.watchConstructor('100'), emits(null));
    });
  });
}
