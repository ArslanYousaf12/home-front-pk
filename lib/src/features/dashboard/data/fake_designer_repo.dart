import 'package:home_front_pk/src/constants/ktest_designer_list.dart';

import 'package:home_front_pk/src/features/dashboard/domain/designer.dart';

class FakeDesignerRepository {
  //private constructor so object can not be initiated outside
  // of this class
  FakeDesignerRepository._();

  //Singleton to solve the issue of
  //Dependancy Injection Problem
  //Changed later
  static FakeDesignerRepository instance = FakeDesignerRepository._();
  final List<DesignerIslamabad> _designerList = ktestDesigner;

  List<DesignerIslamabad> getConstructorList() {
    return _designerList;
  }

  //      Incase if we need Construcor bases of Id

  DesignerIslamabad? getProduct(String id) {
    try {
      return _designerList.firstWhere((designer) => designer.id == id);
    } catch (e) {
      return null;
    }
  }

  Future<List<DesignerIslamabad>> fetchProductList() {
    return Future.value(_designerList);
  }

  Stream<List<DesignerIslamabad>> watchProductList() {
    return Stream.value(_designerList);
  }

  // Getting constructor base on id

  Stream<DesignerIslamabad?> watchProduct(String id) {
    return watchProductList().map((designerList) =>
        designerList.firstWhere((designer) => designer.id == id));
  }
}
