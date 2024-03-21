import 'package:home_front_pk/src/constants/ktest_constructor_card.dart';
import 'package:home_front_pk/src/features/dashboard/domain/constructor.dart';

class FakeConstructorRepository {
  //private constructor so object can not be initiated outside
  // of this class
  FakeConstructorRepository._();

  //Singleton to solve the issue of
  //Dependancy Injection Problem
  //Changed later
  static FakeConstructorRepository instance = FakeConstructorRepository._();
  final List<ConstructorIslamabad> _constructorList = ktestConstructor;

  List<ConstructorIslamabad> getConstructorList() {
    return _constructorList;
  }

  //      Incase if we need Construcor bases of Id

  ConstructorIslamabad? getConstructor(String id) {
    try {
      return _constructorList.firstWhere((constructor) => constructor.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<List<ConstructorIslamabad>> fetchConstructorist() {
    return Future.value(_constructorList);
  }

  Stream<List<ConstructorIslamabad>> watchConstructorList() {
    return Stream.value(_constructorList);
  }

  // Getting constructor base on id

  Stream<ConstructorIslamabad?> watchConstructor(String id) {
    return watchConstructorList().map((constructorList) =>
        constructorList.firstWhere((constructor) => constructor.id == id));
  }
}
